import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/widgets/product_card.dart';
import 'package:flutter_application_1/screen/product_detail.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 169, 214),
      appBar: AppBar(
        title: Text('Products', style: TextStyle(fontSize: screenWidth * 0.05)),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 6;
          } else if (constraints.maxWidth > 800) {
            crossAxisCount = 4;
          } else {
            crossAxisCount = 2;
          }

          if (productProvider.products.isEmpty) {
            return Center(
              child: Text(
                'No products available',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: GridView.builder(
              itemCount: productProvider.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.65,
                crossAxisSpacing: screenWidth * 0.025,
                mainAxisSpacing: screenWidth * 0.025,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth * 0.0375),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 203, 226, 244),
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ProductCard(
                    product: productProvider.products[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: productProvider.products[index],
                        ),
                      ),
                    ), isFavorite: true,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
