import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/home/bloc/playlists_cubit.dart';
import 'package:spotify/presentation/home/bloc/playlists_state.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

class Playlists extends StatelessWidget {
  const Playlists({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => PlaylistsCubit()..getPlaylists(),
        child: BlocBuilder<PlaylistsCubit, PlaylistsState>(
          builder: (context, state) {
            if (state is PlaylistsLoading) {
              // ignore: prefer_const_constructors
              return Align(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }

            if (state is PlaylistsLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                child: Column(children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Playlist",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("See More",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Color(0xFFC6C6C6)))
                    ],
                  ),
                  const SizedBox(height: 20),
                  _songs(state.playlists)
                ]),
              );
            }

            return Container();
          },
        ));
  }

  Widget _songs(List<SongEntity> playlists) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SongPlayerPage(
                            songEntity: playlists[index],
                          )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkMode
                              ? AppColors.darkGrey
                              : const Color(0xFFE6E6E6),
                        ),
                        child: Icon(Icons.play_arrow_rounded,
                            size: 30,
                            color: context.isDarkMode
                                ? const Color(0xFF959595)
                                : const Color(0xFF555555)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(playlists[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(playlists[index].artist,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 12)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    Text(playlists[index]
                        .duration
                        .toString()
                        .replaceAll('.', ':')),
                    const SizedBox(width: 20),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline_outlined,
                            size: 25, color: AppColors.darkGrey))
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, state) => const SizedBox(height: 20),
        itemCount: playlists.length);
  }
}
