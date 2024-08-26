import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/format_duration.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/favorite_button/favorite_button.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text('Profile'),
        backgroundColor:
            context.isDarkMode ? const Color(0xFF2C2B2B) : Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          const SizedBox(height: 30),
          _favoriteSongs()
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileInfoCubit()..getUser(),
        child: Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: double.infinity,
          decoration: BoxDecoration(
              color:
                  context.isDarkMode ? const Color(0xFF2C2B2B) : Colors.white,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
              if (state is ProfileInfoLoading) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              }

              if (state is ProfileInfoLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          image: DecorationImage(
                              image: NetworkImage(state.user.imageURL!),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(height: 30),
                    Text(state.user.email!),
                    const SizedBox(height: 10),
                    Text(state.user.fullName!,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                );
              }

              if (state is ProfileInfoFailure) {
                return const Text('Failed to load user');
              }

              return Container();
            },
          ),
        ));
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('FAVORITE SONGS'),
              const SizedBox(height: 10),
              BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
                  builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator());
                }

                if (state is FavoriteSongsLoaded) {
                  return Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var selectedSong = state.songs[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SongPlayerPage(
                                            songEntity: selectedSong,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    selectedSong.image),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(selectedSong.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16)),
                                              Text(selectedSong.artist,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Row(
                                    children: [
                                      Text(formatDuration(
                                          selectedSong.duration)),
                                      const SizedBox(width: 20),
                                      FavoriteButton(
                                        songEntity: selectedSong,
                                        key: UniqueKey(),
                                        function: () {
                                          context
                                              .read<FavoriteSongsCubit>()
                                              .removeSong(index);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount: state.songs.length),
                  );
                }

                if (state is FavoriteSongsFailure) {
                  return const Text('Failed to load favorite songs');
                }

                return Container();
              })
            ],
          ),
        ),
      ),
    );
  }
}
