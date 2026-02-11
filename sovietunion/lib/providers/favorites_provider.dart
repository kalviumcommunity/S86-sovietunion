import 'package:flutter/foundation.dart';
import '../models/item.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<Item> _favorites = <Item>{};

  Set<Item> get favorites => Set.unmodifiable(_favorites);

  bool isFavorite(Item item) {
    return _favorites.contains(item);
  }

  void toggleFavorite(Item item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }

  void addToFavorites(Item item) {
    if (!_favorites.contains(item)) {
      _favorites.add(item);
      notifyListeners();
    }
  }

  void removeFromFavorites(Item item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
      notifyListeners();
    }
  }

  int get favoritesCount => _favorites.length;
}
