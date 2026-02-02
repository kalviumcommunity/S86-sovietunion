import 'package:flutter/material.dart';

class AssetDemoScreen extends StatelessWidget {
  const AssetDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assets Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset will display an image from assets/images/
            // Place your logo at assets/images/logo.png
            Image.asset(
              'assets/images/logo.png',
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text('Powered by Flutter', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.flutter_dash, color: Colors.blue, size: 36),
                SizedBox(width: 10),
                Icon(Icons.android, color: Colors.green, size: 36),
                SizedBox(width: 10),
                Icon(Icons.apple, color: Colors.grey, size: 36),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
