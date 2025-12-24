import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/card_provider.dart';
import '../screen/product_detail.dart';
import 'package:flutter_application_1/provider/favorite_provider.dart'; 

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
            ),
          ),
        );
      },
      child: Card(
       margin: EdgeInsets.all(screenWidth * 0.02),
       elevation: 8.0,
       shadowColor: Colors.black26,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(screenWidth * 0.03),
       ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenWidth * 0.03),
                topRight: Radius.circular(screenWidth * 0.03),
              ),
              child: Image.asset(
                product.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    '\$${product.price}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: screenWidth * 0.05,
                ),
                Text(
                  '${product.rate}',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ],
            ),
             Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Added to cart'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                  ),
                  Consumer<FavoriteProvider>(
                    builder: (context, favoriteProvider, child) {
                      final isFav = favoriteProvider.isFavorite(product);
                      return IconButton(
                        onPressed: () {
                          favoriteProvider.toggleFavorite(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  isFav ? 'Removed from favorites' : 'Added to favorites'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
