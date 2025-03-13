import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/core/configs/assets/app_images.dart';
import 'package:netflix/presentation/home/bloc/trending_movies_cubit.dart';
import 'package:netflix/presentation/home/bloc/trending_movies_state.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingMoviesCubit()..getTrendingMovies(),
      child: BlocBuilder<TrendingMoviesCubit, TrendingMoviesState>(
        builder: (context, state) {
          if (state is TrendingMoviesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TrendingMoviesLoadedState) {
            return FanCarouselImageSlider.sliderType1(
              imagesLink:
                  state.movies
                      .map(
                        (item) =>
                            AppImages.movieImageBasePath +
                            item.posterPath.toString(),
                      )
                      .toList(),
              isAssets: false,
              autoPlay: false,
              sliderHeight: 400,
              showIndicator: true,
            );
          } else if (state is TrendingMoviesLoadErrorState) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
