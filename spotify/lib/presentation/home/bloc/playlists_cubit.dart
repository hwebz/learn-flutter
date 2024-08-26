import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/domain/usecases/song/get_playlists.dart';
import 'package:spotify/presentation/home/bloc/playlists_state.dart';
import 'package:spotify/service_locator.dart';

class PlaylistsCubit extends Cubit<PlaylistsState> {
  PlaylistsCubit() : super(PlaylistsLoading());

  Future<void> getPlaylists() async {
    var returnedPlaylists = await sl<GetPlaylistsUseCase>().call();

    returnedPlaylists.fold((l) => {emit(PlaylistsLoadFailure())},
        (data) => {emit(PlaylistsLoaded(playlists: data))});
  }

  void toggleSongFavorite() {
    if (state is PlaylistsLoaded) {
      emit(PlaylistsLoaded(
          playlists: (state as PlaylistsLoaded).playlists.map((e) {
        return e.copyWith(isFavorite: !e.isFavorite);
      }).toList()));
    }
  }
}
