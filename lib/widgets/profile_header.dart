import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/profile_constants.dart';
import 'package:flutter_application_1/models/user.dart';

class ProfileHeader extends StatelessWidget {
  final User user;
  final bool isLoading;

  const ProfileHeader({super.key, required this.user, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ProfileConstants.paddingLarge),
      child: Column(
        children: [
          // Avatar
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                backgroundImage: user.image.isNotEmpty
                    ? AssetImage(user.image)
                    : null,
                child: user.image.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 60,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      )
                    : null,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'edit_profile');
                  },
                  icon: Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 32,
                    minWidth: 32,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
          const SizedBox(height: ProfileConstants.paddingMedium),

          // User info
          if (isLoading)
            const CircularProgressIndicator()
          else ...[
            Text(
              user.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: ProfileConstants.paddingSmall),
            Text(
              user.email,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: ProfileConstants.paddingSmall),
            Text(
              user.address,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
