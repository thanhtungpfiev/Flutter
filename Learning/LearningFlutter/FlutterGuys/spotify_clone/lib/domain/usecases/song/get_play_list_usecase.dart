import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/configs/usecase/usecase.dart';
import 'package:spotify_clone/domain/repositories/song/song_repository.dart';

class GetPlayListUseCase implements UseCase<Either, dynamic> {
  final SongRepository songRepository;

  GetPlayListUseCase(this.songRepository);

  @override
  Future<Either> call({params}) async {
    return await songRepository.getPlayList();
  }
}
