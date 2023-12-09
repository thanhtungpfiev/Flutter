import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/movie_entity.dart';
import '../../../domain/usecases/get_trending_movies_usecase.dart';

part 'trending_movie_event.dart';
part 'trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  final GetTrendingMoviesUseCase getTrendingMoviesUseCase;
  TrendingMovieBloc({required this.getTrendingMoviesUseCase})
      : super(TrendingMovieInitial()) {
    on<FetchTrendingMovie>((event, emit) async {
      emit(TrendingMovieLoading());
      final failureOrMovie = await getTrendingMoviesUseCase();
      failureOrMovie.fold(
          (failure) => emit(TrendingMovieError(failure.toString())),
          (movies) => emit(TrendingMovieLoaded(movies)));
    });
  }
}
