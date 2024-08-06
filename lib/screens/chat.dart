import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();
    setupPushNotifications();
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
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        body: const Column(
          children: [
            Expanded(
              child: ChatMessages(),
            ),
            NewMessages(),
          ],
        ));
  }
}
//javascript code for notification function.
// const functions = require('firebase-functions');
// const admin = require('firebase-admin');

// admin.initializeApp();

// // Cloud Firestore triggers ref: https://firebase.google.com/docs/functions/firestore-events
// exports.myFunction = functions.firestore
//   .document('chat/{messageId}')
//   .onCreate((snapshot, context) => {
//     // Return this function's promise, so this ensures the firebase function
//     // will keep running, until the notification is scheduled.
//     return admin.messaging().send({
//       // Sending a notification message.
//       notification: {
//         title: snapshot.data()['username'],
//         body: snapshot.data()['text'],
//       },
//       data: {
//         // Data payload to be sent to the device.
//         click_action: 'FLUTTER_NOTIFICATION_CLICK',
//       },
//       topic: 'chat',
//     });
//   });
