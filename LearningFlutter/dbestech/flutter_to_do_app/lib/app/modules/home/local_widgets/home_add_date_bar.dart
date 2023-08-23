import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme_color.dart';
import '../../../core/values/text_styles.dart';
import '../controllers/home_controller.dart';

class HomeAddDateBar extends StatelessWidget {
  HomeAddDateBar({
    super.key,
  });

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 20,
        left: 20,
      ),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: ThemeColor.primaryColor,
        selectedTextColor: Colors.white,
        dateTextStyle: TextStyles.defaultStyle.dateTextStyle,
        dayTextStyle: TextStyles.defaultStyle.dayTextStyle,
        monthTextStyle: TextStyles.defaultStyle.monthTextStyle,
        onDateChange: (value) {
          controller.updateSelectedDate(value);
        },
      ),
    );
  }
}
