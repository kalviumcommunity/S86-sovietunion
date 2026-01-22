import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soviet Union',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _title = 'Welcome to the Soviet Union!';
  bool _isDefaultState = true;

  void _toggleState() {
    setState(() {
      if (_isDefaultState) {
        _title = 'Glory to the Motherland!';
      } else {
        _title = 'Welcome to the Soviet Union!';
      }
      _isDefaultState = !_isDefaultState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Soviet Union')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Icon(
              _isDefaultState ? Icons.star : Icons.favorite,
              color: Colors.red,
              size: 100.0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleState,
              child: const Text('Press for Glory'),
            ),
          ],
        ),
      ),
    );
  }
}
