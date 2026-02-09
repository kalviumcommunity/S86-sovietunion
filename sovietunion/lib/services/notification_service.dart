import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling a background message: ${message.messageId}');
}

class NotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground message: ${message.notification?.title} - ${message.notification?.body}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('Opened app from notification: ${message.notification?.title}');
    });

    final RemoteMessage? initialMsg = await messaging.getInitialMessage();
    if (initialMsg != null) {
      debugPrint('Opened app from terminated state: ${initialMsg.notification?.title}');
    }

    final String? token = await messaging.getToken();
    debugPrint('FCM Token: $token');
  }
}
