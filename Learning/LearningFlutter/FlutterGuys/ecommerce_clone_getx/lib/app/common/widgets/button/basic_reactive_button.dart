import 'package:ecommerce_clone_getx/app/common/controllers/button/basic_reactive_button_controller.dart';
import 'package:ecommerce_clone_getx/app/core/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicReactiveButton extends StatelessWidget {
  const BasicReactiveButton({
    required this.onPressed,
    required this.controller,
    this.title = '',
    this.height,
    this.width,
    this.content,
    super.key,
  });

  final VoidCallback onPressed;
  final BasicReactiveButtonController controller;
  final String title;
  final double? height;
  final double? width;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.state.value == BasicReactiveButtonState.loading) {
        return _loading();
      }
      return _initial();
    });
  }

  Widget _loading() {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? ResponsiveUtils.screenWidth,
          height ?? ResponsiveUtils.height(50),
        ),
      ),
      child: Container(
        height: height ?? ResponsiveUtils.height(50),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _initial() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? ResponsiveUtils.screenWidth,
          height ?? ResponsiveUtils.height(50),
        ),
      ),
      child:
          content ??
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: ResponsiveUtils.fontSize(16),
            ),
          ),
    );
  }
}
