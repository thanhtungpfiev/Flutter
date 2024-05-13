import 'package:get/get.dart';

import '../modules/content/bindings/content_binding.dart';
import '../modules/content/views/content_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/recent_contest/bindings/recent_contest_binding.dart';
import '../modules/recent_contest/views/recent_contest_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.detail,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.content,
      page: () => const ContentView(),
      binding: ContentBinding(),
    ),
    GetPage(
      name: _Paths.recentContest,
      page: () => const RecentContestView(),
      binding: RecentContestBinding(),
    ),
  ];
}
