import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/provider/search_provider.dart';
import 'package:flutter_application_1/widgets/product_card.dart';
import 'package:flutter_application_1/screen/product_detail.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final searchProvider = Provider.of<SearchProvider>(context);
    final filteredProducts = productProvider.getFilteredProducts(
      searchProvider.search,
    );
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 169, 214),
      appBar: AppBar(
        title: Text(
          'Search Results for "${searchProvider.search}"',
          style: TextStyle(fontSize: screenWidth * 0.045),
        ),
        backgroundColor: Colors.blue,
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
          return filteredProducts.isEmpty
              ? Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: screenWidth * 0.025,
                      mainAxisSpacing: screenWidth * 0.025,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.0625,
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
                          product: filteredProducts[index],
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: filteredProducts[index],
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
