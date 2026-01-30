import 'package:flutter/material.dart';
import 'package:sovietunion/widgets/custom_button.dart';

class StateManagementDemo extends StatefulWidget {
  const StateManagementDemo({super.key});

  @override
  StateManagementDemoState createState() => StateManagementDemoState();
}

class StateManagementDemoState extends State<StateManagementDemo> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _counter >= 5 ? Colors.greenAccent.shade100 : Colors.white;

    return Scaffold(
      appBar: AppBar(title: const Text('State Management Demo')),
      body: Container(
        color: bgColor,
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Button pressed:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('$_counter times', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _incrementCounter, child: const Text('Increment')),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: _decrementCounter, child: const Text('Decrement')),
              ],
            ),
            const SizedBox(height: 18),
            CustomButton(label: 'Reset', onPressed: _resetCounter, color: Colors.orange),
            const SizedBox(height: 18),
            const Text('Tip: background turns green when count >= 5', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
