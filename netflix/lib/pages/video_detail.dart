import 'package:flutter/material.dart';
import 'package:netflix/json/video_detail_json.dart';
import 'package:video_player/video_player.dart';

class VideoDetail extends StatefulWidget {
  final String videoUrl;

  const VideoDetail({super.key, required this.videoUrl});

  @override
  State<VideoDetail> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  late VideoPlayerController _controller;
  bool isMuted = false;
  int activeMenu = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((value) {
        setState(() {
          _controller.setVolume(isMuted ? 0 : 100);
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: getAppBar(context: context),
        body: getBody());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  AppBar getAppBar({required BuildContext context}) {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
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
        ]);
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Container(
                width: size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller)),
                    Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.2)),
                    ),
                    Center(
                        child: Icon(
                      _controller.value.isPlaying ? null : Icons.play_arrow,
                      color: Colors.white,
                      size: 50,
                    )),
                    Positioned(
                      left: 5,
                      bottom: 35,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 13, right: 13, top: 8, bottom: 8),
                          child: Text("Preview",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      bottom: 35,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMuted = !isMuted;
                            _controller.setVolume(isMuted ? 0 : 100);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 13, right: 13, top: 8, bottom: 8),
                            child: Icon(
                                isMuted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: size.height - 370,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Age of Samuria: Battle for Japan",
                          style: TextStyle(
                              height: 1.4,
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text("New",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.green.withOpacity(0.5),
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 15),
                          Text(
                            "2021",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 15),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.white.withOpacity(0.2)),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 6, right: 6, top: 4, bottom: 4),
                                child: Text("18+",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                              )),
                          const SizedBox(width: 15),
                          Text(
                            "1 Season",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 15),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                      width: 2)),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 6, right: 6, top: 4, bottom: 4),
                                child: Text("HD",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text("Watch Season 1 Now",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          Container(
                            width: size.width,
                            height: 38,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.play_arrow, color: Colors.black),
                                  SizedBox(width: 5),
                                  Text("Resume")
                                ]),
                          ),
                          Positioned.fill(
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {},
                                    splashColor: Colors.black.withOpacity(0.2),
                                  )))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          Container(
                            width: size.width,
                            height: 38,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.file_download, color: Colors.white),
                                SizedBox(width: 5),
                                Text("Dowload",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                          Positioned.fill(
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(onTap: () {})))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text("S1:E1 The Rise of Nobunaga",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: (size.width - 30) * 0.75,
                            child: Stack(
                              children: [
                                Container(
                                  width: (size.width - 30) * 0.75,
                                  height: 2.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.withOpacity(0.5)),
                                ),
                                Container(
                                  width: (size.width - 30) * 0.235,
                                  height: 2.5,
                                  decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(5)),
                                )
                              ],
                            ),
                          ),
                          const Text("35 remaning",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ))
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movieList[0]['description'],
                        style: TextStyle(
                            height: 1.4, color: Colors.grey.withOpacity(0.9)),
                      ),
                      const SizedBox(height: 8),
                      Text(
                          "Cast: Masayoshi Haneda, Masami Kosaka, Hideaki Ito... more",
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.9),
                              height: 1.4,
                              fontSize: 13)),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              likesList.length,
                              (index) => Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Icon(likesList[index]['icon'],
                                                color: Colors.white
                                                    .withOpacity(0.9),
                                                size: 25),
                                            const SizedBox(height: 5),
                                            Text(likesList[index]['text'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    height: 1.4,
                                                    color: Colors.grey
                                                        .withOpacity(0.9)))
                                          ],
                                        ),
                                      ),
                                      Positioned.fill(
                                          child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          onTap: () {},
                                        ),
                                      ))
                                    ],
                                  ))),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              episodesList.length,
                              (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        activeMenu = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 25),
                                      child: Column(children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                border: activeMenu == index
                                                    ? const Border(
                                                        top: BorderSide(
                                                            color: Colors.red,
                                                            width: 4))
                                                    : null),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 12),
                                              child: Text(episodesList[index],
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(
                                                              activeMenu ==
                                                                      index
                                                                  ? 0.9
                                                                  : 0.5),
                                                      fontSize: 16)),
                                            ))
                                      ]),
                                    ),
                                  )),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text("Season 1",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 15),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              movieList.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                width: (size.width - 30) * 0.85,
                                                height: 100,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width: 150,
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Container(
                                                              width: 150,
                                                              height: 90,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          movieList[index]
                                                                              [
                                                                              'img']))),
                                                            ),
                                                            Container(
                                                              width: 150,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.3),
                                                              ),
                                                            ),
                                                            Container(
                                                                width: 38,
                                                                height: 38,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        width:
                                                                            2,
                                                                        color: Colors
                                                                            .white)),
                                                                child:
                                                                    const Center(
                                                                  child: Icon(
                                                                      Icons
                                                                          .play_arrow,
                                                                      color: Colors
                                                                          .white),
                                                                ))
                                                          ],
                                                        )),
                                                    Container(
                                                        width:
                                                            size.width * 0.35,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  movieList[
                                                                          index]
                                                                      ['title'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      height:
                                                                          1.3,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.9))),
                                                              const SizedBox(
                                                                  height: 3),
                                                              Text(
                                                                  movieList[
                                                                          index]
                                                                      [
                                                                      'duration'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      height:
                                                                          1.3,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.5)))
                                                            ],
                                                          ),
                                                        ))
                                                  ],
                                                )),
                                            Container(
                                                width: (size.width - 30) * 0.15,
                                                height: 100,
                                                child: Center(
                                                  child: Icon(
                                                      Icons.file_download,
                                                      color: Colors.white
                                                          .withOpacity(0.7)),
                                                ))
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Text(movieList[index]['description'],
                                            style: TextStyle(
                                                height: 1.4,
                                                color: Colors.white
                                                    .withOpacity(0.5)))
                                      ],
                                    ),
                                  ))),
                      const SizedBox(height: 50)
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
