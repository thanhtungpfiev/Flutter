import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/configs/constants/api_constants.dart';
import '../../models/article_model.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET(newsAPIHeadlinePoint)
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query('apiKey') String? apiKey,
    @Query('country') String? country,
    @Query('category') String? category,
  });
}
