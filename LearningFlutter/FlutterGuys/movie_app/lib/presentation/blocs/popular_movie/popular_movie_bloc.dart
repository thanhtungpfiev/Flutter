import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/movie_entity.dart';
import '../../../domain/usecases/get_popular_movies_usecase.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;

  PopularMovieBloc({required this.getPopularMoviesUseCase})
      : super(PopularMovieInitial()) {
    on<FetchPopularMovie>((event, emit) async {
      emit(PopularMovieLoading());
      final failureOrMovie = await getPopularMoviesUseCase();
      failureOrMovie.fold(
          (failure) => emit(PopularMovieError(failure.toString())),
          (movies) => emit(PopularMovieLoaded(movies)));
    });
  }
}
