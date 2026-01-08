class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final bool isFavorite;
  final double rate;
  final String reviews;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    required this.rate,
    this.reviews = '',
    this.category = 'General',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      isFavorite: json['isFavorite'],
      rate: json['rate'],
      reviews: json['reviews'] ?? '',
      category: json['category'] ?? 'General',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
      'rate': rate,
      'reviews': reviews,
      'category': category,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
