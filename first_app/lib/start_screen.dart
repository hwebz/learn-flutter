import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  // const StartScreen(void Function() startQuiz, {super.key});
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
              opacity: 0.7,
              child: Image.asset('assets/images/quiz.png', width: 300)),
          // Image.asset('assets/images/quiz.png',
          //     width: 300, color: Color.fromARGB(150, 255, 255, 255)),
          SizedBox(height: 80),
          Text("Learn Flutter the fun way!",
              style: GoogleFonts.lato(color: Colors.white, fontSize: 24)),
          SizedBox(height: 30),
          // OutlinedButton(
          //     onPressed: () {},
          //     style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
          //     child: Text("Start Quiz"))
          OutlinedButton.icon(
              onPressed: startQuiz,
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
              icon: Icon(Icons.arrow_right_alt),
              label: Text("Start Quiz"))
        ],
      ),
    );
  }
}
