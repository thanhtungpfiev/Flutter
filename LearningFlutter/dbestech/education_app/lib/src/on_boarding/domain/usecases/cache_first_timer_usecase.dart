import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repos/on_boarding_repository.dart';

class CacheFirstTimerUseCase extends UseCase<void, void> {
  const CacheFirstTimerUseCase(this._onBoardingRepository);

  final OnBoardingRepository _onBoardingRepository;

  @override
  ResultFuture<void> call({void params}) {
    return _onBoardingRepository.cacheFirstTimer();
  }
}