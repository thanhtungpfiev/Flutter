import 'package:spotify_clone/core/configs/usecase/usecase.dart';
import 'package:spotify_clone/domain/repositories/song/song_repository.dart';

class IsFavoriteSongUseCase implements UseCase<bool, String> {
  final SongRepository songRepository;

  IsFavoriteSongUseCase(this.songRepository);

  @override
  Future<bool> call({String? params}) async {
    return await songRepository.isFavoriteSong(params!);
  }
}
