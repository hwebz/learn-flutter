import 'package:flutter/material.dart';
import 'package:pet_adoption/pages/home_page.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Pet Adoption UI',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        primaryColor: const Color(0xFFFD6456),
      )));
}
