import 'package:flutter/material.dart';
import 'package:sovietunion/screens/dashboard.dart';
import 'package:sovietunion/screens/login_screen.dart';
import 'package:sovietunion/screens/signup_screen.dart';
import 'package:sovietunion/screens/soviet_dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soviet Union',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      initialRoute: '/dashboard',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/soviet_dashboard': (context) => const Dashboard(),
      },
    );
  }
}
