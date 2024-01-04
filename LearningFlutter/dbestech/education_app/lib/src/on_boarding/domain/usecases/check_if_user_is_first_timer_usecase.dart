import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class CheckIfUserIsFirstTimerUseCase extends UseCase<bool, void> {
  const CheckIfUserIsFirstTimerUseCase(this._onBoardingRepository);
  final OnBoardingRepository _onBoardingRepository;

  @override
  ResultFuture<bool> call({void params}) {
    return _onBoardingRepository.checkIfUserIsFirstTimer();
  }
}
