import 'package:spotify/domain/entities/song/song.dart';

abstract class PlaylistsState {}

class PlaylistsLoading extends PlaylistsState {}

class PlaylistsLoaded extends PlaylistsState {
  final List<SongEntity> playlists;

  PlaylistsLoaded({required this.playlists});
}

class PlaylistsLoadFailure extends PlaylistsState {}
