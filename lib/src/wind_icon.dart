import 'package:flutter/material.dart';

import 'package:weather_icons/weather_icons.dart';

import 'package:weather_icons/src/util/rotate.dart';

/// Create a rotated 'wind' [Icon] using an [degree] between 0-360.
///
/// Use the static presets, or instantiate [WindIcon] with an [degree].
///
/// Example:
///
///     // Using custom degree between 0-360
///     IconButton(
///       icon: WindIcon(degree: 45),
///       onPressed: () { }
///     );
///
///     // Using a preset degree
///     IconButton(
///       icon: WindIcon.towards_ne,
///       onPressed: () { }
///     );
class WindIcon extends BoxedIcon {
  final num degree;

  const WindIcon({
    required this.degree,
    Key? key,
    double? size,
    Color? color,
  })  : assert(degree >= 0 && degree <= 360),
        super(
          WeatherIcons.wind,
          key: key,
          size: size,
          color: color,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Rotate(
        degree: degree,
        child: super.build(context),
      ),
    );
  }

  // Towards

  /// [WindIcon] for pointing towards  **North**.
  static const towards_n = WindIcon(degree: 0);

  /// [WindIcon] for pointing towards  **North by North-East**.
  static const towards_nne = WindIcon(degree: 22.5);

  /// [WindIcon] for pointing towards  **North-East**.
  static const towards_ne = WindIcon(degree: 45);

  /// [WindIcon] for pointing towards  **East by North-East**.
  static const towards_ene = WindIcon(degree: 67.5);

  /// [WindIcon] for pointing towards  **East**.
  static const towards_e = WindIcon(degree: 90);

  /// [WindIcon] for pointing towards  **Easy by South-East**.
  static const towards_ese = WindIcon(degree: 112.5);

  /// [WindIcon] for pointing towards  **South-East**.
  static const towards_se = WindIcon(degree: 135);

  /// [WindIcon] for pointing towards  **South by South-East**.
  static const towards_sse = WindIcon(degree: 157.5);

  /// [WindIcon] for pointing towards  **South**.
  static const towards_s = WindIcon(degree: 180);

  /// [WindIcon] for pointing towards  **South by South-West**.
  static const towards_ssw = WindIcon(degree: 202.5);

  /// [WindIcon] for pointing towards  **South-West**.
  static const towards_sw = WindIcon(degree: 225);

  /// [WindIcon] for pointing towards  **West by South-West**.
  static const towards_wsw = WindIcon(degree: 247.5);

  /// [WindIcon] for pointing towards  **West**.
  static const towards_w = WindIcon(degree: 270);

  /// [WindIcon] for pointing towards  **West by North-West**.
  static const towards_wnw = WindIcon(degree: 292.5);

  /// [WindIcon] for pointing towards  **North-West**.
  static const towards_nw = WindIcon(degree: 315);

  /// [WindIcon] for pointing towards  **North by North-West**.
  static const towards_nnw = WindIcon(degree: 337.5);

  // From

  /// [WindIcon] for pointing from  **North**.
  static const from_n = WindIcon(degree: 360);

  /// [WindIcon] for pointing from  **North by North-East**.
  static const from_nne = WindIcon(degree: 337.5);

  /// [WindIcon] for pointing from  **North-East**.
  static const from_ne = WindIcon(degree: 315);

  /// [WindIcon] for pointing from  **East by North-East**.
  static const from_ene = WindIcon(degree: 292.5);

  /// [WindIcon] for pointing from  **East**.
  static const from_e = WindIcon(degree: 270);

  /// [WindIcon] for pointing from  **East by South-East**.
  static const from_ese = WindIcon(degree: 247.5);

  /// [WindIcon] for pointing from  **South-East**.
  static const from_se = WindIcon(degree: 225);

  /// [WindIcon] for pointing from  **South by South-East**.
  static const from_sse = WindIcon(degree: 202.5);

  /// [WindIcon] for pointing from  **South**.
  static const from_s = WindIcon(degree: 180);

  /// [WindIcon] for pointing from  **South by South-West**.
  static const from_ssw = WindIcon(degree: 157.5);

  /// [WindIcon] for pointing from  **South-West**.
  static const from_sw = WindIcon(degree: 135);

  /// [WindIcon] for pointing from  **West by South-West**.
  static const from_wsw = WindIcon(degree: 112.5);

  /// [WindIcon] for pointing from  **West**.
  static const from_w = WindIcon(degree: 90);

  /// [WindIcon] for pointing from  **West by North-West**.
  static const from_wnw = WindIcon(degree: 67.5);

  /// [WindIcon] for pointing from  **North-West**.
  static const from_nw = WindIcon(degree: 45);

  /// [WindIcon] for pointing from  **North by North-West**.
  static const from_nnw = WindIcon(degree: 22.5);

  static WindIcon fromString(
    String name, {
    WindIcon? fallback,
  }) {
    final target = name.replaceAll('_', '-');
    final icon = _all[target];

    if (icon != null) {
      return icon;
    } else if (fallback != null) {
      return fallback;
    } else {
      throw UnsupportedError('Unsupported icon $name, with no fallback');
    }
  }

  static const Map<String, WindIcon> _all = {
    // Towards

    "towards-n": towards_n,

    "towards-nne": towards_nne,

    "towards-ne": towards_ne,

    "towards-ene": towards_ene,

    "towards-e": towards_e,

    "towards-ese": towards_ese,

    "towards-se": towards_se,

    "towards-sse": towards_sse,

    "towards-s": towards_s,

    "towards-ssw": towards_ssw,

    "towards-sw": towards_sw,

    "towards-wsw": towards_wsw,

    "towards-w": towards_w,

    "towards-wnw": towards_wnw,

    "towards-nw": towards_nw,

    "towards-nnw": towards_nnw,

    // From

    // from_n = WindIcon(degree: 360);

    // from_nne = WindIcon(degree: 337.5);

    // from_ne = WindIcon(degree: 315);

    // from_ene = WindIcon(degree: 292.5);

    // from_e = WindIcon(degree: 270);

    // from_ese = WindIcon(degree: 247.5);

    // from_se = WindIcon(degree: 225);

    // from_sse = WindIcon(degree: 202.5);

    // from_s = WindIcon(degree: 180);

    // from_ssw = WindIcon(degree: 157.5);

    // from_sw = WindIcon(degree: 135);

    // from_wsw = WindIcon(degree: 112.5);

    // from_w = WindIcon(degree: 90);

    // from_wnw = WindIcon(degree: 67.5);

    // from_nw = WindIcon(degree: 45);

    // from_nnw = WindIcon(degree: 22.5);
  };
}
