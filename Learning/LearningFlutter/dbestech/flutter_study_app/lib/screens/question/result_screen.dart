import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../configs/themes/custom_text_styles.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../controllers/questions_papers/questions_controller.dart';
import '../../controllers/questions_papers/questions_controller_extension.dart';
import '../../enum/answer_status_enum.dart';
import '../../widgets/common/background_decoration.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/main_button.dart';
import '../../widgets/content_area.dart';
import '../../widgets/questions/question_number_card.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: const SizedBox(
          height: 80,
        ),
        title: controller.correctAnsweredQuestionString,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/bulb.svg'),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        "Congratulations",
                        style: headerText.copyWith(color: textColor),
                      ),
                    ),
                    Text(
                      "You have ${controller.points} points",
                      style: TextStyle(color: textColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Tap below question numbers to view correct answers",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: GridView.builder(
                          itemCount: controller.allQuestions.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width ~/ 65,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (_, index) {
                            final question = controller.allQuestions[index];
                            AnswerStatus status = AnswerStatus.notAnswered;
                            final selectedAnswer = question.selectedAnswer;
                            final correctAnswer = question.correctAnswer;
                            if (selectedAnswer != null) {
                              if (selectedAnswer == correctAnswer) {
                                status = AnswerStatus.correct;
                              } else {
                                status = AnswerStatus.wrong;
                              }
                            }
                            return QuestionNumberCard(
                              index: index + 1,
                              status: status,
                              onTap: () {
                                controller.jumpToQuestion(index,
                                    isGoBack: false);
                              },
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.tryAgain();
                        },
                        color: Colors.blueGrey,
                        title: "Try again",
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.saveTestResults();
                        },
                        title: "Go home",
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
