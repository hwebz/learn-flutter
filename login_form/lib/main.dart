import 'package:flutter/material.dart';
import 'package:login_form/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: "Flutter Login UI",
        debugShowCheckedModeBanner: false,
        home: LoginScreen());
  }
}
