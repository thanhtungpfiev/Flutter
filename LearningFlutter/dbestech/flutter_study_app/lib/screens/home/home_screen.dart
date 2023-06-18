import 'package:flutter/material.dart';
import 'package:flutter_study_app/configs/themes/app_colors.dart';
import 'package:flutter_study_app/configs/themes/custom_text_styles.dart';
import 'package:flutter_study_app/configs/themes/ui_parameters.dart';
import 'package:flutter_study_app/controllers/questions_papers/question_paper_controller.dart';
import 'package:flutter_study_app/controllers/zoom_drawer_controller.dart';
import 'package:flutter_study_app/screens/home/question_card.dart';
import 'package:flutter_study_app/widgets/content_area.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_icons.dart';
import '../../widgets/app_circle_button.dart';
import 'menu_screen.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController =
        Get.find<QuestionPaperController>();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (logic) {
        return ZoomDrawer(
          controller: controller.zoomDrawerController,
          angle: 0.0,
          slideWidth: MediaQuery.of(context).size.width * 0.6,
          menuScreenWidth: double.maxFinite,
          menuScreen: const MyMenuScreen(),
          mainScreen: Container(
            decoration: BoxDecoration(
              gradient: mainGradient(),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(mobileScreenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppCircleButton(
                          onTap: controller.toggleDrawer,
                          child: const Icon(
                            AppIcons.menuLeft,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            children: [
                              const Icon(
                                AppIcons.peace,
                              ),
                              Text(
                                "Hello friend",
                                style: detailText.copyWith(
                                    color: onSurfaceTextColor),
                              )
                            ],
                          ),
                        ),
                        const Text(
                          "What do you want to learn today?",
                          style: headerText,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ContentArea(
                        addPadding: false,
                        child: Obx(() {
                          return ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              itemBuilder: (BuildContext context, int index) {
                                return QuestionCard(
                                  model:
                                      questionPaperController.allPapers[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount:
                                  questionPaperController.allPapers.length);
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
