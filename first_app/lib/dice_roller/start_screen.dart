import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Opacity(
          //     opacity: 0.2,
          //     child: Image.asset('assets/images/quiz.png', width: 300)),
          Image.asset('assets/images/quiz.png',
              width: 300, color: Color.fromARGB(150, 255, 255, 255)),
          SizedBox(height: 80),
          const Text("Learn Flutter the fun way!",
              style: TextStyle(color: Colors.white, fontSize: 24)),
          SizedBox(height: 30),
          // OutlinedButton(
          //     onPressed: () {},
          //     style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
          //     child: Text("Start Quiz"))
          OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
              icon: Icon(Icons.arrow_right_alt),
              label: Text("Start Quiz"))
        ],
      ),
    );
  }
}
