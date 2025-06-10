import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/configs/usecase/usecase.dart';
import 'package:spotify_clone/domain/repositories/song/song_repository.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  final SongRepository songRepository;

  AddOrRemoveFavoriteSongUseCase(this.songRepository);

  @override
  Future<Either> call({String? params}) async {
    return await songRepository.addOrRemoveFavoriteSongs(params!);
  }
}
