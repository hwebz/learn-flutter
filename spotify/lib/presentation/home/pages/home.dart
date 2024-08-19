// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/home/widgets/new_songs.dart';
import 'package:spotify/presentation/home/widgets/playlists.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _homeArtistCard(),
          _tabs(),
          SizedBox(
            height: 260,
            child: TabBarView(
              controller: _tabController,
              children: [
                const NewSongs(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
          const Playlists(),
        ],
      )),
    );
  }

  Widget _homeArtistCard() {
    return Center(
      child: SizedBox(
          height: 140,
          child: Stack(children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppVectors.homeTopCard)),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Image.asset(AppImages.homeArtist),
                ))
          ])),
    );
  }

  Widget _tabs() {
    return TabBar(
        controller: _tabController,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        isScrollable: true,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
              width: 4.0, color: AppColors.primary), // Thickness and color
          insets: EdgeInsets.only(left: 10, right: 10),
        ),
        tabs: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text('News',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text('Videos',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text('Artists',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text('Podcasts',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          )
        ]);
  }
}
