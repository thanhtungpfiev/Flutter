import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typdefs.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(this._repo);

  final OnBoardingRepo _repo;

  @override
  ResultFuture<bool> call() => _repo.checkIfUserIsFirstTimer();
}
