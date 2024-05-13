import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

import 'package:clean_architecture_v2/src/config/router/app_router.dart';
import 'package:clean_architecture_v2/src/config/themes/app_themes.dart';
import 'package:clean_architecture_v2/src/domain/repositories/api_repository.dart';
import 'package:clean_architecture_v2/src/locator.dart';
import 'package:clean_architecture_v2/src/presentation/cubits/remote_articles/remote_articles_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RemoteArticlesCubit(
            locator<ApiRepository>(),
          )..getBreakingNewsArticles(),
        ),
      ],
      child: OKToast(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter.config(),
          theme: AppTheme.light,
        ),
      ),
    );
  }
}
