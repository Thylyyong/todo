import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/models/search.dart';

List<Category> mockCategories = [
  Category(name: 'Electronics', imageUrl: 'lib/assets/images/image.png'),
  Category(name: 'Clothing', imageUrl: 'lib/assets/images/image.png'),
  Category(name: 'Books', imageUrl: 'lib/assets/images/image.png'),
  Category(name: 'Home & Garden', imageUrl: 'lib/assets/images/image.png'),
];

List<String> mockBanners = [
  'lib/assets/images/image.png',
  'lib/assets/images/image.png',
  'lib/assets/images/image.png',
];

List<Product> mockProducts = [
  Product(
    id: '1',
    title: 'Laptop',
    price: 999.99,
    imageUrl: 'lib/assets/images/image.png',
    isFavorite: true,
    rate: 4.5,
    reviews: 'hot sale',
  
  ),
  Product(
    id: '2',
    title: 'T-Shirt',
    price: 19.99,
    imageUrl: 'lib/assets/images/image.png',
    isFavorite: false,
    rate: 4.5,
    reviews: 'new arrival',
  ),
  Product(
    id: '3',
    title: 'Book',
    price: 14.99,
    imageUrl: 'lib/assets/images/image.png',
    rate: 4.5,
    reviews: 'bestseller',
  ),
  Product(
    id: '5',
    title: 'Shoes',
    price: 49.99,
    imageUrl: 'lib/assets/images/image.png',
    rate: 4.5,
    reviews: 'limited edition',
  ),
  Product(
    id: '4',
    title: 'Chair',
    price: 149.99,
    imageUrl: 'lib/assets/images/image.png',
    rate: 4.5,
    reviews: 'comfortable',
  ),
  Product(
    id: '6',
    title: 'Phone',
    price: 699.99,
    imageUrl: 'lib/assets/images/image.png',
    rate: 4.5,
    reviews: 'latest model',
  ),
  Product(
    id: '7',
    title: 'Phone',
    price: 699.99,
    imageUrl: 'lib/assets/images/image.png',
    rate: 4.5,
    reviews: 'latest model',
  ),
];

User mockUser = User(
  name: 'John Doe',
  email: 'jDk0Y@example.com',
  password: 'password',
  address: '123 Main St, City, Country',
  image: 'lib/assets/images/image.png',
);

List<Search> mockSearch = [
  Search(
    id: '1',
    title: 'Laptop',
    price: 999.99,
    imageUrl: 'lib/assets/images/image.png',
  ),
  Search(
    id: '2',
    title: 'T-Shirt',
    price: 19.99,
    imageUrl: 'lib/assets/images/image.png',
  ),
  Search(
    id: '3',
    title: 'Book',
    price: 14.99,
    imageUrl: 'lib/assets/images/image.png',
  ),
  Search(
    id: '4',
    title: 'Chair',
    price: 149.99,
    imageUrl: 'lib/assets/images/image.png',
  ),
  Search(
    id: '5',
    title: 'Shoes',
    price: 49.99,
    imageUrl: 'lib/assets/images/image.png',
  ),
  Search(
    id: '6',
    title: 'Phone',
    price: 699.99,
    imageUrl: 'lib/assets/images/image.png',
  ),
];
