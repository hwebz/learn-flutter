import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MaterialApp(
      title: "Parallax Video Slider",
      debugShowCheckedModeBanner: false,
      home: ParallaxSlider()));
}

class ParallaxSlider extends StatefulWidget {
  const ParallaxSlider({super.key});

  @override
  State<ParallaxSlider> createState() => _ParallaxSliderState();
}

final videos = [
  'assets/videos/video1.mp4',
  'assets/videos/video2.mp4',
  'assets/videos/video3.mp4',
  'assets/videos/video4.mp4'
];

class _ParallaxSliderState extends State<ParallaxSlider> {
  PageController? _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    _controller = PageController(viewportFraction: 0.8);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height * 0.7,
          child: PageView.builder(
            controller: _controller!,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return VideoCard(
                  assetPath: videos[index],
                  isSelected: _selectedIndex == index);
            },
            onPageChanged: (index) => setState(() {
              _selectedIndex = index;
            }),
          ),
        ),
      ],
    ));
  }
}

class VideoCard extends StatefulWidget {
  final String assetPath;
  final bool isSelected;

  const VideoCard(
      {super.key, required this.assetPath, required this.isSelected});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController? _controller;
  final GlobalKey _videoKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath);

    _controller
      ?..addListener(() => setState(() {}))
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) => setState(() {}))
      ..play();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 100,
        margin: widget.isSelected
            ? const EdgeInsets.symmetric(vertical: 16, horizontal: 4)
            : const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 6),
                  blurRadius: 8)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Flow(
            delegate: ParallexFlowDelegate(
                scrollable: Scrollable.of(context),
                listItemContext: context,
                backgroundImageKey: _videoKey),
            children: [
              AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!, key: _videoKey))
            ],
          ),
        ));
  }
}

/// Update `ParallaxFlowDelegate`.
/// Works for horizontal scrolling.
class ParallexFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  ParallexFlowDelegate(
      {required this.scrollable,
      required this.listItemContext,
      required this.backgroundImageKey})
      : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(height: constraints.maxHeight);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.topCenter(Offset.zero),
        ancestor: scrollableBox);

    // Determine the parent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollableFraction =
        (listItemOffset.dx / viewportDimension).clamp(0.0, 1.0);

    // Calculate the horizontal alignment of the background
    // based on the scroll percent.
    final horizontalAlignment = Alignment(scrollableFraction * 2 - 1, 0);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect = horizontalAlignment.inscribe(
        backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(0,
        transform:
            Transform.translate(offset: Offset(childRect.left, 0)).transform);
  }

  @override
  bool shouldRepaint(ParallexFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
