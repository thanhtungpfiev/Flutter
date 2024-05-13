import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/blocs/popular_movie/popular_movie_bloc.dart';
import 'presentation/blocs/search_movie/search_movie_bloc.dart';
import 'presentation/blocs/trending_movie/trending_movie_bloc.dart';
import 'presentation/pages/home_screen.dart';

import 'injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                getIt<PopularMovieBloc>()..add(FetchPopularMovie()),
          ),
          BlocProvider(
            create: (context) =>
                getIt<TrendingMovieBloc>()..add(FetchTrendingMovie()),
          ),
          BlocProvider(
            create: (context) => getIt<SearchMovieBloc>(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
