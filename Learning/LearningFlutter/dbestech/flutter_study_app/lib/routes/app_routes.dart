import 'package:get/get.dart';

import '../controllers/questions_papers/question_paper_controller.dart';
import '../controllers/questions_papers/questions_controller.dart';
import '../controllers/zoom_drawer_controller.dart';
import '../screens/home/home_screen.dart';
import '../screens/introduction/introduction_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/question/answer_check_screen.dart';
import '../screens/question/questions_screen.dart';
import '../screens/question/result_screen.dart';
import '../screens/question/test_overview_screen.dart';
import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static const String initRoute = "/";
  static const String introductionRoute = "/introduction";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String questionsRoute = "/questions";
  static const String testOverviewRoute = "/testOverview";
  static const String resultRoute = "/result";
  static const String answerCheckRoute = "/checkAnswer";

  static List<GetPage> routes() => [
        GetPage(
          name: initRoute,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: introductionRoute,
          page: () => const IntroductionScreen(),
        ),
        GetPage(
          name: homeRoute,
          page: () => const HomeScreen(),
          binding: BindingsBuilder(() {
            Get.put(QuestionPaperController());
            Get.put(MyZoomDrawerController());
          }),
        ),
        GetPage(
          name: loginRoute,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: questionsRoute,
          page: () => const QuestionsScreen(),
          binding: BindingsBuilder(() {
            Get.put<QuestionsController>(QuestionsController());
          }),
        ),
        GetPage(
          name: testOverviewRoute,
          page: () => const TestOverviewScreen(),
        ),
        GetPage(
          name: resultRoute,
          page: () => const ResultScreen(),
        ),
        GetPage(
          name: answerCheckRoute,
          page: () => const AnswerCheckScreen(),
        ),
      ];
}
