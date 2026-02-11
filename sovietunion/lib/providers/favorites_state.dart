import 'package:flutter/foundation.dart';

/// Model for a favorite item
class FavoriteItem {
  final String id;
  final String title;
  final String description;
  final DateTime addedAt;

  FavoriteItem({
    required this.id,
    required this.title,
    required this.description,
    required this.addedAt,
  });
}

/// Favorites state using ChangeNotifier (Provider pattern)
/// Demonstrates multi-screen shared state management
/// This state can be accessed and modified from any screen in the app
class FavoritesState with ChangeNotifier {
  final List<FavoriteItem> _items = [];

  List<FavoriteItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  bool isFavorite(String id) {
    return _items.any((item) => item.id == id);
  }

  void addItem(String id, String title, String description) {
    if (!isFavorite(id)) {
      _items.add(FavoriteItem(
        id: id,
        title: title,
        description: description,
        addedAt: DateTime.now(),
      ));
      notifyListeners(); // UI updates automatically
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void toggleFavorite(String id, String title, String description) {
    if (isFavorite(id)) {
      removeItem(id);
    } else {
      addItem(id, title, description);
    }
  }

  void clearAll() {
    _items.clear();
    notifyListeners();
  }
}
