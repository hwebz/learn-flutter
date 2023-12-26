import 'package:first_app/dice_roller/gradient_container.dart';
import 'package:first_app/dice_roller/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'My App',
    home: Scaffold(
        // body: GradientContainer(colors: [Colors.red, Colors.blue])
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 78, 13, 151),
              Color.fromARGB(255, 107, 15, 168)
            ])),
            child: const StartScreen())),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => throw UnimplementedError();
}
