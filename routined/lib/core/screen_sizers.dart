import 'package:flutter/material.dart';

class ScrnSizer {
  /// return the current available screen height
  static double screenWidth() =>
      MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.first,
      ).size.width;
  // MediaQueryData.fromView(WidgetsBinding.instance.window).size.width;

  /// return the current available screen width
  static double screenHeight() =>
      MediaQueryData.fromView(
        WidgetsBinding.instance.platformDispatcher.views.first,
      ).size.height;
}
