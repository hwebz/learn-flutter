import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:spotify/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/song.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;

  const FavoriteButton({super.key, required this.songEntity, this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit()..isFavorite(songEntity.songId),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          var favoriteButtonCubit = context.read<FavoriteButtonCubit>();

          if (state is FavoriteButtonInitial) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          }

          if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                favoriteButtonCubit.favoriteButtonUpdated(songEntity.songId);

                if (function != null) {
                  function!();
                }
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 25,
                color: AppColors.darkGrey,
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
