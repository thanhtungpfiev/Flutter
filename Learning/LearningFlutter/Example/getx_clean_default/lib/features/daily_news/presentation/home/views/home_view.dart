import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/configs/constants/text_constants.dart';
import '../../../../../core/routes/app_pages.dart';
import '../../../../../core/theme/text_styles.dart';
import '../controllers/home_controller.dart';
import '../local_widgets/article_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        return _buildBody();
      }),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text(
        homeTitle,
        style: TextStyles.defaultStyle,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
            onTap: () => Get.toNamed(Routes.savedArticles),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.bookmark, color: Colors.black),
            ))
      ],
    );
  }

  _buildBody() {
    if (controller.isLoading.value == true) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else {
      if (controller.isDataSuccess.value == true) {
        return ListView.builder(
          itemBuilder: (_, index) {
            return ArticleWidget(
              article: controller.articleEntityList[index],
              onArticlePressed: (article) =>
                  Get.toNamed(Routes.articleDetail, arguments: article),
            );
          },
          itemCount: controller.articleEntityList.length,
        );
      } else {
        return const Center(child: Icon(Icons.refresh));
      }
    }
  }
}
