import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/category.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.2; // 20% of screen width
    return Card(
      
      child: Column(
        children: [
          Image.asset(category.imageUrl, height: imageSize, width: imageSize),
          TextButton( onPressed: () {
           Navigator.pushNamed(context, 'product', arguments: category);

           }, child: Text(category.name, style: TextStyle(fontSize: screenWidth * 0.04)),),
        ],
      ),

    );

  }
}