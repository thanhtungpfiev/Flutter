import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_icons.dart';
import '../../configs/themes/custom_text_styles.dart';
import '../../configs/themes/ui_parameters.dart';
import '../../controllers/questions_papers/question_paper_controller.dart';
import '../../models/question_paper_model.dart';
import '../../widgets/app_icon_text.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  final QuestionPaperModel model;

  const QuestionCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    const double padding = 10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        onTap: () {
          controller.navigateToQuestions(paper: model);
        },
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        child: CachedNetworkImage(
                          imageUrl: model.imageUrl,
                          placeholder: (context, url) => Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/app_splash_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: cartTitlesTS(context),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          child: Text(model.description),
                        ),
                        Row(
                          children: [
                            AppIconText(
                              icon: Icon(
                                Icons.help_outline_sharp,
                                color: UIParameters.isDarkMode()
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                "${model.questionCount} questions",
                                style: detailText.copyWith(
                                  color: UIParameters.isDarkMode()
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            AppIconText(
                              icon: Icon(
                                Icons.timer,
                                color: UIParameters.isDarkMode()
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                model.timeInMinutes(),
                                style: detailText.copyWith(
                                  color: UIParameters.isDarkMode()
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: -padding,
                right: -padding,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(cardBorderRadius),
                        bottomRight: Radius.circular(cardBorderRadius),
                      ),
                    ),
                    child: const Icon(
                      AppIcons.trophyOutLine,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
