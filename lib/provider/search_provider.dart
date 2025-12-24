import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String search = '';
  void setSearch(String search) {
    this.search = search;
    notifyListeners();
  }
}