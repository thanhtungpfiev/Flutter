import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';
import '../../../common/values/constants.dart';
import '../../../common/widgets/base_text_widget.dart';
import '../bloc/course_detail_bloc.dart';

AppBar buildAppBar() {
  return AppBar(
    centerTitle: true,
    title: reusableText('Course detail'),
  );
}

Widget thumbnail(String thumbnailPath) {
  return Container(
    width: 325.w,
    height: 200.h,
    decoration: BoxDecoration(
      image: DecorationImage(
        // fit: BoxFit.fitWidth,
        image:
            NetworkImage('${AppConstants.serverApiUrl}/uploads/$thumbnailPath'),
      ),
    ),
  );
}

Widget menuView() {
  return SizedBox(
    width: 325.w,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColors.primaryElement,
              borderRadius: BorderRadius.circular(7.w),
              border: Border.all(color: AppColors.primaryElement),
            ),
            child: reusableText('Author Page',
                color: AppColors.primaryElementText,
                fontWeight: FontWeight.normal,
                fontSize: 10.sp),
          ),
        ),
        _iconAndNum('assets/icons/people.png', 0),
        _iconAndNum('assets/icons/star.png', 0),
      ],
    ),
  );
}

Widget _iconAndNum(String iconPath, int num) {
  return Container(
    margin: EdgeInsets.only(left: 30.w),
    child: Row(
      children: [
        Image(
          image: AssetImage(iconPath),
          width: 20.w,
          height: 20.h,
        ),
        reusableText(
          num.toString(),
          color: AppColors.primaryThirdElementText,
          fontSize: 11.sp,
          fontWeight: FontWeight.normal,
        )
      ],
    ),
  );
}

Widget goBuyButton(String name) {
  return Container(
    width: 330.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: AppColors.primaryElement,
      borderRadius: BorderRadius.circular(10.w),
      border: Border.all(color: AppColors.primaryElement),
    ),
    child: Center(
        child: Text(
      name,
      style: TextStyle(
        color: AppColors.primaryElementText,
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      ),
    )),
  );
}

Widget courseSummaryTitle() {
  return reusableText('The course Includes', fontSize: 14.sp);
}

Widget courseSummaryView(BuildContext context, CourseDetailState state) {
  var imagesInfo = <String, String>{
    '${state.courseItem!.video_len} Hours Video': 'video_detail.png',
    'Total ${state.courseItem!.lesson_num} Lessons': 'file_detail.png',
    '67 Downloadable Resources': 'download_detail.png',
  };
  return Column(
    children: [
      ...List.generate(
          imagesInfo.length,
          (index) => GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(7.0.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.w),
                          color: AppColors.primaryElement,
                        ),
                        child: Image.asset(
                          'assets/icons/${imagesInfo.values.elementAt(index)}',
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        imagesInfo.keys.elementAt(index),
                        style: TextStyle(
                          color: AppColors.primarySecondaryElementText,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                        ),
                      )
                    ],
                  ),
                ),
              )),
    ],
  );
}

Widget courseLessonList() {
  return Container(
    width: 325.w,
    height: 80.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.circular(10.w),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1))
        ]),
    child: InkWell(
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.h),
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/icons/image_1.png'),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _listContainer(),
                  _listContainer(
                    fontSize: 10,
                    color: AppColors.primaryThirdElementText,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              )
            ],
          ),
          Container(
            child: Image(
              width: 24.w,
              height: 24.h,
              image: AssetImage('assets/icons/arrow_right.png'),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _listContainer(
    {double fontSize = 13,
    Color color = AppColors.primaryText,
    fontWeight = FontWeight.bold}) {
  return Container(
    width: 200.w,
    margin: EdgeInsets.only(left: 6.w),
    child: Text(
      'UI Design',
      overflow: TextOverflow.clip,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      ),
    ),
  );
}
