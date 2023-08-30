import 'package:flutter/material.dart';

import '../models/pet_model.dart';

class AdoptPetPage extends StatefulWidget {
  final Pet pet;

  const AdoptPetPage({super.key, required this.pet});

  @override
  State<AdoptPetPage> createState() => _AdoptPetPageState();
}

class _AdoptPetPageState extends State<AdoptPetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              children: [
                Hero(
                    tag: widget.pet.id,
                    child: Container(
                      width: double.infinity,
                      height: 350,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(widget.pet.imageUrl),
                              fit: BoxFit.cover)),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(children: [
                Text(widget.pet.name,
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: () {
                      print('Favorite ${widget.pet.name}');
                    },
                    icon: const Icon(Icons.favorite_border),
                    iconSize: 30,
                    color: Theme.of(context).primaryColor)
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(widget.pet.description,
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: Colors.grey)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 30),
                  _buildInfoCard('Age', widget.pet.age.toString()),
                  _buildInfoCard('Sex', widget.pet.sex.toString()),
                  _buildInfoCard('Color', widget.pet.color.toString())
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 30),
              width: double.infinity,
              height: 90,
              decoration: const BoxDecoration(
                  color: Color(0xfffff2d0),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: CircleAvatar(
                    child: ClipOval(
                  child: Image(
                    image: AssetImage(widget.pet.imageUrl),
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                )),
                title: Text(
                  owner.name,
                  style: const TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Owner',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Montserrat')),
                trailing: Text('1.68 km',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Montserrat')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Text(
                owner.bio,
                style: const TextStyle(
                    fontFamily: 'Montserrat', fontSize: 15, height: 1.5),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 50,
                      width: 60,
                      child: IconButton(
                          onPressed: () {
                            print('Share');
                          },
                          icon: const Icon(Icons.share))),
                  TextButton(
                      onPressed: () => print("Login button pressed"),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.all(20.0),
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0),
                      child: const Row(children: [
                        Icon(Icons.pets, color: Colors.white),
                        SizedBox(width: 10),
                        Text('ADOPTION',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontSize: 20))
                      ])),
                ],
              ),
            )
          ]),
        ));
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 100,
      decoration: BoxDecoration(
          color: const Color(0xfff8f2f7),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor)),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black))
        ],
      ),
    );
  }
}
