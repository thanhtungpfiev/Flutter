import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/configs/usecase/usecase.dart';
import 'package:spotify_clone/domain/repositories/song/song_repository.dart';

class GetNewsSongsUseCase implements UseCase<Either, dynamic> {
  final SongRepository songRepository;

  GetNewsSongsUseCase(this.songRepository);

  @override
  Future<Either> call({params}) async {
    return await songRepository.getNewsSongs();
  }
}
