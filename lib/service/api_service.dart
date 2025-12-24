import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/card.dart';
import '../models/order.dart';

class ApiService {
    final url = 'https://jsonplaceholder.typicode.com/todos/1';
    final dio = Dio();

    Future<List<Product>> getProducts() async {
        final response = await dio.get('${url}products');
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
    }

    Future<List<Product>> getProductsByCategory(int id) async {
        final response = await dio.get('${url}products/category/$id');
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
    }

    Future<List<Product>> getProductsBySearch(String search) async {
        final response = await dio.get('${url}products/search/$search');
        final List<dynamic> data = response.data;
        return data.map((json) => Product.fromJson(json)).toList();
    }

    Future<Product> getProduct(int id) async {
        final response = await dio.get('${url}products/$id');
        final data = response.data;
        return Product.fromJson(data);
    }

    Future<List<Card>> getCards() async {
        final response = await dio.get('${url}cards');
        final List<dynamic> data = response.data;
        return data.map((json) => Card.fromJson(json)).toList();
    }

    Future<List<Order>> getOrders() async {
        final response = await dio.get('${url}orders');
        final List<dynamic> data = response.data;
        return data.map((json) => Order.fromJson(json)).toList();
    }

    Future<List<User>> getUsers() async {
        final response = await dio.get('${url}users');
        final List<dynamic> data = response.data;
        return data.map((json) => User.fromJson(json)).toList();
    }
}