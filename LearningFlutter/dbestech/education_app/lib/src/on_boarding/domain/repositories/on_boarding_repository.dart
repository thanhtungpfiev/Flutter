import 'package:education_app/core/utils/typedefs.dart';

abstract class OnBoardingRepository {
  const OnBoardingRepository();
  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
