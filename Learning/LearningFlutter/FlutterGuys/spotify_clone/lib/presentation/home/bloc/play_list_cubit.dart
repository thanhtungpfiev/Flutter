import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_play_list_usecase.dart';
import 'play_list_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  final GetPlayListUseCase getPlayListUseCase;

  PlayListCubit(this.getPlayListUseCase) : super(PlayListLoading());

  Future<void> getPlayList() async {
    emit(PlayListLoading());
    var returnedSongs = await getPlayListUseCase.call();
    returnedSongs.fold(
      (l) {
        emit(PlayListLoadFailure());
      },
      (data) {
        emit(PlayListLoaded(songs: data));
      },
    );
  }
}
