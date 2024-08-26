import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecases/usecase.dart';
import 'package:spotify/domain/repositories/song/song.dart';
import 'package:spotify/service_locator.dart';

class GetPlaylistsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepository>().getPlaylists();
  }
}