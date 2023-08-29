import 'package:banking_app/data_json/balance_json.dart';
import 'package:banking_app/pages/card_page.dart';
import 'package:banking_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ScrollController _scrollController = ScrollController();
  int scrollIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: PreferredSize(
        child: getAppBar(),
        preferredSize: const Size.fromHeight(60),
      ),
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: primary,
      leading: IconButton(
          onPressed: () {},
          icon: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000"),
          )),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(AntDesign.search1))
      ],
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.2,
          decoration: const BoxDecoration(color: primary),
          child: Column(
            children: [
              Container(
                  width: size.width,
                  height: 110,
                  child: PageView.builder(
                      itemCount: balanceLists.length,
                      controller: PageController(viewportFraction: 0.55),
                      onPageChanged: (int index) {
                        setState(() {
                          scrollIndex = index;
                        });
                      },
                      itemBuilder: (_, i) {
                        return AnimatedOpacity(
                          opacity: i == scrollIndex ? 1 : 0.5,
                          duration: const Duration(milliseconds: 250),
                          child: AnimatedScale(
                              duration: const Duration(milliseconds: 250),
                              scale: i == scrollIndex ? 1 : 0.7,
                              child: getBalanceItem(index: i)),
                        );
                      })
                  // OLD APPROACH
                  // child: NotificationListener(
                  //   onNotification: (ScrollNotification scrollNotification) {
                  //     var currrentScroll = _scrollController.position.pixels;
                  //     var currentIndex =
                  //         (currrentScroll / (size.width * 0.7)).ceil();
                  //     // Auto snap to next index but still FAILED
                  //     if (scrollNotification is ScrollEndNotification &&
                  //         currentIndex < balanceLists.length) {
                  //       Future.delayed(const Duration(milliseconds: 1), () {})
                  //           .then((s) {
                  //         var nextScroll = currentIndex * (size.width * 0.7) -
                  //             (size.width * 0.25) / balanceLists.length;
                  //         if (nextScroll < 0) nextScroll = 0;
                  //         _scrollController.animateTo(nextScroll,
                  //             duration: Duration(milliseconds: 500),
                  //             curve: Curves.ease);
                  //       });
                  //     }

                  //     setState(() {
                  //       scrollIndex = currentIndex;
                  //     });
                  //     return true;
                  //   },
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     controller: _scrollController,
                  //     shrinkWrap: true,
                  //     children: [getBalances()],
                  //   ),
                  // )
                  ),
              Expanded(
                  child: Container(
                width: size.width,
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    Flexible(
                        child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: secondary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text("Add money",
                              style: TextStyle(
                                  color: white, fontWeight: FontWeight.w600))),
                    )),
                    const SizedBox(width: 15),
                    Flexible(
                        child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: secondary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                          child: Text("Exchange",
                              style: TextStyle(
                                  color: white, fontWeight: FontWeight.w600))),
                    )),
                    const SizedBox(width: 15),
                  ],
                ),
              ))
            ],
          ),
        ),
        Expanded(
            child: Container(
          width: size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 40, left: 20, right: 20),
                      child: getAccountSection(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ))
      ],
    );
  }

  Widget getAccountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Accounts",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: grey.withOpacity(0.1),
                    spreadRadius: 10,
                    blurRadius: 10)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: secondary.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Icon(AntDesign.wallet,
                                color: primary, size: 20),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text("12312312213-123123-12312",
                            style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    const Icon(Icons.keyboard_arrow_down, color: primary)
                  ],
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Divider(
                    thickness: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: secondary.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Icon(MaterialIcons.euro_symbol,
                                color: primary, size: 20),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text("18 199.24 EUR",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Divider(
                    thickness: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: secondary.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Icon(MaterialCommunityIcons.currency_gbp,
                                color: primary, size: 20),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text("36.67 GBP",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Cards",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            Container(
              width: 90,
              height: 22,
              decoration: BoxDecoration(
                  color: secondary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Ionicons.ios_add, size: 16, color: primary),
                  Text("ADD CARD",
                      style: TextStyle(
                          fontSize: 11,
                          color: primary,
                          fontWeight: FontWeight.w600))
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        getCard(
            icon: AntDesign.creditcard,
            cardNumber: "EUR *2330",
            cardBalance: "8 199.24 EUR"),
        const SizedBox(height: 15),
        getCard(
            icon: AntDesign.creditcard,
            cardNumber: "GBP *9110",
            cardBalance: "2 344.00 GBP"),
        const SizedBox(height: 15),
        getCard(
            icon: AntDesign.creditcard,
            cardNumber: "USD *1043",
            cardBalance: "12 543.00 USD"),
        // Because we used `extendBody: true` so that's why bottom bar is absoluted position
        const SizedBox(height: 100),
      ],
    );
  }

  Widget getCard(
      {required IconData icon,
      required String cardNumber,
      required String cardBalance}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const CardPage()));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: grey.withOpacity(0.1),
                  spreadRadius: 10,
                  blurRadius: 10)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: secondary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Icon(icon, color: primary, size: 20),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(cardNumber, style: const TextStyle(fontSize: 15)),
                ],
              ),
              Text(cardBalance,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600))
            ],
          ),
        ),
      ),
    );
  }

  Widget getBalances() {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        Row(
          children: List.generate(
              balanceLists.length, (index) => getBalanceItem(index: index)),
        ),
        SizedBox(width: size.width * (0.3 / balanceLists.length))
      ],
    );
  }

  Padding getBalanceItem({required int index}) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
          width: size.width * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(balanceLists[index]['currency'],
                      style: TextStyle(
                          color: index == scrollIndex
                              ? white
                              : white.withOpacity(0.5),
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5),
                  Text(balanceLists[index]['amount'],
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: index == scrollIndex
                              ? white
                              : white.withOpacity(0.5)))
                ],
              ),
              const SizedBox(height: 8),
              Text(balanceLists[index]['description'],
                  style: TextStyle(fontSize: 15, color: white.withOpacity(0.5)))
            ],
          )),
    );
  }
}
