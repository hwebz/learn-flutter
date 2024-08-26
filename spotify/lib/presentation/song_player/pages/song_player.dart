import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/format_duration.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text('Now Playing', style: TextStyle(fontSize: 18)),
        actions: IconButton(
            onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(songEntity.url),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _songCover(context),
                const SizedBox(height: 20),
                _songDetail(),
                const SizedBox(height: 30),
                _songPlayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
            fit: BoxFit.cover, image: NetworkImage(songEntity.image)),
      ),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(songEntity.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            Text(songEntity.artist,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
          ],
        ),
        FavoriteButton(songEntity: songEntity)
      ],
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
      var songPlayerCubit = context.read<SongPlayerCubit>();
      if (state is SongPlayerLoading) {
        return const CircularProgressIndicator();
      }

      if (state is SongPlayerLoaded) {
        return Column(
          children: [
            Slider(
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {}),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatDuration(songPlayerCubit.songPosition)),
                Text(formatDuration(songPlayerCubit.songDuration))
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                songPlayerCubit.playOrPauseSong();
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Icon(songPlayerCubit.audioPlayer.playing
                    ? Icons.pause
                    : Icons.play_arrow),
              ),
            )
          ],
        );
      }

      return Container();
    });
  }
}
