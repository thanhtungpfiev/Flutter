import 'package:flutter/material.dart';
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
  static double width(double designWidth) => designWidth.w;

  /// Get responsive height
  static double height(double designHeight) => designHeight.h;

  /// Get responsive font size
  static double fontSize(double designFontSize) => designFontSize.sp;

  /// Get responsive radius
  static double radius(double designRadius) => designRadius.r;

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

  /// Desktop-optimized spacing values
  static double get spacing4 => responsive(mobile: 4.w, desktop: 4.0);
  static double get spacing8 => responsive(mobile: 8.w, desktop: 8.0);
  static double get spacing10 => responsive(mobile: 10.w, desktop: 10.0);
  static double get spacing12 => responsive(mobile: 12.w, desktop: 12.0);
  static double get spacing15 => responsive(mobile: 15.w, desktop: 15.0);
  static double get spacing16 => responsive(mobile: 16.w, desktop: 16.0);
  static double get spacing20 => responsive(mobile: 20.w, desktop: 20.0);
  static double get spacing24 => responsive(mobile: 24.w, desktop: 24.0);
  static double get spacing32 => responsive(mobile: 32.w, desktop: 32.0);
  static double get spacing40 => responsive(mobile: 40.w, desktop: 60.0);
  static double get spacing48 => responsive(mobile: 48.w, desktop: 48.0);

  /// Desktop-optimized font sizes
  static double get font10 => responsive(mobile: 10.sp, desktop: 10.0);
  static double get font12 => responsive(mobile: 12.sp, desktop: 12.0);
  static double get font14 => responsive(mobile: 14.sp, desktop: 14.0);
  static double get font16 => responsive(mobile: 16.sp, desktop: 16.0);
  static double get font18 => responsive(mobile: 18.sp, desktop: 18.0);
  static double get font20 => responsive(mobile: 20.sp, desktop: 20.0);
  static double get font22 => responsive(mobile: 22.sp, desktop: 22.0);
  static double get font24 => responsive(mobile: 24.sp, desktop: 24.0);
  static double get font28 => responsive(mobile: 28.sp, desktop: 26.0);
  static double get font32 => responsive(mobile: 32.sp, desktop: 28.0);

  /// Desktop-optimized border radius
  static double get radius4 => responsive(mobile: 4.r, desktop: 4.0);
  static double get radius8 => responsive(mobile: 8.r, desktop: 8.0);
  static double get radius12 => responsive(mobile: 12.r, desktop: 12.0);
  static double get radius16 => responsive(mobile: 16.r, desktop: 16.0);
  static double get radius20 => responsive(mobile: 20.r, desktop: 20.0);
  static double get radius24 => responsive(mobile: 24.r, desktop: 24.0);

  /// Container constraints for different screen sizes
  static double get maxContentWidth =>
      responsive(mobile: screenWidth * 0.9, tablet: 600.0, desktop: 400.0);

  /// Form constraints
  static double get maxFormWidth =>
      responsive(mobile: screenWidth * 0.9, tablet: 500.0, desktop: 400.0);

  /// Button heights
  static double get buttonHeight =>
      responsive(mobile: height(50), desktop: 50.0);

  /// AppBar specific sizing
  static double get appBarHeight =>
      responsive(mobile: height(80), desktop: 60.0);

  static double get appBarBackButtonSize =>
      responsive(mobile: height(50), desktop: 36.0);

  /// Form element sizing
  static double get formFieldHeight =>
      responsive(mobile: height(60), desktop: 45.0);

  static double get formContainerHeight =>
      responsive(mobile: height(100), desktop: 80.0);

  /// Padding values for different contexts
  static EdgeInsets get pagePadding => EdgeInsets.symmetric(
    horizontal: responsive(mobile: spacing16, desktop: 32.0),
    vertical: spacing40,
  );

  static EdgeInsets get formPadding =>
      EdgeInsets.symmetric(horizontal: spacing16, vertical: spacing16);
}
