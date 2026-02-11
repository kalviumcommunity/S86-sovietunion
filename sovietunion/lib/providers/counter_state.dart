import 'package:flutter/foundation.dart';

/// A simple counter state using ChangeNotifier (Provider pattern)
/// This demonstrates basic state management with automatic UI updates
class CounterState with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Triggers UI rebuild for all listeners
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}
