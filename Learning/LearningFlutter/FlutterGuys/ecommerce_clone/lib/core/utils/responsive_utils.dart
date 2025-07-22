import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Responsive utility class using flutter_screenutil
/// Based on design size: 390x844 (iPhone 14 Pro)
/// Enhanced with desktop-friendly responsive values
class ResponsiveUtils {
  ResponsiveUtils._();

  /// Device type breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  /// Get responsive width
  static double width(double designWidth) => responsive(
    mobile: designWidth.w,
    tablet: designWidth.w,
    desktop: designWidth,
  );

  /// Get responsive height
  static double height(double designHeight) => responsive(
    mobile: designHeight.h,
    tablet: designHeight.h,
    desktop: designHeight,
  );

  /// Get responsive font size
  static double fontSize(double designFontSize) => responsive(
    mobile: designFontSize.sp,
    tablet: designFontSize.sp,
    desktop: designFontSize,
  );

  /// Get responsive radius
  static double radius(double designRadius) => responsive(
    mobile: designRadius.r,
    tablet: designRadius.r,
    desktop: designRadius,
  );

  /// Get screen width
  static double get screenWidth => 1.sw;

  /// Get screen height
  static double get screenHeight => 1.sh;

  /// Get status bar height
  static double get statusBarHeight => ScreenUtil().statusBarHeight;

  /// Get bottom bar height
  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;

  /// Get text scale factor
  static double get textScaleFactor => ScreenUtil().textScaleFactor;

  /// Device type detection
  static bool get isMobile => screenWidth < mobileBreakpoint;
  static bool get isTablet =>
      screenWidth >= mobileBreakpoint && screenWidth < tabletBreakpoint;
  static bool get isDesktop => screenWidth >= tabletBreakpoint;

  /// Legacy tablet check (kept for compatibility)
  static bool get isTabletLegacy => screenWidth > 600;

  /// Get responsive value based on device type
  static T responsive<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  /// Container constraints for different screen sizes
  static double get maxContentWidth =>
      responsive(mobile: screenWidth * 0.9, tablet: 600.0, desktop: 400.0);

  /// Form constraints
  static double get maxFormWidth =>
      responsive(mobile: screenWidth * 0.9, tablet: 500.0, desktop: 400.0);
}
