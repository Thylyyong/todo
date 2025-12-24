class Card {

  final String title;
  final String description;
  final String imageUrl;

  Card({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}