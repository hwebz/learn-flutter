import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places_app/providers/user_places.dart';
import 'package:places_app/screens/add_place.dart';
import 'package:places_app/widgets/places_list.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Places"),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => const AddPlaceScreen()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FutureBuilder(
              future: _placesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return PlacesList(places: userPlaces);
              }),
        ));
  }
}
