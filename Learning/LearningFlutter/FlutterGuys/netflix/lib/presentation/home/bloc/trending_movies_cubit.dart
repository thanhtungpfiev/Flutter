import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/domain/movie/usecases/get_trending_movies_usecase.dart';
import 'package:netflix/presentation/home/bloc/trending_movies_state.dart';

class TrendingMoviesCubit extends Cubit<TrendingMoviesState> {
  TrendingMoviesCubit() : super(TrendingMoviesLoadingState());

  void getTrendingMovies() async {
    final response = await GetTrendingMoviesUseCase().call();
    response.fold(
      (error) =>
          emit(TrendingMoviesLoadErrorState(errorMessage: error.toString())),
      (movies) => emit(TrendingMoviesLoadedState(movies: movies)),
    );
  }
}
