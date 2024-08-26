import 'package:spotify/core/usecases/usecase.dart';
import 'package:spotify/domain/repositories/song/song.dart';
import 'package:spotify/service_locator.dart';

class IsFavoriteSongUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongRepository>().isFavoriteSong(params!);
  }
}
