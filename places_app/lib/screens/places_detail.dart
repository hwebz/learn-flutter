import 'package:flutter/material.dart';
import 'package:places_app/models/places.dart';

class PlacesDetailScreen extends StatelessWidget {
  const PlacesDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(place.title),
          centerTitle: false,
        ),
        body: Stack(
          children: [
            Image.file(place.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity)
          ],
        ));
  }
}
