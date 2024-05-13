// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture_v2/src/utils/constants/nums.dart';
import 'package:clean_architecture_v2/src/utils/constants/strings.dart';

class BreakingNewsRequest {
  final String apiKey;
  final String country;
  final String category;
  final int page;
  final int pageSize;

  BreakingNewsRequest({
    this.apiKey = defaultApiKey,
    this.country = 'us',
    this.category = 'general',
    this.page = 1,
    this.pageSize = defaultPageSize,
  });
}
