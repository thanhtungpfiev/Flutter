import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/routes/routes.dart';
import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';

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
        reusableText('Profile'),
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

var imagesInfo = <String, String>{
  'Settings': 'settings.png',
  'Payment details': 'credit-card.png',
  'Achievement': 'award.png',
  'Love': 'heart(1).png',
  'Reminders': 'cube.png',
};

Widget buildListView(BuildContext context) {
  return Column(
    children: [
      ...List.generate(
          imagesInfo.length,
          (index) => GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.setting),
                child: Container(
                  margin: EdgeInsets.only(bottom: 15.h),
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
                        child: Image.asset(
                            'assets/icons/${imagesInfo.values.elementAt(index)}'),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        imagesInfo.keys.elementAt(index),
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      )
                    ],
                  ),
                ),
              )),
    ],
  );
}
