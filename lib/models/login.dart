import 'package:flutter_riverpod/legacy.dart';

class Auth {
  final bool isLoggedIn;
  final String? email;
  final String? password;

  Auth({
    required this.isLoggedIn,
    this.email,
    this.password,
  });
  Auth .initial()
      : isLoggedIn = false,
        email = null,
        password = null;

final authProvider = StateProvider<Auth>((ref) => Auth.initial());
}