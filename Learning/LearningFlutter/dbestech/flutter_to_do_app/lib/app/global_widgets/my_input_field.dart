import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/values/text_styles.dart';

class MyInputField extends StatelessWidget {
  const MyInputField(
      {super.key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget});

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.defaultStyle.titleStyle,
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 8,
            ),
            padding: const EdgeInsets.only(
              left: 14,
            ),
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor:
                        Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    controller: controller,
                    style: TextStyles.defaultStyle.subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyles.defaultStyle.subTitleStyle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (widget != null)
                  Container(
                    child: widget,
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
