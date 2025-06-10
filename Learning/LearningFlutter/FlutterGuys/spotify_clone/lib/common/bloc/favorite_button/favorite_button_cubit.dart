import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify_clone/domain/usecases/song/add_or_remove_favorite_song_usecase.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  final AddOrRemoveFavoriteSongUseCase addOrRemoveFavoriteSongUseCase;

  FavoriteButtonCubit(this.addOrRemoveFavoriteSongUseCase)
    : super(FavoriteButtonInitial());

  Future<void> favoriteButtonUpdated(String songId) async {
    var result = await addOrRemoveFavoriteSongUseCase.call(params: songId);
    result.fold((l) {}, (isFavorite) {
      emit(FavoriteButtonUpdated(isFavorite: isFavorite));
    });
  }
}
