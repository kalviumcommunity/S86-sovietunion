import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/login_screen.dart';
import 'firebase_options.dart';
import 'services/notification_service.dart';
import 'providers/theme_state.dart';
import 'theme/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Register background message handler before running the app
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Initialize notification service (permissions, listeners, token)
  await NotificationService().initialize();
  final prefs = await SharedPreferences.getInstance();
  final themeState = ThemeState(prefs);
  themeState.loadFromPrefs();

  runApp(ChangeNotifierProvider<ThemeState>.value(
    value: themeState,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soviet Union',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeState.mode,
      home: const LoginScreen(),
    );
  }
}
