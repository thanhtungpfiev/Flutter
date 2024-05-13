import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/search_movies_usecase.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchMoviesUseCase searchMoviesUseCase;
  SearchMovieBloc({required this.searchMoviesUseCase})
      : super(SearchMovieInitial()) {
    on<SearchMovieEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
