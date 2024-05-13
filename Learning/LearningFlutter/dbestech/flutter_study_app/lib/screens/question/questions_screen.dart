import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_colors.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../controllers/questions_papers/loading_status.dart';
import '../../controllers/questions_papers/questions_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/common/background_decoration.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/main_button.dart';
import '../../widgets/common/question_place_holder.dart';
import '../../widgets/content_area.dart';
import '../../widgets/questions/answer_card.dart';
import '../../widgets/questions/countdown_timer.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(
                color: onSurfaceTextColor,
                width: 2,
              ),
            ),
          ),
          child: Obx(() {
            return CountdownTimer(
              time: controller.time.value,
              color: onSurfaceTextColor,
            );
          }),
        ),
        showActionIcon: true,
        titleWidget: Obx(() {
          return Text(
            "Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}",
            style: appBarTS,
          );
        }),
        onMenuActionTap: () {
          Get.toNamed(AppRoutes.testOverviewRoute);
        },
      ),
      body: BackgroundDecoration(
        child: Obx(
          () => Column(
            children: [
              controller.loadingStatus.value == LoadingStatus.completed
                  ? Expanded(
                      child: ContentArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            top: 25,
                          ),
                          child: Column(
                            children: [
                              Text(
                                controller.currentQuestion.value!.question,
                                style: questionTS,
                              ),
                              GetBuilder<QuestionsController>(
                                id: 'answers_list',
                                builder: (context) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(
                                        top: 25,
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final answer = controller
                                            .currentQuestion
                                            .value!
                                            .answers[index];
                                        return AnswerCard(
                                          answer:
                                              '${answer.identifier}. ${answer.answer}',
                                          onTap: () {
                                            controller.selectedAnswer(
                                                answer.identifier);
                                          },
                                          isSelected: answer.identifier ==
                                              controller.currentQuestion.value!
                                                  .selectedAnswer,
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                                height: 10,
                                              ),
                                      itemCount: controller.currentQuestion
                                          .value!.answers.length);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Expanded(
                      child: ContentArea(
                        child: QuestionPlaceHolder(),
                      ),
                    ),
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Visibility(
                        visible: !controller.isFirstQuestion,
                        child: SizedBox(
                          width: 55,
                          height: 55,
                          child: MainButton(
                            onTap: () {
                              controller.prevQuestion();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Get.isDarkMode
                                  ? onSurfaceTextColor
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Visibility(
                          visible: controller.loadingStatus.value ==
                              LoadingStatus.completed,
                          child: MainButton(
                            onTap: () {
                              controller.isLastQuestion
                                  ? Get.toNamed(AppRoutes.testOverviewRoute)
                                  : controller.nextQuestion();
                            },
                            title: controller.isLastQuestion
                                ? 'Completed'
                                : 'Next',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
