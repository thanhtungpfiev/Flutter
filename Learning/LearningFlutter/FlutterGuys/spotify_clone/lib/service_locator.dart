import 'package:get_it/get_it.dart';
import 'package:spotify_clone/data/datasources/auth/auth_firebase_service.dart';
import 'package:spotify_clone/data/datasources/auth/auth_service.dart';
import 'package:spotify_clone/data/datasources/song/song_firebase_service.dart';
import 'package:spotify_clone/data/datasources/song/song_service.dart';
import 'package:spotify_clone/data/repositories/auth/auth_repository_impl.dart';
import 'package:spotify_clone/data/repositories/song/song_repository_impl.dart';
import 'package:spotify_clone/domain/repositories/auth/auth_repository.dart';
import 'package:spotify_clone/domain/repositories/song/song_repository.dart';
import 'package:spotify_clone/domain/usecases/auth/signin_usecase.dart';
import 'package:spotify_clone/domain/usecases/auth/signup_usecase.dart';
import 'package:spotify_clone/domain/usecases/song/add_or_remove_favorite_song_usecase.dart';
import 'package:spotify_clone/domain/usecases/song/get_new_song_usecase.dart';
import 'package:spotify_clone/domain/usecases/song/get_play_list_usecase.dart';
import 'package:spotify_clone/domain/usecases/song/is_favorite_song_usecase.dart';
import 'package:spotify_clone/domain/usecases/song/get_favorite_songs_usecase.dart';
import 'package:spotify_clone/domain/usecases/auth/get_user_usecase.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_clone/presentation/home/bloc/play_list_cubit.dart';
import 'package:spotify_clone/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_clone/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify_clone/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify_clone/presentation/profile/bloc/profile_info_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<AuthService>(() => AuthFirebaseService());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<SignupUseCase>(() => SignupUseCase(sl()));
  sl.registerLazySingleton<SigninUseCase>(() => SigninUseCase(sl()));
  sl.registerLazySingleton<SongService>(() => SongFirebaseService());
  sl.registerLazySingleton<SongRepository>(() => SongRepositoryImpl(sl()));
  sl.registerLazySingleton<GetNewsSongsUseCase>(
    () => GetNewsSongsUseCase(sl()),
  );
  sl.registerLazySingleton<GetPlayListUseCase>(() => GetPlayListUseCase(sl()));
  sl.registerLazySingleton<AddOrRemoveFavoriteSongUseCase>(
    () => AddOrRemoveFavoriteSongUseCase(sl()),
  );
  sl.registerLazySingleton<IsFavoriteSongUseCase>(
    () => IsFavoriteSongUseCase(sl()),
  );
  sl.registerLazySingleton<GetFavoriteSongsUseCase>(
    () => GetFavoriteSongsUseCase(sl()),
  );
  sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(sl()));
  sl.registerFactory<NewsSongsCubit>(() => NewsSongsCubit(sl()));
  sl.registerFactory<PlayListCubit>(() => PlayListCubit(sl()));
  sl.registerFactory<SongPlayerCubit>(() => SongPlayerCubit());
  sl.registerFactory<FavoriteButtonCubit>(() => FavoriteButtonCubit(sl()));
  sl.registerFactory<FavoriteSongsCubit>(() => FavoriteSongsCubit(sl()));
  sl.registerFactory<ProfileInfoCubit>(() => ProfileInfoCubit(sl()));
}
