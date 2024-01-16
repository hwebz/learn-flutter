import 'package:flutter/material.dart';

class PlacesDetailScreen extends StatelessWidget {
  const PlacesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Places"),
          centerTitle: false,
        ),
        body: const Text("Place Details"));
  }
}
