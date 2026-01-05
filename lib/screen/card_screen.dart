import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/card_provider.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: cartProvider.cartItems.isEmpty
            ? const Center(child: Text('Your cart is empty', style: TextStyle(fontSize: 18)))
            : Column(
                children: [
                  const Text('Items in your cart:'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartProvider.cartItems[index];
                        return ListTile(
                          leading: Image.asset(product.imageUrl, width: 50),
                          title: Text(product.title),
                          subtitle: Text('\$${product.price}'),
                          dense: true,
                          contentPadding: const EdgeInsets.all(8.0),

                          trailing: IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cartProvider.removeFromCart(product);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}',
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'payment');
                          },
                          child: const Text('Pay Now'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
