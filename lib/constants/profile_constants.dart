import 'package:flutter/material.dart';

class ProfileConstants {
  // Colors for Material 3 design
  static const Color primaryColor = Color(0xFF6750A4);
  static const Color secondaryColor = Color(0xFF625B71);
  static const Color tertiaryColor = Color(0xFF7D5260);
  static const Color surfaceColor = Color(0xFFFFFBFE);
  static const Color backgroundColor = Color(0xFFFFFBFE);
  static const Color errorColor = Color(0xFFBA1A1A);

  // Spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double borderRadius = 12.0;

  // Profile actions
  static const List<ProfileAction> profileActions = [
    ProfileAction(
      icon: Icons.edit,
      title: 'Edit Profile',
      subtitle: 'Update your personal information',
      route: 'edit_profile',
    ),
    ProfileAction(
      icon: Icons.shopping_bag,
      title: 'My Orders',
      subtitle: 'View your order history',
      route: 'orders',
    ),
    ProfileAction(
      icon: Icons.payment,
      title: 'Payment Methods',
      subtitle: 'Manage your payment options',
      route: 'payment',
    ),
    ProfileAction(
      icon: Icons.favorite,
      title: 'Favorites',
      subtitle: 'Your liked items',
      route: 'favorite',
    ),
    ProfileAction(
      icon: Icons.settings,
      title: 'Settings',
      subtitle: 'App preferences and configuration',
      route: 'settings',
    ),
  ];
}

class ProfileAction {
  final IconData icon;
  final String title; 
  final String subtitle;
  final String route;

  const ProfileAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });
}
