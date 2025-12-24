import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/favorite_provider.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/widget/product_card.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products', style: TextStyle(fontSize: screenWidth * 0.05)),
        backgroundColor: Colors.blue,
      ),
      body: Consumer2<FavoriteProvider, ProductProvider>(
        builder: (context, favoriteProvider, productProvider, child) {
          final favoriteProducts = favoriteProvider.favoriteIds.map((id) => productProvider.products.firstWhere((p) => p.id == id)).toList();
          if (favoriteProducts.isEmpty) {
            return Center(
              child: Text(
                'No favorites yet!',
                style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.grey),
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade50, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount;
                if (constraints.maxWidth > 1200) {
                  crossAxisCount = 6;
                } else if (constraints.maxWidth > 800) {
                  crossAxisCount = 4;
                } else {
                  crossAxisCount = 2;
                }
                return GridView.builder(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: screenWidth * 0.04,
                    mainAxisSpacing: screenWidth * 0.04,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return ProductCard(product: product);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}