import 'package:flutter/material.dart';

class NewChatMessage extends StatefulWidget {
  const NewChatMessage({super.key});

  @override
  State<NewChatMessage> createState() => _NewChatMessageState();
}

class _NewChatMessageState extends State<NewChatMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMessage() {
    final enteredMessage = _messageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration:
                    const InputDecoration(labelText: 'Send a message...'),
              ),
            ),
            IconButton(
              color: Theme.of(context).colorScheme.primary,
              icon: const Icon(Icons.send),
              onPressed: _submitMessage,
            )
          ],
        ));
  }
}
