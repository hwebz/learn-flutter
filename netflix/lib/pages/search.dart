import 'package:flutter/material.dart';
import 'package:netflix/json/search_json.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black, appBar: getAppBar(), body: getBody());
  }

  AppBar getAppBar() {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  prefixIcon:
                      Icon(Icons.search, color: Colors.white.withOpacity(0.5))),
            ),
          ),
        ));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          const Text("Top Searches",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Column(
            children: List.generate(
                searchJson.length,
                (index) => Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            width: (size.width - 36) * 0.8,
                            height: 80,
                            child: Row(children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                searchJson[index]['img']),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2)),
                                  )
                                ],
                              ),
                              const SizedBox(width: 10),
                              Container(
                                  width: (size.width - 36) * 0.4,
                                  child: Text(searchJson[index]['title'],
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)))
                            ]),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                                width: (size.width - 36) * 0.2,
                                height: 80,
                                child: Center(
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2, color: Colors.white)),
                                    child: const Center(
                                        child: Icon(Icons.play_arrow,
                                            color: Colors.white)),
                                  ),
                                )),
                          )
                        ],
                      ),
                    )),
          )
        ],
      ),
    ));
  }
}
