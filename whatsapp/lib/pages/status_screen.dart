import 'package:flutter/material.dart';
import 'package:whatsapp/pages/store_page_view.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xfff2f2f2),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                color: Colors.white,
                elevation: 0.0,
                child: ListTile(
                  leading: Stack(children: <Widget>[
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://s3.amazonaws.com/wll-community-production/images/no-avatar.png"),
                    ),
                    Positioned(
                        bottom: 0.0,
                        right: 1.0,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        ))
                  ]),
                  title: const Text("My Status",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text("Tap to add status update"),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Viewed updates",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold))),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: ListView(
                        children: <Widget>[
                          ListTile(
                            leading: const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://pbs.twimg.com/media/EClDvMXU4AAw_lt?format=jpg&name=medium"),
                            ),
                            title: const Text("Ha Manh Do",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: const Text("Today. 20:16 PM"),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoryPageView())),
                          )
                        ],
                      )))
            ]));
  }
}
