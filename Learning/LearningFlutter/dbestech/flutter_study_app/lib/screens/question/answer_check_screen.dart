import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/custom_text_styles.dart';
import '../../controllers/questions_papers/questions_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/common/background_decoration.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/content_area.dart';
import '../../widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(() {
          return Text(
            "Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}",
            style: appBarTS,
          );
        }),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(AppRoutes.resultRoute);
        },
      ),
      body: BackgroundDecoration(
          child: Column(
        children: [
          Expanded(
              child: ContentArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Column(
                children: [
                  Text(controller.currentQuestion.value!.question),
                  GetBuilder<QuestionsController>(
                      id: "answer_review_list",
                      builder: (_) {
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              final answer = controller
                                  .currentQuestion.value!.answers[index];
                              final selectedAnswer = controller
                                  .currentQuestion.value!.selectedAnswer;
                              final correctAnswer = controller
                                  .currentQuestion.value!.correctAnswer;
                              final answerText =
                                  "${answer.identifier}. ${answer.answer}";
                              if (selectedAnswer == correctAnswer &&
                                  answer.identifier == selectedAnswer) {
                                return CorrectAnswer(answer: answerText);
                              } else if (selectedAnswer != correctAnswer &&
                                  answer.identifier == selectedAnswer) {
                                return WrongAnswer(answer: answerText);
                              } else if (correctAnswer == answer.identifier) {
                                return CorrectAnswer(answer: answerText);
                              } else if (selectedAnswer == null) {
                                return NotAnswer(answer: answerText);
                              }

                              return AnswerCard(
                                answer: answerText,
                                onTap: () {},
                              );
                            },
                            separatorBuilder: (_, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: controller
                                .currentQuestion.value!.answers.length);
                      })
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }
}
