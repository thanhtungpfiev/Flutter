import 'package:dartz/dartz.dart';
import 'package:spotify_clone/data/datasources/song/song_service.dart';
import 'package:spotify_clone/domain/repositories/song/song_repository.dart';

class SongRepositoryImpl extends SongRepository {
  final SongService songService;

  SongRepositoryImpl(this.songService);

  @override
  Future<Either> getNewsSongs() async {
    return await songService.getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await songService.getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return await songService.addOrRemoveFavoriteSong(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await songService.isFavoriteSong(songId);
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    return await songService.getUserFavoriteSongs();
  }
}
