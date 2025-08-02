# Flutter ScreenUtil Implementation Guide

## Overview
This guide explains how to implement responsive UI using `flutter_screenutil` in your ecommerce Flutter app.

**Design Size**: 390x844 (iPhone 14 Pro from Figma)
**Target Platform**: Windows PC (but responsive for all platforms)

## Setup Complete ✅

1. **Added flutter_screenutil dependency** to `pubspec.yaml`
2. **Configured ScreenUtilInit** in `main.dart` with design size 390x844
3. **Created ResponsiveUtils helper** class for easy usage
4. **Updated SplashPage** as an example

## How to Use ResponsiveUtils

### Import the utility class:
```dart
import 'package:ecommerce_clone/core/utils/responsive_utils.dart';
```

### Responsive Dimensions

**Width & Height:**
```dart
Container(
  width: ResponsiveUtils.width(100),  // Based on 390px design width
  height: ResponsiveUtils.height(50), // Based on 844px design height
)
```

**Direct flutter_screenutil usage:**
```dart
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container(
  width: 100.w,  // 100 pixels from design
  height: 50.h,  // 50 pixels from design
)
```

### Responsive Typography

**Font Sizes:**
```dart
Text(
  'Hello World',
  style: TextStyle(
    fontSize: ResponsiveUtils.fontSize(16), // 16sp from design
  ),
)

// Or directly:
Text(
  'Hello World',
  style: TextStyle(fontSize: 16.sp),
)

// Using predefined sizes:
Text(
  'Title',
  style: TextStyle(fontSize: ResponsiveUtils.fontSize(24)),
)
```

### Responsive Spacing & Padding

**Margins & Padding:**
```dart
Padding(
  padding: EdgeInsets.all(ResponsiveUtils.width(16)),
  child: child,
)

// Or directly:
Padding(
  padding: EdgeInsets.all(16.w),
  child: child,
)

// Symmetric padding:
Padding(
  padding: EdgeInsets.symmetric(
    horizontal: ResponsiveUtils.width(20),
    vertical: ResponsiveUtils.width(12),
  ),
  child: child,
)
```

### Responsive Border Radius

**Rounded corners:**
```dart
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(ResponsiveUtils.radius12),
  ),
)

// Or directly:
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.r),
  ),
)
```

### Screen Information

**Get screen dimensions:**
```dart
double screenWidth = ResponsiveUtils.screenWidth;   // 1.sw
double screenHeight = ResponsiveUtils.screenHeight; // 1.sh
double statusBarHeight = ResponsiveUtils.statusBarHeight;
bool isTablet = ResponsiveUtils.isTablet; // width > 600
```

## Common Responsive Patterns

### 1. Responsive Cards
```dart
Card(
  margin: EdgeInsets.all(ResponsiveUtils.width(16)),
  child: Padding(
    padding: EdgeInsets.all(ResponsiveUtils.width(20)),
    child: Column(
      children: [
        Text(
          'Product Name',
          style: TextStyle(
            fontSize: ResponsiveUtils.fontSize(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: ResponsiveUtils.width(12)),
        Text(
          'Description',
          style: TextStyle(fontSize: ResponsiveUtils.fontSize(14)),
        ),
      ],
    ),
  ),
)
```

### 2. Responsive Buttons
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    minimumSize: Size(
      ResponsiveUtils.width(200),
      ResponsiveUtils.height(48),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(ResponsiveUtils.radius12),
    ),
  ),
  onPressed: () {},
  child: Text(
    'Add to Cart',
    style: TextStyle(fontSize: ResponsiveUtils.fontSize(16)),
  ),
)
```

### 3. Responsive Grid
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: ResponsiveUtils.isTablet ? 3 : 2,
    crossAxisSpacing: ResponsiveUtils.width(16),
    mainAxisSpacing: ResponsiveUtils.width(16),
    childAspectRatio: 0.8,
  ),
  itemBuilder: (context, index) => ProductCard(),
)
```

### 4. Responsive AppBar
```dart
AppBar(
  toolbarHeight: ResponsiveUtils.height(60),
  title: Text(
    'Ecommerce',
    style: TextStyle(fontSize: ResponsiveUtils.fontSize(20)),
  ),
  actions: [
    Padding(
      padding: EdgeInsets.only(right: ResponsiveUtils.width(16)),
      child: Icon(
        Icons.shopping_cart,
        size: ResponsiveUtils.width(24),
      ),
    ),
  ],
)
```

## Best Practices

1. **Always use responsive units** for dimensions that should scale
2. **Use fixed values** only for things like border widths (1px, 2px)
3. **Test on different screen sizes** to ensure proper scaling
4. **Use predefined spacing values** from ResponsiveUtils for consistency
5. **Consider tablet layouts** using `ResponsiveUtils.isTablet`

## Windows Desktop Considerations

Since you're focusing on Windows PC development:

1. **Window size is fixed** to 520x900 (iPhone 14 Pro size) in main.dart
2. **ScreenUtil will adapt** your 390x844 design to this window size
3. **All responsive values** will scale proportionally
4. **Desktop interactions** (hover, right-click) can be added while maintaining responsiveness

## Quick Migration Guide

To convert existing hard-coded values:

- `width: 100` → `width: 100.w` or `ResponsiveUtils.width(100)`
- `height: 50` → `height: 50.h` or `ResponsiveUtils.height(50)`
- `fontSize: 16` → `fontSize: 16.sp` or `ResponsiveUtils.fontSize(16)`
- `borderRadius: 8` → `borderRadius: 8.r` or `ResponsiveUtils.radius(8)`
- `padding: 16` → `padding: 16.w` or `ResponsiveUtils.width(16)`

## Testing

Run your app and verify:
```bash
flutter run -d windows
```

The UI should now be responsive and properly scaled for your Windows development environment while maintaining the proper proportions from your Figma design.
