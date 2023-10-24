import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_architecture_v2/src/domain/models/article.dart';
import 'package:clean_architecture_v2/src/domain/models/requests/breaking_news_request.dart';
import 'package:clean_architecture_v2/src/domain/repositories/api_repository.dart';
import 'package:clean_architecture_v2/src/presentation/cubits/base/base_cubit.dart';
import 'package:clean_architecture_v2/src/utils/constants/nums.dart';
import 'package:clean_architecture_v2/src/utils/resources/data_state.dart';

part 'remote_articles_state.dart';

class RemoteArticlesCubit
    extends BaseCubit<RemoteArticlesState, List<Article>> {
  final ApiRepository _apiRepository;

  RemoteArticlesCubit(this._apiRepository)
      : super(const RemoteArticlesLoading(), []);

  int _page = 1;

  Future<void> getBreakingNewsArticles() async {
    if (isBusy) return;

    await run(() async {
      final response = await _apiRepository.getBreakingNewsArticles(
        request: BreakingNewsRequest(page: _page),
      );
      if (response is DataSuccess) {
        final articles = response.data?.articles;
        final noMoreData = articles!.length < defaultPageSize;

        data.addAll(articles);
        _page++;
        emit(RemoteArticlesSuccess(articles: data, noMoreData: noMoreData));
      } else {
        emit(RemoteArticlesFailed(error: response.error));
      }
    });
  }
}
