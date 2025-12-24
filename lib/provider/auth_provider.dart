import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:provider/provider.dart';
import 'card_provider.dart';
import 'product_provider.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuth = false;
  bool get isAuth => _isAuth;
  late User user;
  Type get userType => User;

  void setIsAuth(bool auth) {
    _isAuth = auth;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    user = User(email: email, password: password, name: 'John Doe', address: '123 Main St, City, Country', image: 'lib/assets/images/image.png');
    setIsAuth(true);
    notifyListeners();
  }
  Future<Object?>? getUser() async {
    return user;
  }
  Future<void> payment(){
    if (_isAuth) {
      return Future.delayed(const Duration(seconds: 2));
    }
    return Future.delayed(const Duration(seconds: 2));
  }
}

class AuthProviderContainer extends StatelessWidget {
  const AuthProviderContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: child,
    );
  }
}