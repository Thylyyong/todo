import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/provider/search_provider.dart';
import 'package:flutter_application_1/screen/favorite.dart';
import 'package:flutter_application_1/screen/login_screen.dart';
import 'package:flutter_application_1/screen/product_screen.dart';
import 'package:flutter_application_1/screen/search_screen.dart';
import 'package:flutter_application_1/screen/splash.dart';
import 'package:flutter_application_1/screen/card_screen.dart';
import 'screen/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/card_provider.dart';
import 'package:flutter_application_1/provider/favorite_provider.dart';
import 'package:flutter_application_1/screen/profile.dart';
import 'package:flutter_application_1/screen/payment.dart';
import 'package:flutter_application_1/screen/register_screen.dart';
import '../service/api_service.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "splash",
        routes: {
          "/": (context) => const Homepage(),
          "product": (context) => const ProductScreen(),
          "search": (context) => const SearchScreen(),
          "favorite": (context) => const Favorite(),
          "profile": (context) => const Profile(),
          "splash": (context) => const Splash(),
          "login": (context) => const LoginScreen(),
          "cart": (context) => const CardScreen(),
          "person": (context) => const Profile(),
          "payment": (context) => const Payment(),
          "register": (context) =>  RegisterScreen(),
        },
      ),
    );
  }
}


