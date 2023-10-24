import 'package:clean_architecture_v2/src/domain/models/requests/breaking_news_request.dart';
import 'package:clean_architecture_v2/src/domain/models/responses/breaking_news_response.dart';
import 'package:clean_architecture_v2/src/utils/resources/data_state.dart';

abstract class ApiRepository {
  Future<DataState<BreakingNewsResponse>> getBreakingNewsArticles({
    required BreakingNewsRequest request,
  });
}
