import 'package:flutter/material.dart';
import 'package:netflix/json/coming_soon_json.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black, appBar: getAppBar(), body: getBody());
  }

  AppBar getAppBar() {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text("Coming Soon",
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
        ]);
  }

  void handleSelect() {
    print('Select film');
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.notifications_none_outlined,
                      color: Colors.white.withOpacity(0.9)),
                  const SizedBox(width: 15),
                  Text("Notifications",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.9))),
                ],
              ),
              Icon(Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.9), size: 22)
            ],
          ),
        ),
        const SizedBox(height: 20),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                comingSoonJson.length,
                (index) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 220,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  comingSoonJson[index]['img']),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              comingSoonJson[index]['duration']
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Stack(
                                          children: [
                                            Container(
                                              height: 2.5,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey
                                                      .withOpacity(0.7)),
                                            ),
                                            Container(
                                              width: size.width * 0.34,
                                              height: 2.5,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.red
                                                      .withOpacity(0.7)),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                            comingSoonJson[index]['title_img'],
                                            width: 120),
                                        const Row(
                                          children: [
                                            Column(
                                              children: [
                                                Icon(
                                                    Icons
                                                        .notifications_none_outlined,
                                                    color: Colors.white),
                                                SizedBox(height: 5),
                                                Text("Remind me",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11))
                                              ],
                                            ),
                                            SizedBox(width: 30),
                                            Column(
                                              children: [
                                                Icon(Icons.info_outline,
                                                    color: Colors.white),
                                                SizedBox(height: 5),
                                                Text("Info",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(comingSoonJson[index]['date'],
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5))),
                                    const SizedBox(height: 15),
                                    Text(comingSoonJson[index]['title'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    const SizedBox(height: 5),
                                    Text(comingSoonJson[index]['description'],
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            height: 1.4)),
                                    const SizedBox(height: 10),
                                    Text(comingSoonJson[index]['type'],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            height: 1.4)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned.fill(
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(onTap: handleSelect)))
                      ],
                    )))
      ],
    ));
  }
}
