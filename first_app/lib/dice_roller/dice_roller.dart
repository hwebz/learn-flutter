import 'dart:math';

import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  int _diceValue = 1;

  void _rollDice() {
    var diceRoll = Random().nextInt(6) + 1;
    setState(() {
      _diceValue = diceRoll;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            'https://seekicon.com/free-icon-download/dice-$_diceValue\_$_diceValue.png',
            width: 200,
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: _rollDice,
            style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue),
            child: const Text('Roll Dice 2222'),
          ),
        ],
      ),
    );
  }
}
