import 'package:flutter/material.dart';

class ChatBar extends StatelessWidget {
  const ChatBar({super.key, required this.fill});

  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FractionallySizedBox(
        heightFactor: fill,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            color: isDarkMode
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.65),
          ),
        ),
      ),
    ));
  }
}
