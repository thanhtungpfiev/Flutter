import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repository.dart';

class CheckIfUserIsFirstTimerUsecase extends UseCase<bool, void> {
  const CheckIfUserIsFirstTimerUsecase(this._onBoardingRepository);
  final OnBoardingRepository _onBoardingRepository;

  @override
  ResultFuture<bool> call({void params}) {
    return _onBoardingRepository.checkIfUserIsFirstTimer();
  }
}
