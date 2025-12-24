import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';

class FavoriteProvider with ChangeNotifier {
  final Set<String> _favoriteIds = {};

  Set<String> get favoriteIds => _favoriteIds;

  void toggleFavorite(Product product) {
    if (_favoriteIds.contains(product.id)) {
      _favoriteIds.remove(product.id);
    } else {
      _favoriteIds.add(product.id);
    }
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favoriteIds.contains(product.id);
  }
}