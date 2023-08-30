import 'package:flutter/material.dart';

import '../models/pet_model.dart';
import 'adopt_pet_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 40, top: 40),
                child: CircleAvatar(
                    child: ClipOval(
                        child: Image(
                  height: 40,
                  width: 40,
                  image: AssetImage(owner.imageUrl),
                  fit: BoxFit.cover,
                )))),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 22),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Icon(Icons.add_location,
                          color: Colors.black, size: 40),
                    ),
                    labelText: 'Location',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    contentPadding: EdgeInsets.only(bottom: 20)),
              ),
            ),
            const SizedBox(height: 100),
            Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 40),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        icon: const Icon(Icons.search, size: 35),
                        onPressed: () {},
                      ),
                    ),
                    _buildPetCategory(false, "Cats"),
                    _buildPetCategory(true, "Dogs"),
                    _buildPetCategory(false, "Birds"),
                    _buildPetCategory(false, "Other")
                  ],
                )),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Divider(),
            ),
            Column(
              children: List.generate(
                  pets.length,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AdoptPetPage(pet: pets[index])));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40, bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                  tag: pets[0].id,
                                  child: Container(
                                    width: double.infinity,
                                    height: 250,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                pets[index].imageUrl),
                                            fit: BoxFit.cover)),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 12, 40, 0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(pets[index].name,
                                          style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.favorite_border),
                                        iconSize: 30,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 0, 40, 12),
                                child: Text(pets[index].description,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: 'Montserrat')),
                              )
                            ],
                          ),
                        ),
                      )),
            )
          ],
        ));
  }

  Widget _buildPetCategory(bool isSelected, String category) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 80,
      decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : const Color(0xfff8f2f7),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(width: 8, color: const Color(0xfffed8d3))
              : null),
      child: Center(
          child: Text(category,
              style: const TextStyle(
                  fontFamily: 'Monsterrat',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black))),
    );
  }
}
