import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/pages/call_screen.dart';
import 'package:whatsapp/pages/camera_screen.dart';
import 'package:whatsapp/pages/chat_screen.dart';
import 'package:whatsapp/pages/status_screen.dart';

class WhatsAppHome extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const WhatsAppHome({super.key, this.cameras});

  @override
  State<WhatsAppHome> createState() {
    return _WhatsAppHome();
  }
}

class _WhatsAppHome extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _tabController?.addListener(() {
      if (_tabController?.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("WhatsApp"),
            elevation: 0.7,
            bottom: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                tabs: const <Widget>[
                  Tab(icon: Icon(Icons.camera_alt)),
                  Tab(text: "Chats"),
                  Tab(text: "Status"),
                  Tab(text: "Calls"),
                ]),
            actions: const <Widget>[
              Icon(Icons.search),
              Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
              Icon(Icons.more_vert)
            ]),
        body: TabBarView(controller: _tabController, children: <Widget>[
          CameraScreen(widget.cameras),
          ChatScreen(),
          const StatusScreen(),
          const CallScreen(),
        ]));
  }
}
