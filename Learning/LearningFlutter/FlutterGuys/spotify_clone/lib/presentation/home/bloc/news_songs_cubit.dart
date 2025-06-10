import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_new_song_usecase.dart';
import 'package:spotify_clone/presentation/home/bloc/news_songs_state.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  final GetNewsSongsUseCase getNewsSongsUseCase;

  NewsSongsCubit(this.getNewsSongsUseCase) : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await getNewsSongsUseCase.call();
    returnedSongs.fold(
      (l) {
        emit(NewsSongsLoadFailure());
      },
      (data) {
        emit(NewsSongsLoaded(songs: data));
      },
    );
  }
}
