import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:provider/provider.dart';
import 'card_provider.dart';
import 'product_provider.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuth = false;
  bool _isLoading = false;
  String? _error;

  bool get isAuth => _isAuth;
  bool get isLoading => _isLoading;
  String? get error => _error;

  User? _user;
  User? get user => _user;
  Type get userType => User;

  void setIsAuth(bool auth) {
    _isAuth = auth;
    notifyListeners();
  }

  void signOut() {
    _isAuth = false;
    _user = null;
    _error = null;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    setLoading(true);
    _error = null;

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password are required');
      }
  
      _user = User(
        email: email,
        password: password,
        name: 'John Doe',
        address: '123 Main St, City, Country',
        image: 'lib/assets/images/image.png',
      );
      _isAuth = true;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<User?> getUser() async {
    if (_isAuth && _user != null) {
      return _user;
    } else {
      _error = 'User not authenticated';
      notifyListeners();
      return null;
    }
  }

  Future<void> updateUser(User updatedUser) async {
    setLoading(true);
    _error = null;

    try {
      // TODO: Implement API call to update user
      await Future.delayed(const Duration(seconds: 1));
      _user = updatedUser;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      setLoading(false);
    }
  }

  Future<void> payment() async {
    if (!_isAuth) {
      throw Exception('User not authenticated');
    }
    return Future.delayed(const Duration(seconds: 2));
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
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
