import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_application_1/widgets/profile_header.dart';
import 'package:flutter_application_1/widgets/profile_actions.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);

    try {
      // Simulate loading user data
      await Future.delayed(const Duration(milliseconds: 500));
      // ignore: use_build_context_synchronously
      await Provider.of<AuthProvider>(context, listen: false).getUser();
    } catch (e) {
      if (mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // ignore: use_build_context_synchronously
            content: Text('Error loading user data: $e'),
            // ignore: use_build_context_synchronously
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true && mounted) {
      // ignore: use_build_context_synchronously
      Provider.of<AuthProvider>(context, listen: false).signOut();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,   
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),  
      home : Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (!authProvider.isAuth) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, 'login'),
                    child: const Text('Please log in to view your profile'),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(authProvider.user?.name ?? ''),
                  background:
                      ProfileHeader(user: authProvider.user!, isLoading: _isLoading),
                ),
                actions: [
                  IconButton(
                    onPressed: _loadUserData,
                    icon: const Icon(Icons.refresh),
                    tooltip: 'Refresh profile',
                  ),
                ],
              ),
              ProfileActions(
                onEditProfile: () {
                  Navigator.pushNamed(context, 'edit_profile');
                },
                onLogout: _handleLogout,
              ),
            ],
          );
        },
      ),
    );
  }
}
