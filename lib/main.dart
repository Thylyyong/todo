import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/provider/product_provider.dart';
import 'package:flutter_application_1/provider/search_provider.dart';
import 'package:flutter_application_1/screen/favorite.dart';
import 'package:flutter_application_1/screen/login_screen.dart';
import 'package:flutter_application_1/screen/product_screen.dart';
import 'package:flutter_application_1/screen/search_screen.dart';
import 'package:flutter_application_1/screen/product_detail.dart';
import 'package:flutter_application_1/screen/splash.dart';
import 'package:flutter_application_1/screen/card_screen.dart';
import 'package:flutter_application_1/screen/edit_profile_screen.dart';
import 'package:flutter_application_1/screen/orders_screen.dart';
import 'package:flutter_application_1/screen/settings_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/provider/card_provider.dart';
import 'package:flutter_application_1/provider/favorite_provider.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/screen/profile.dart';
import 'package:flutter_application_1/screen/profilemain.dart';
import 'package:flutter_application_1/screen/payment.dart';
import 'package:flutter_application_1/screen/register_screen.dart';
import 'package:flutter_application_1/screen/homepage.dart';

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
        theme: _buildTheme(Brightness.light),
        debugShowCheckedModeBanner: false,
        initialRoute: "splash",
        routes: {
          "/": (context) => const Homepage(),
          "homepage": (context) => const Homepage(),
          "product": (context) => const ProductScreen(),
          "search": (context) => const SearchScreen(),
          "favorite": (context) => const Favorite(),
          "profile": (context) => const ProfileScreen(),
          "splash": (context) => const Splash(),
          "login": (context) => const LoginScreen(),
          "cart": (context) => const CardScreen(),
          "payment": (context) => const Payment(),
          "register": (context) => RegisterScreen(),
          "profilemain": (context) => const Profilemain(),
          "edit_profile": (context) => const EditProfileScreen(),
          "orders": (context) => const OrdersScreen(),
          "settings": (context) => const SettingsScreen(),
          "product_detail": (context) {
            final product = ModalRoute.of(context)!.settings.arguments as Product;
            return ProductDetailScreen(product: product);
          },
        },
        onGenerateRoute: (settings) {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) {
              switch (settings.name) {
                case "/":
                  return const Homepage();
                case "homepage":
                  return const Homepage();
                case "product":
                  return const ProductScreen();
                case "search":
                  return const SearchScreen();
                case "favorite":
                  return const Favorite();
                case "profile":
                  return const ProfileScreen();
                case "splash":
                  return const Splash();
                case "login":
                  return const LoginScreen();
                case "cart":
                  return const CardScreen();
                case "payment":
                  return const Payment();
                case "register":
                  return RegisterScreen();
                case "profilemain":
                  return const Profilemain();
                case "edit_profile":
                  return const EditProfileScreen();
                case "orders":
                  return const OrdersScreen();
                case "settings":
                  return const SettingsScreen();
                case "product_detail":
                  final product = settings.arguments as Product;
                  return ProductDetailScreen(product: product);
                default:
                  return const Homepage();
              }
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Slide transition
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCubic;

              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

              var slideAnimation = animation.drive(tween);
              
              // Fade transition
              var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              );

              return Stack(
                children: [
                  child,
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: child,
                    ),
                  ),
                ],
              );
            },
            transitionDuration: const Duration(milliseconds: 400),
          );
        },
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    var baseTheme = ThemeData(brightness: brightness, useMaterial3: true);
    var seedColor = const Color(0xFF6750A4);

    return baseTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
        surface: const Color(0xFFFFFBFE),
        onSurface: const Color(0xFF1C1B1F),
        surfaceVariant: const Color(0xFFE7E0EC),
        onSurfaceVariant: const Color(0xFF49454F),
        primary: const Color(0xFF6750A4),
        onPrimary: Colors.white,
        secondary: const Color(0xFF625B71),
        onSecondary: Colors.white,
        tertiary: const Color(0xFF7D5260),
        onTertiary: Colors.white,
        error: const Color(0xFFB3261E),
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
      cardTheme: CardThemeData(
        elevation: 4,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: const Color(0xFF6750A4),
          foregroundColor: Colors.white,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 6,
        backgroundColor: Color(0xFF6750A4),
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6750A4), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFB3261E)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 8,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFF6750A4).withOpacity(0.1),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(
              color: Color(0xFF6750A4),
              fontWeight: FontWeight.w600,
            );
          }
          return const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: Color(0xFF6750A4));
          }
          return const IconThemeData(color: Colors.grey);
        }),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
