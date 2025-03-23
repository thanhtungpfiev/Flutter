import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netflix/common/helper/widgets/app_bar.dart';
import 'package:netflix/core/configs/assets/app_vectors.dart';
import 'package:netflix/presentation/home/widgets/category_text.dart';
import 'package:netflix/presentation/home/widgets/trending_movies.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        title: SvgPicture.asset(AppVectors.logo),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [CategoryText(title: 'Trendings 🔥'), TrendingMovies()],
        ),
      ),
    );
  }
}
