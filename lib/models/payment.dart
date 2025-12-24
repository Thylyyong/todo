class PayMentProvider {
  String? cardNumber;
  String? cvv;
  String? expiryDate;

  PayMentProvider({required this.cardNumber, required this.cvv, required this.expiryDate});

  factory PayMentProvider.fromJson(Map<String, dynamic> json) {
    return PayMentProvider(
      cardNumber: json['cardNumber'],
      cvv: json['cvv'],
      expiryDate: json['expiryDate'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'cvv': cvv,
      'expiryDate': expiryDate,
    };
  }
}