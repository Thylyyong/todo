class Search {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  Search({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });
  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }

  static List<Search> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Search.fromJson(json)).toList();
  }
}
