import 'package:flutter/material.dart';

import 'theme_light.dart';

class BKTheme {
  BKTheme._();

  static const String fontFamily = "PingFang SC";
  static const List<String> fontFamilyFallback = [
    "Noto Sans SC",
    "Microsoft YaHei",
    "Roboto",
  ];

  static ThemeData get normal => BKThemeLight.data;
}
