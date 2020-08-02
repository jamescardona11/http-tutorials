import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _messageStreamController = StreamController<String>.broadcast();
  Stream<String> get message => _messageStreamController.stream;

  initNotification() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('========== FCM TOKEN ==========');
      print('========== $token');
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        String argument = 'no-data';
        if (Platform.isAndroid) {
          argument = message['data']['food'] ?? 'no-data';
        }

        _messageStreamController.sink.add(argument);
      },
      //onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

        String argument = 'no-data';
        if (Platform.isAndroid) {
          argument = message['data']['food'] ?? 'no-data';
        }

        _messageStreamController.sink.add(argument);
      },
    );
  }

  dispose() {
    _messageStreamController.close();
  }
}
