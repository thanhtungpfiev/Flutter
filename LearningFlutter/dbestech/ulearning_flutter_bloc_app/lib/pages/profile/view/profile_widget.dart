import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

AppBar buildAppBar() {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 15.w,
          height: 12.h,
          child: Image.asset('assets/icons/menu.png'),
        ),
        Text(
          'Profile',
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(
          width: 24.w,
          height: 24.h,
          child: Image.asset('assets/icons/more-vertical.png'),
        ),
      ],
    ),
  );
}

Container profileIconAndEditButton() {
  return Container(
    width: 80.w,
    height: 80.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      image: const DecorationImage(
        image: AssetImage('assets/icons/headpic.png'),
      ),
    ),
    alignment: Alignment.bottomRight,
    padding: EdgeInsets.only(right: 6.w),
    child: Image.asset(
      'assets/icons/edit_3.png',
      width: 25.w,
      height: 25.h,
    ),
  );
}

Widget buildListView() {
  return Column(
    children: [
      GestureDetector(
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              padding: EdgeInsets.all(7.0.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: AppColors.primaryElement,
              ),
              child: Image.asset('assets/icons/settings.png'),
            ),
            SizedBox(
              width: 15.w,
            ),
            Text(
              'Settings',
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            )
          ],
        ),
      )
    ],
  );
}
