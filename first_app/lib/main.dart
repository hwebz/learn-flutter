import 'package:first_app/dice_roller/gradient_container.dart';
import 'package:first_app/quiz.dart';
import 'package:first_app/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // body: GradientContainer(colors: [Colors.red, Colors.blue])
        body: Quiz(),
      )));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => throw UnimplementedError();
}
