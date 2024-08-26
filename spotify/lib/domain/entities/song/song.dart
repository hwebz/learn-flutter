import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final String duration;
  final Timestamp releaseDate;
  final String image;
  final String url;

  SongEntity(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.releaseDate,
      required this.image,
      required this.url});
}
