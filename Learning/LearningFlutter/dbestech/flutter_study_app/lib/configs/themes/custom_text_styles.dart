import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_colors.dart';
import 'ui_parameters.dart';

TextStyle cartTitlesTS(context) => TextStyle(
      color: UIParameters.isDarkMode()
          ? Theme.of(context).textTheme.bodyLarge!.color
          : Theme.of(context).primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

const detailText = TextStyle(fontSize: 12);

const headerText = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w700,
  color: onSurfaceTextColor,
);

const questionTS = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w800,
);

const appBarTS = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: onSurfaceTextColor,
);

TextStyle countDownTimerTs() => TextStyle(
      letterSpacing: 2,
      color: UIParameters.isDarkMode()
          ? Theme.of(Get.context!).textTheme.bodyLarge!.color
          : Theme.of(Get.context!).primaryColor,
    );
