import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding_repository.mock.dart';

void main() {
  late MockOnBoardingRepository mockOnBoardingRepository;
  late CacheFirstTimerUseCase cacheFirstTimerUseCase;
  setUp(() {
    mockOnBoardingRepository = MockOnBoardingRepository();
    cacheFirstTimerUseCase = CacheFirstTimerUseCase(mockOnBoardingRepository);
  });

  test('class: cache_first_timer_usecase_test function: call result: true',
      () async {
    // arrange
    when(() => mockOnBoardingRepository.cacheFirstTimer()).thenAnswer(
      (_) async => const Right(null),
    );

    // act
    final result = await cacheFirstTimerUseCase();

    // assert
    expect(result, equals(const Right<Failure, void>(null)));
    verify(() => mockOnBoardingRepository.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(mockOnBoardingRepository);
  });
}
