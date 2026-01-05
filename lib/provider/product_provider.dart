import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/mock_data.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/models/category.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = mockProducts;
  final List<Category> _categories = mockCategories;

  List<Product> get products => _products;
  List<Category> get categories => _categories;

  List<Product> getFilteredProducts(String query) {
    if (query.isEmpty) return _products;
    return _products
        .where(
          (product) =>
              product.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  void toggleFavorite(String productId) {
    final productIndex = _products.indexWhere((p) => p.id == productId);
    if (productIndex != -1) {
      _products[productIndex] = Product(
        id: _products[productIndex].id,
        title: _products[productIndex].title,
        price: _products[productIndex].price,
        imageUrl: _products[productIndex].imageUrl,
        rate: _products[productIndex].rate,
        isFavorite: !_products[productIndex].isFavorite,
      );
      notifyListeners();
    }
  }
}
