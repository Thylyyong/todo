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
    
    // Modern colorful gradient seed colors
    const primaryGradient = LinearGradient(
      colors: [Color(0xFF667EEA), Color(0xFF764BA2), Color(0xFFf093fb)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    
    const seedColor = Color(0xFF764BA2);

    return baseTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
        surface: const Color(0xFFFFFBFE),
        onSurface: const Color(0xFF1C1B1F),
        surfaceVariant: const Color(0xFFE7E0EC),
        onSurfaceVariant: const Color(0xFF49454F),
        primary: const Color(0xFF764BA2),
        onPrimary: Colors.white,
        secondary: const Color(0xFF667EEA),
        onSecondary: Colors.white,
        tertiary: const Color(0xFFf093fb),
        onTertiary: Colors.white,
        error: const Color(0xFFB3261E),
        onError: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
      cardTheme: CardThemeData(
        elevation: 8,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Color(0xFF764BA2),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          letterSpacing: -0.5,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 6,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: const Color(0xFF764BA2),
          foregroundColor: Colors.white,
          shadowColor: const Color(0xFF764BA2).withOpacity(0.4),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 8,
        backgroundColor: Color(0xFF764BA2),
        foregroundColor: Colors.white,
        splashColor: Color(0xFF667EEA),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF764BA2), width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFB3261E)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 12,
        backgroundColor: Colors.white.withOpacity(0.85),
        indicatorColor: const Color(0xFF764BA2).withOpacity(0.15),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(
              color: Color(0xFF764BA2),
              fontWeight: FontWeight.w700,
              fontSize: 12,
            );
          }
          return const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(
              color: Color(0xFF764BA2),
              size: 26,
            );
          }
          return const IconThemeData(color: Colors.grey, size: 24);
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
