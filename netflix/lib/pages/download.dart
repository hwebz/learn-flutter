import 'package:flutter/material.dart';

class Download extends StatefulWidget {
  const Download({super.key});

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black, appBar: getAppBar(), body: getBody());
  }

  AppBar getAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: const Text("My downloads",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
      ],
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: 50,
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
            child: const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Smart Downloads",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(width: 10),
                    Text("ON",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue))
                  ],
                ))),
        SizedBox(height: 60),
        Column(
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2), shape: BoxShape.circle),
              child: Center(
                child: Icon(Icons.file_download,
                    size: 80, color: Colors.grey.withOpacity(0.3)),
              ),
            )
          ],
        ),
        SizedBox(height: 30),
        Text("Never be without Netflix",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Text(
              "Download shows and movies so you'll never be without something to watch even when you are offline.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.4)),
        ),
        SizedBox(height: 30),
        Stack(
          children: [
            Container(
              height: 50,
              width: size.width * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Text("See what you can download",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))),
            ),
            Positioned.fill(
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      splashColor: Colors.black.withOpacity(0.5),
                    )))
          ],
        ),
      ],
    );
  }
}
