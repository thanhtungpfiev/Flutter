import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../../../../core/configs/constants/api_constants.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/utils/helpers/logger_helper.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/article_repository.dart';
import '../data_sources/local/app_database.dart';
import '../data_sources/remote/news_api_service.dart';
import '../models/article_model.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDataBase;

  ArticleRepositoryImpl(this._newsApiService, this._appDataBase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
          apiKey: newsAPIKey,
          country: newsAPICountry,
          category: newsAPICategory);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions),
        );
      }
    } on DioException catch (e) {
      LoggerHelper.logger.e('DioException: $e');
      return DataFailed(e);
    } catch (e) {
      LoggerHelper.logger.e('Something really unknown: $e');
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(),
        ),
      );
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() {
    return _appDataBase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDataBase.articleDao
        .deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDataBase.articleDao
        .insertArticle(ArticleModel.fromEntity(article));
  }
}
