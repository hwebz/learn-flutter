import 'package:first_app/dice_roller/gradient_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'My App',
    home: Scaffold(body: GradientContainer(colors: [Colors.red, Colors.blue])),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => throw UnimplementedError();
}
