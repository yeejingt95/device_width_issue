import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

/// Helper class to calculate responsive size based on device display size.
class ResponsiveHelper {
  static double ratio = 1;

  /// Calculate ratio with physical device specification. Should call as soon as startup to set static ratio.
  static void setRatio() {
    // Get physical pixel of shorter edge.
    var shortEdge = min(
        WidgetsBinding.instance?.window.physicalSize.width ?? 1080,
        WidgetsBinding.instance?.window.physicalSize.height ?? 1080);

    // Get device pixel ratio to calculate logical pixel resolution.
    var devicePixelRatio =
        WidgetsBinding.instance?.window.devicePixelRatio ?? 1;
    if (Platform.isAndroid) {
      ratio = shortEdge /
          devicePixelRatio /
          400; // 400 as standard reference for android.
    } else // if (Platform.isIOS)
    {
      ratio = shortEdge /
          devicePixelRatio /
          600; // 600 as standard reference for ios.
    }
  }

  static double get defaultFontSize {
    return ratio * 16;
  }

  static double get defaultPadding {
    return ratio * 20;
  }

  static double relativeFontSize(double em) {
    return em * defaultFontSize;
  }

  static double relativePixel(double pixel) {
    return ratio * pixel;
  }

  /// Check if current screen is landscape.
  ///
  /// `ResponsiveHelper.isLandscape(MediaQuery.of(context));`
  static bool isLandscape(MediaQueryData mediaQueryData) {
    return mediaQueryData.orientation == Orientation.landscape;
  }

  /// Check if current screen is portrait.
  ///
  /// `ResponsiveHelper.isPotrait(MediaQuery.of(context));`
  static bool isPotrait(MediaQueryData mediaQueryData) {
    return mediaQueryData.orientation == Orientation.portrait;
  }
}
