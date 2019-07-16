#!/usr/bin/env node

const { resolve, basename } = require('path')

const x = require('x-ray')()
const yargs = require('yargs').argv
const { outputFile } = require('fs-extra')

const DEFAULT_TARGET_URL = 'https://erikflowers.github.io/weather-icons/'
const DEFAULT_FILE_NAME = 'weather_icon.dart'

const targetUrl = yargs.u || yargs.url || DEFAULT_TARGET_URL
const verbose = yargs.v || yargs.verbose || false
const print = yargs.p || yargs.print || false
const output = yargs.o || yargs.output
const filename = yargs.f || yargs.filename || DEFAULT_FILE_NAME

const resolvedOutput = output ? resolve(output) : undefined

start().catch(err => console.error(`Unhandled error: ${err}`))

async function start() {
  if (!print && !resolvedOutput) {
    printUsage()
    return process.exit(1)
  }

  console.log('WeatherIcons scraper')
  if (verbose) {
    console.log(`Target URL: ${targetUrl}`)
    console.log(`Print: ${print ? 'yes' : 'no'}`)
    if (resolvedOutput) console.log(`Output Path: ${resolvedOutput}`)
    console.log(`Filename: ${filename}`)
  }

  console.log(`Scraping: ${targetUrl}`)
  const rawIcons = await getIconData()
  console.log(`Scraped ${rawIcons.length} icons`)

  const generatedDartFile = generateDartFile(rawIcons)
  if (print) {
    console.log('Generated file:')
    console.log(generatedDartFile)
  }

  if (output) {
    await writeFile(generatedDartFile)
  }
}

async function getIconData() {
  try {
    const result = await scrapeIconData()
    if (verbose) {
      result.forEach(({ title, code }) => console.log(`\t${title} => ${code}`))
    }

    return result.map(({ title, code }) => ({
      title: title.trim().replace(/-/g, '_'),
      code: code.trim(),
    }))
  } catch (error) {
    console.error('Unable to scrape icon data!')
    console.error(error)
    process.exit(1)
  }
}

async function scrapeIconData() {
  const result = await scrape(targetUrl)
  const filtered = result.reduce(
    (prev, curr) => {
      const isDupe = prev.icons.find(x => x.title === curr.title)
      if (verbose && isDupe)
        console.log(`Found duplicate: ${curr.title} => ${curr.code}`)
      isDupe ? prev.duplicates.push(curr) : prev.icons.push(curr)
      return prev
    },
    { icons: [], duplicates: [] },
  )

  if (filtered.duplicates.length)
    console.log(`Found ${filtered.duplicates.length} duplicates.`)

  return filtered.icons
}

function generateIcon(title, code) {
  const icon = `static const IconData ${title} = const _WeatherIconData(0x${code});`
  if (verbose) console.log(`Generating: ${icon}`)
  return icon
}

function generateDartFile(iconData) {
  const icons = iconData
    .map(({ title, code }) => generateIcon(title, code))
    .join('\n  ')
  return `
import 'package:flutter/material.dart';

/// This file is auto-generated by the '${basename(
    __filename,
  )}' script, and should not be modified by hand.
/// See the README.md for more information.
/// Generated on ${new Date()}

/// All of WeatherIcons in the form of static [IconData] variables.
class WeatherIcon {
  ${icons}
}

class _WeatherIconData extends IconData {
  const _WeatherIconData(int value)
      : super(
          value,
          fontFamily: 'WeatherIcons',
          fontPackage: 'flutter_weather_icons',
        );
}
  `.trim()
}

async function writeFile(dartCode) {
  try {
    const filepath = resolve(resolvedOutput, filename)
    console.log(`Writing to ${filepath}`)
    await outputFile(filepath, dartCode)
  } catch (error) {
    console.error('Unable to write dart file!')
    console.error(error)
    process.exit(1)
  }
}

function printUsage() {
  console.log(`Usage: scrape_icons.js [options]

  Scrapper for erikflowers/weather-icons.

  Options:

    --url (-u)      Provide a custom url to scrape     (default: 'https://erikflowers.github.io/weather-icons/')
    --verbose (-v)  Log extra information to stdout    (default: false)
    --print (-p)    Print the result to stdout         (default: false)
    --output (-o)   File path to output the result too
    --filename (-f) Name of the file to generate       (default: weather_icon.dart)

  Either '--output' or '--print' is required!
  `)
}

function scrape(url) {
  return x(url, '.icon-wrap', [
    { title: '.icon-name', code: '.icon_unicode' },
  ]).then()
}
