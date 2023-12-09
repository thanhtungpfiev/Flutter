import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/domain/entities/movie_entity.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/search_movies_usecase.dart';
import 'get_trending_movies_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late SearchMoviesUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMoviesUseCase(mockMovieRepository);
  });

  final tMovieList = [
    const MovieEntity(
        id: 1,
        title: 'title 1',
        overview: 'overview 1',
        posterPath: 'posterPath1'),
    const MovieEntity(
        id: 2,
        title: 'title 2',
        overview: 'overview 2',
        posterPath: 'posterPath2'),
  ];

  const tQuery = 'Inception';

  test('should search movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(any))
        .thenAnswer((realInvocation) async => Right(tMovieList));

    // act
    final result = await usecase(tQuery);

    // assert
    expect(result, Right(tMovieList));
    verify(mockMovieRepository.searchMovies(any));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
