import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/profile_constants.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ProfileActions extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onLogout;
  final bool useSliver;

  const ProfileActions({
    super.key,
    required this.onEditProfile,
    required this.onLogout,
    this.useSliver = true,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> actionCards =
        ProfileConstants.profileActions.map<Widget>((action) {
      return Card(
        margin: const EdgeInsets.only(bottom: ProfileConstants.paddingSmall),
        child: ListTile(
          leading: Icon(action.icon),
          title: Text(action.title),
          subtitle: Text(action.subtitle),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            if (action.route == 'edit_profile') {
              onEditProfile();
            } else if (action.route == 'favorite') {
              Navigator.pushNamed(context, 'favorite');
            } else if (action.route == 'orders') {
              Navigator.pushNamed(context, 'orders');
            } else if (action.route == 'payment') {
              Navigator.pushNamed(context, 'payment');
            } else if (action.route == 'settings') {
              Navigator.pushNamed(context, 'settings');
            }
          },
        ),
      );
    }).toList();
    actionCards.add(
      Card(
        margin: const EdgeInsets.only(top: ProfileConstants.paddingSmall),
        child: ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Logout', style: TextStyle(color: Colors.red)),
          onTap: onLogout,
        ),
      ),
    );

    // Return either a sliver or a regular widget depending on `useSliver`.
    if (useSliver) {
      return SliverPadding(
        padding: const EdgeInsets.all(ProfileConstants.paddingMedium),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 375),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: actionCards,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(ProfileConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder: (widget) => SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(child: widget),
          ),
          children: actionCards,
        ),
      ),
    );
  }
}
