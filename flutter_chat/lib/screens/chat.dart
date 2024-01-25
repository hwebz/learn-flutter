import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat_messages.dart';
import 'package:flutter_chat/widgets/new_messaged.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    fcm.subscribeToTopic('chat');

    // For testing push notifications only
    // final token = await fcm.getToken();
    // print(
    //     token); // you could send this token (via HTTP or the Firestore SDK) to a backend
  }

  @override
  void initState() {
    super.initState();

    setupPushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.primary))
        ],
        centerTitle: false,
      ),
      body: const Column(
        children: [Expanded(child: ChatMessages()), NewChatMessage()],
      ),
    );
  }
}
