import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  String cardNumber = '';
  String cvv = '';
  String expiryDate = '';

  void updatePayment(String cardNumber, String cvv, String expiryDate) {
    this.cardNumber = cardNumber;
    this.cvv = cvv;
    this.expiryDate = expiryDate;
    notifyListeners();
  }
}
