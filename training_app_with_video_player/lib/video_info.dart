import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/colors.dart';

class VideoInfo extends StatefulWidget {
  const VideoInfo({super.key});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videos = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _isDispose = false;
  int _isPlayingIndex = -1;

  VideoPlayerController? _controller;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videos.json")
        .then((value) {
      setState(() {
        videos = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    _isDispose = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: _playArea == false
          ? BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                  AppColor.gradientFirst.withOpacity(0.9),
                  AppColor.gradientSecond.withOpacity(0.9)
                ],
                  begin: const FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight))
          : BoxDecoration(color: AppColor.gradientSecond),
      child: Column(
        children: [
          _playArea == false
              ? Container(
                  padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back_ios,
                                size: 20, color: AppColor.secondPageIconColor),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.info_outline,
                              size: 20, color: AppColor.secondPageIconColor)
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text("Legs Toning",
                          style: TextStyle(
                              fontSize: 25,
                              color: AppColor.secondPageTitleColor)),
                      const SizedBox(height: 5),
                      Text("and Glutes Workout",
                          style: TextStyle(
                              fontSize: 25,
                              color: AppColor.secondPageTitleColor)),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(colors: [
                                  AppColor.secondPageContainerGradient1stColor,
                                  AppColor.secondPageContainerGradient2ndColor
                                ])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.timer_outlined,
                                    size: 20,
                                    color: AppColor.homePageContainerTextSmall),
                                const SizedBox(width: 5),
                                Text("60 min",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColor
                                            .homePageContainerTextSmall))
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            height: 35,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(colors: [
                                  AppColor.secondPageContainerGradient1stColor,
                                  AppColor.secondPageContainerGradient2ndColor
                                ])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.handyman_outlined,
                                    size: 20,
                                    color: AppColor.homePageContainerTextSmall),
                                const SizedBox(width: 5),
                                Text("Resistent band, kettdlee",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColor
                                            .homePageContainerTextSmall))
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ))
              : Container(
                  child: Column(children: [
                    Container(
                        height: 100,
                        padding:
                            const EdgeInsets.only(top: 50, left: 30, right: 30),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                debugPrint("tapped");
                              },
                              child: Icon(Icons.arrow_back_ios,
                                  size: 20,
                                  color: AppColor.secondPageTopIconColor),
                            ),
                            Expanded(child: Container()),
                            Icon(Icons.info_outline,
                                size: 20,
                                color: AppColor.secondPageTopIconColor)
                          ],
                        )),
                    _playView(context),
                    _controlView(context)
                  ]),
                ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Row(
                  children: [
                    const SizedBox(width: 30),
                    Text("Circuit 1: Legs Toning",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.circuitsColor)),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        Icon(Icons.loop, size: 30, color: AppColor.loopColor),
                        Text("3 sets",
                            style: TextStyle(
                                fontSize: 15, color: AppColor.setsColor)),
                        const SizedBox(width: 20)
                      ],
                    )
                  ],
                ),
                Expanded(
                    child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8),
                      itemCount: videos.length,
                      itemBuilder: (_, int index) {
                        return GestureDetector(
                            onTap: () {
                              // debugPrint(index.toString());
                              _onTapVideo(index);
                              if (_playArea == false) {
                                _playArea = true;
                              }
                            },
                            child: _listView(index));
                      }),
                ))
              ],
            ),
          ))
        ],
      ),
    ));
  }

  _listView(int index) {
    return Container(
        height: 135,
        padding: const EdgeInsets.only(top: 10),
        width: 200,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.gradientSecond.withOpacity(0.2),
                      image: DecorationImage(
                          image: AssetImage(videos[index]["thumbnail"]),
                          scale: 0.5)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(videos[index]["title"],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(videos[index]["time"])
                  ],
                )
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 80,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xFFeaeefc),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("15s rest",
                      style: TextStyle(color: Color(0xff839fed))),
                ),
                Row(
                  children: [
                    Container(),
                    Row(
                      children: [
                        for (int i = 0; i < 70; i++)
                          i.isEven
                              ? Container(
                                  width: 3,
                                  height: 1,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF839fed),
                                      borderRadius: BorderRadius.circular(2)),
                                )
                              : Container(
                                  width: 3,
                                  height: 1,
                                )
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }

  _playView(BuildContext context) {
    final controller = _controller;
    if (controller!.value.isInitialized) {
      return AspectRatio(aspectRatio: 16 / 9, child: VideoPlayer(controller));
    } else {
      return const AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: Text("Loading video...",
                  style: TextStyle(fontSize: 20, color: Colors.white60))));
    }
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller!.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);
    double progress = max(0, min(_progress * 100, 100));
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColor.gradientSecond,
      margin: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.red[700],
                  inactiveTrackColor: Colors.red[100],
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 2.0,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                  thumbColor: Colors.redAccent,
                  overlayColor: Colors.red.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28),
                  tickMarkShape: RoundSliderTickMarkShape(),
                  inactiveTickMarkColor: Colors.red[100],
                  activeTickMarkColor: Colors.red[700],
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: Colors.redAccent,
                  valueIndicatorTextStyle: TextStyle(color: Colors.white)),
              child: Slider(
                value: progress,
                min: 0,
                max: 100,
                divisions: 100,
                label: Duration(
                        milliseconds:
                            (duration * progress / 100).toInt() * 1000)
                    .toString()
                    .split(".")[0],
                onChanged: (value) {
                  setState(() {
                    _progress = value * 0.01;
                    progress = max(0, min(value, 100));
                  });
                },
                onChangeStart: (value) {
                  _controller!.pause();
                },
                onChangeEnd: (value) {
                  final duration = _controller!.value.duration;
                  if (duration != null) {
                    var newValue = max(0, min(value, 99)) * 0.01;
                    var millis = (duration.inMilliseconds * newValue).toInt();
                    _controller!.seekTo(Duration(milliseconds: millis));
                    _controller!.play();
                  }
                },
              )),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (noMute) {
                        _controller!.setVolume(0);
                      } else {
                        _controller!.setVolume(1);
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 4.0,
                            color: Color.fromARGB(50, 0, 0, 0))
                      ]),
                      child: Icon(noMute ? Icons.volume_up : Icons.volume_off,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    // Infinite previous
                    // final index =
                    //     _isPlayingIndex == 0 ? videos.length - 1 : _isPlayingIndex - 1;
                    final index = _isPlayingIndex - 1;
                    if (index >= 0 && videos.length >= 0) {
                      _onTapVideo(index);
                    } else {
                      Get.snackbar("Video List", "",
                          snackPosition: SnackPosition.TOP,
                          icon: Icon(Icons.face, size: 30, color: Colors.black),
                          backgroundColor: AppColor.homePageBackground,
                          messageText: Text("No more videos before",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black)));
                    }
                  },
                  child: Icon(Icons.fast_rewind, size: 36, color: Colors.white),
                ),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    if (_isPlaying) {
                      _controller!.pause();
                    } else {
                      _controller!.play();
                    }
                  },
                  child: Icon(
                      _isPlaying ? Icons.pause_circle : Icons.play_circle,
                      size: 36,
                      color: Colors.white),
                ),
                SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    // Infinite next
                    // final index =
                    //     _isPlayingIndex == videos.length - 1 ? 0 : _isPlayingIndex + 1;
                    final index = _isPlayingIndex + 1;
                    if (index >= 0 && index < videos.length) {
                      _onTapVideo(index);
                    } else {
                      Get.snackbar("Video List", "",
                          snackPosition: SnackPosition.TOP,
                          icon: Icon(Icons.face, size: 30, color: Colors.black),
                          backgroundColor: AppColor.homePageBackground,
                          messageText: Text("No more videos ahead",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black)));
                    }
                  },
                  child:
                      Icon(Icons.fast_forward, size: 36, color: Colors.white),
                ),
                SizedBox(width: 15),
                Text("$mins:$secs",
                    style: TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          offset: Offset(0.0, 1.0),
                          blurRadius: 4.0,
                          color: Color.fromARGB(150, 0, 0, 0))
                    ]))
              ]),
        ],
      ),
    );
  }

  var _onUpdateControllerTime;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;
  void _onControllerUpdate() async {
    final controller = _controller;
    if (_isDispose) {
      return;
    }

    final now = DateTime.now().microsecondsSinceEpoch;
    _onUpdateControllerTime = 0;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    if (controller == null) {
      debugPrint("controller is null");
      return;
    }

    if (!controller.value.isInitialized) {
      debugPrint("controller can't be initialized");
    }

    if (_duration == null) {
      _duration = _controller!.value.duration;
    }
    var duration = _duration;
    if (duration == null) return;

    var position = await controller.position;
    _position = position;

    final playing = controller!.value.isPlaying;
    if (playing) {
      if (_isDispose) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    setState(() {
      _isPlaying = playing;
    });
  }

  _onTapVideo(int index) {
    final controller =
        VideoPlayerController.networkUrl(Uri.parse(videos[index]['videoUrl']));
    final old = _controller;
    _controller = controller;

    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }

    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.play();
        controller.addListener(_onControllerUpdate);
        setState(() {});
      });
  }
}
