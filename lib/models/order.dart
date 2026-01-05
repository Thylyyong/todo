class Order {
  final String title;
  final String description;
  final String imageUrl;
  bool isSelected = false;

  Order({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.isSelected = false,
  });
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'imageUrl': imageUrl};
  }
}
