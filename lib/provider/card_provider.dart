import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/data/mock_data.dart';

class CartProvider with ChangeNotifier {
  final List<String> _cartItemIds = [];

  List<String> get cartItemIds => _cartItemIds;

  List<Product> get cartItems => _cartItemIds
      .map((id) => mockProducts.firstWhere((p) => p.id == id))
      .toList();

  void addToCart(Product product) {
    _cartItemIds.add(product.id);
    notifyListeners();
  }
  

  void removeFromCart(Product product) {
    _cartItemIds.remove(product.id);
    notifyListeners();
  }

  double get totalPrice => _cartItemIds.fold(
    0,
    (sum, id) => sum + (mockProducts.firstWhere((p) => p.id == id).price),
  );

  void clearCart() {
    _cartItemIds.clear();
    notifyListeners();
  }
}
