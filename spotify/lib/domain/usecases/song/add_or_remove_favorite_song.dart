import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecases/usecase.dart';
import 'package:spotify/domain/repositories/song/song.dart';
import 'package:spotify/service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepository>().addOrRemoveFavoriteSong(params!);
  }
}
