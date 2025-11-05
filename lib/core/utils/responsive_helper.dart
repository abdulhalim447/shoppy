import 'package:flutter/material.dart';

/// Responsive layout helper
class ResponsiveHelper {
  // Private constructor to prevent instantiation
  ResponsiveHelper._();

  /// Get responsive padding based on screen width
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return const EdgeInsets.all(16);
    } else if (width < 900) {
      return const EdgeInsets.all(24);
    } else {
      return const EdgeInsets.all(32);
    }
  }

  /// Get responsive font size
  static double getResponsiveFontSize(
    BuildContext context, {
    required double mobileSize,
    double? tabletSize,
    double? desktopSize,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return mobileSize;
    } else if (width < 900) {
      return tabletSize ?? mobileSize * 1.1;
    } else {
      return desktopSize ?? mobileSize * 1.2;
    }
  }

  /// Get responsive grid columns
  static int getGridColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 2;
    } else if (width < 900) {
      return 3;
    } else {
      return 4;
    }
  }

  /// Get responsive width
  static double getResponsiveWidth(
    BuildContext context, {
    required double mobileWidth,
    double? tabletWidth,
    double? desktopWidth,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return mobileWidth;
    } else if (width < 900) {
      return tabletWidth ?? mobileWidth * 1.2;
    } else {
      return desktopWidth ?? mobileWidth * 1.5;
    }
  }

  /// Check if device is in portrait mode
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get device type
  static DeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return DeviceType.mobile;
    } else if (width < 900) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }
}

/// Device type enum
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

