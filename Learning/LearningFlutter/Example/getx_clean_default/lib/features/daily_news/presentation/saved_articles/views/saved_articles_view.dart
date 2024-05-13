import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/routes/app_pages.dart';
import '../../../domain/entities/article_entity.dart';
import '../../home/local_widgets/article_widget.dart';
import '../controllers/saved_articles_controller.dart';

class SavedArticlesView extends GetView<SavedArticlesController> {
  const SavedArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        return _buildBody();
      }),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(),
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
      title:
          const Text('Saved Articles', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    if (controller.isLoading.value == true) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else {
      return _buildArticlesList(controller.articleEntityList);
    }
  }

  Widget _buildArticlesList(List<ArticleEntity> articles) {
    if (articles.isEmpty) {
      return const Center(
          child: Text(
        'NO SAVED ARTICLES',
        style: TextStyle(color: Colors.black),
      ));
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleWidget(
          article: articles[index],
          isRemovable: true,
          onRemove: (article) => _onRemoveArticle(article),
          onArticlePressed: (article) => _onArticlePressed(article),
        );
      },
    );
  }

  void _onBackButtonTapped() {
    Get.back();
  }

  void _onRemoveArticle(ArticleEntity article) {
    controller.onRemoveArticle(article);
  }

  void _onArticlePressed(ArticleEntity article) {
    Get.toNamed(Routes.articleDetail, arguments: article);
  }
}
