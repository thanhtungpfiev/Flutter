import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/configs/usecase/usecase.dart';
import 'package:spotify_clone/domain/repositories/song/song_repository.dart';

class GetFavoriteSongsUseCase implements UseCase<Either, dynamic> {
  final SongRepository songRepository;

  GetFavoriteSongsUseCase(this.songRepository);

  @override
  Future<Either> call({params}) async {
    return await songRepository.getUserFavoriteSongs();
  }
}
