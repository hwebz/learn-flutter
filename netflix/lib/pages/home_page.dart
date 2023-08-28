import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netflix/json/home_json.dart';
import 'package:netflix/pages/video_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: getBody());
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                width: size.height - 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                            height: 500,
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/banner.webp"),
                                    fit: BoxFit.cover))),
                        Container(
                          height: 500,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Colors.black.withOpacity(0.85),
                                Colors.black.withOpacity(0)
                              ],
                                  end: Alignment.topCenter,
                                  begin: Alignment.bottomCenter)),
                        ),
                        Container(
                            height: 500,
                            width: size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/title_img.webp",
                                    width: 300),
                                const SizedBox(height: 15),
                                const Text(
                                    "Excting - Sci-Fi Drame - Sci-Fi Adventure",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11))
                              ],
                            ))
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Column(
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 25),
                            SizedBox(height: 5),
                            Text("My List",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white))
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const VideoDetail(
                                        videoUrl:
                                            "assets/videos/video_1.mp4")));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    right: 13, left: 8, top: 2, bottom: 2),
                                child: Row(
                                  children: [
                                    Icon(Icons.play_arrow,
                                        color: Colors.black, size: 30),
                                    SizedBox(width: 5),
                                    Text("Play",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              )),
                        ),
                        const Column(
                          children: [
                            Icon(Icons.info_outline,
                                color: Colors.white, size: 25),
                            SizedBox(height: 5),
                            Text("Info",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white))
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(children: [
                        renderList(title: "My List", list: mylist),
                        renderList(
                            title: "Popular on Netflix", list: popularList),
                        renderList(title: "Trending Now", list: trendingList),
                        renderList(
                            title: "Netflix Originals",
                            list: originalList,
                            isBig: true),
                        renderList(title: "Anime", list: animeList)
                      ]),
                    )
                  ],
                )),
            Container(
                child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Image.asset("assets/images/logo.ico",
                            width: 35, fit: BoxFit.cover),
                      ),
                      Row(children: [
                        const IconButton(
                            onPressed: null,
                            icon: Icon(Icons.collections_bookmark,
                                color: Colors.white, size: 28)),
                        IconButton(
                            onPressed: null,
                            icon: Image.asset(
                              "assets/images/profile.jpeg",
                              width: 26,
                              height: 26,
                              fit: BoxFit.cover,
                            ))
                      ])
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("TV Shows",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      Text("Movies",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Text("Categories",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(width: 3),
                          Icon(Icons.keyboard_arrow_down, color: Colors.white)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget renderList(
      {required String title, required List list, bool isBig = false}) {
    var videoId = Random().nextInt(3);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: List.generate(
                  list.length,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => VideoDetail(
                                      videoUrl:
                                          "assets/videos/video_$videoId.mp4")));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: isBig ? 165 : 110,
                          height: isBig ? 300 : 160,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(list[index]['img']),
                                  fit: BoxFit.cover),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(6)),
                        ),
                      )),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
