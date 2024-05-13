import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';
import '../../../common/widgets/base_text_widget.dart';
import '../bloc/course_detail_bloc.dart';
import '../controller/course_detail_controller.dart';
import 'course_detail_widget.dart';

class CourseDetailView extends StatefulWidget {
  const CourseDetailView({Key? key}) : super(key: key);

  @override
  _CourseDetailViewState createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView> {
  late CourseDetailController _courseDetailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _courseDetailController = CourseDetailController(context: context);
    _courseDetailController.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailBloc, CourseDetailState>(
      builder: (context, state) {
        return state.courseItem == null
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              )
            : Container(
                color: Colors.white,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: buildAppBar(),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 25.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                thumbnail(state.courseItem!.thumbnail ?? ''),
                                SizedBox(height: 15.h),
                                menuView(),
                                SizedBox(height: 15.h),
                                reusableText('Course Description'),
                                SizedBox(height: 15.h),
                                reusableText(
                                  state.courseItem!.description ?? '',
                                  color: AppColors.primaryThirdElementText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11.sp,
                                ),
                                SizedBox(height: 20.h),
                                goBuyButton('Go Buy'),
                                SizedBox(height: 20.h),
                                courseSummaryTitle(),
                                courseSummaryView(context, state),
                                SizedBox(height: 20.h),
                                reusableText('Lesson List'),
                                SizedBox(height: 20.h),
                                courseLessonList(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
