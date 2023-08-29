import 'package:banking_app/data_json/card_json.dart';
import 'package:banking_app/data_json/card_operations_json.dart';
import 'package:banking_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60), child: getAppBar()),
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: white,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: black, size: 22)),
      title: const Text("Card", style: TextStyle(fontSize: 18, color: black)),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: black, size: 25))
      ],
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    var controller = PageController();
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
            width: double.infinity,
            height: 240,
            child: PageView(
              controller: controller,
              children: List.generate(
                  cardLists.length, (index) => getCard(card: cardLists[index])),
            )),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 10,
                      blurRadius: 10)
                ]),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        width: size.width / 2,
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: primary, width: 3.5))),
                        child: Center(
                            child: Text("Operations",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: primary,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        width: size.width / 2,
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: grey.withOpacity(0.1), width: 3.5))),
                        child: Center(
                            child: Text("History",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: primary.withOpacity(0.5),
                                    fontWeight: FontWeight.bold))),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Column(
                        children: List.generate(
                            cardOperations.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              color: grey.withOpacity(0.1),
                                              spreadRadius: 10,
                                              blurRadius: 10)
                                        ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color:
                                                    secondary.withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Center(
                                              child: Icon(
                                                  cardOperations[index]['icon'],
                                                  size: 20,
                                                  color: primary),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Text(cardOperations[index]['title'],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600))
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        )
      ],
    );
  }

  Widget getCard({required dynamic card}) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(card['currency'],
                style: const TextStyle(
                    fontSize: 17, color: black, fontWeight: FontWeight.bold)),
            const SizedBox(width: 5),
            Text(card['amount'],
                style: const TextStyle(
                    color: black, fontWeight: FontWeight.bold, fontSize: 35))
          ],
        ),
        const SizedBox(height: 15),
        Container(
          width: size.width * 0.85,
          height: 170,
          decoration: BoxDecoration(
              color: card['bg_color'], borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Feather.credit_card,
                        size: 30, color: white.withOpacity(0.5)),
                    const SizedBox(height: 15),
                    Text(card['card_number'],
                        style: TextStyle(
                            color: white.withOpacity(0.8),
                            fontSize: 20,
                            wordSpacing: 15))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("VALID DATE",
                            style: TextStyle(
                                color: white.withOpacity(0.3), fontSize: 12)),
                        SizedBox(height: 4),
                        Text(card['valid_date'],
                            style: TextStyle(color: white, fontSize: 13))
                      ],
                    ),
                    Image.asset("assets/images/master_card_logo.png", width: 50)
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
