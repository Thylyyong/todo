class User {
  final String name;
  final String email;
  final String password;
  final String address;
  final String image;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.image,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      address: json['address'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'image': image,
    };
  }
}