import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

import 'package:clean_architecture_v2/src/config/router/app_router.dart';
import 'package:clean_architecture_v2/src/domain/models/article.dart';
import 'package:clean_architecture_v2/src/presentation/cubits/remote_articles/remote_articles_cubit.dart';
import 'package:clean_architecture_v2/src/presentation/widgets/article_widget.dart';
import 'package:clean_architecture_v2/src/utils/extensions/scroll_controller_extensions.dart';

@RoutePage()
class BreakingNewsView extends HookWidget {
  const BreakingNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteArticlesCubit = BlocProvider.of<RemoteArticlesCubit>(context);
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.onScrollEndsListener(() {
        remoteArticlesCubit.getBreakingNewsArticles();
      });

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily News',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            // onTap: () => appRouter.push(const SavedArticlesViewRoute()),
            onTap: null,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(
                Ionicons.bookmark,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<RemoteArticlesCubit, RemoteArticlesState>(
          builder: (_, state) {
        switch (state.runtimeType) {
          case RemoteArticlesLoading:
            return const Center(child: CircularProgressIndicator.adaptive());
          case RemoteArticlesFailed:
            return const Center(
              child: Icon(Ionicons.refresh),
            );
          case RemoteArticlesSuccess:
            return _buildArticles(
                scrollController, state.articles, state.noMoreData);
          default:
            return const SizedBox();
        }
      }),
    );
  }

  Widget _buildArticles(ScrollController scrollController,
      List<Article> articles, bool noMoreData) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ArticleWidget(
              article: articles[index],
              onArticlePressed: null,
            ),
            childCount: articles.length,
          ),
        ),
        if (!noMoreData)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 14, bottom: 32),
              child: CircularProgressIndicator.adaptive(),
            ),
          )
      ],
    );
  }
}
