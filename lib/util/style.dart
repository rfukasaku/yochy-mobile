import 'package:flutter/material.dart';

import 'app_colors.dart';

PageTransitionsTheme _pageTransitionsTheme = const PageTransitionsTheme(
  builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  },
);

ThemeData defaultTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  pageTransitionsTheme: _pageTransitionsTheme,
  fontFamily: 'Yomogi',
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
