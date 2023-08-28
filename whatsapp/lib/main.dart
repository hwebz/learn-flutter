// ignore_for_file: unnecessary_new

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp_home.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "WhatsApp",
        theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
                primary: const Color(0xff075E54),
                secondary: const Color(0xff25D366))),
        debugShowCheckedModeBanner: false,
        home: WhatsAppHome(cameras: cameras));
  }
}
