import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/home/bloc/new_songs_cubit.dart';
import 'package:spotify/presentation/home/bloc/new_songs_state.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewSongsCubit()..getNewSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewSongsCubit, NewSongsState>(
          builder: (context, state) {
            if (state is NewSongsLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }

            if (state is NewSongsLoaded) {
              return _songs(state.songs);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SongPlayerPage(
                              songEntity: songs[index],
                            )));
              },
              child: SizedBox(
                  width: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(songs[index].image))),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 40,
                              height: 40,
                              transform: Matrix4.translationValues(10, 10, 0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.isDarkMode
                                    ? AppColors.darkGrey
                                    : const Color(0xFFE6E6E6),
                              ),
                              child: Icon(Icons.play_arrow_rounded,
                                  color: context.isDarkMode
                                      ? const Color(0xFF959595)
                                      : const Color(0xFF555555)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(songs[index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Text(songs[index].artist,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12)),
                    ],
                  )),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemCount: songs.length);
  }
}
