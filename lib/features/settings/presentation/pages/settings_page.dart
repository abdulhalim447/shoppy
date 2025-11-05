import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/constants/app_constants.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../data/models/user_model.dart';
import '../widgets/user_profile_card.dart';
import '../widgets/settings_menu_item.dart';

/// Settings page
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _initializeDummyUser();
  }

  void _initializeDummyUser() {
    _user = UserModel(
      id: '1',
      fullName: 'John Doe',
      email: 'john.doe@example.com',
      phoneNumber: '+1 (555) 000-0000',
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      notificationsEnabled: true,
      emailNotificationsEnabled: true,
    );
  }

  void _onProfileTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit profile coming soon')),
    );
  }

  void _onAccountSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account settings coming soon')),
    );
  }

  void _onNotifications() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifications settings coming soon')),
    );
  }

  void _onPaymentMethods() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment methods coming soon')),
    );
  }

  void _onHelpSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Help & Support coming soon')),
    );
  }

  void _onSignOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signed out successfully')),
              );
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MinimalAppBar(
        title: 'SETTINGS',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Card
              UserProfileCard(
                user: _user,
                onTap: _onProfileTap,
              ),
              const SizedBox(height: AppConstants.spacingLg),

              // Settings Menu Items
              SettingsMenuItem(
                icon: Icons.person,
                label: 'Account Settings',
                onTap: _onAccountSettings,
              ),
              SettingsMenuItem(
                icon: Icons.notifications,
                label: 'Notifications',
                onTap: _onNotifications,
              ),
              SettingsMenuItem(
                icon: Icons.credit_card,
                label: 'Payment Methods',
                onTap: _onPaymentMethods,
              ),
              SettingsMenuItem(
                icon: Icons.help,
                label: 'Help & Support',
                onTap: _onHelpSupport,
              ),
              const SizedBox(height: AppConstants.spacingMd),

              // Sign Out Button
              SettingsMenuItem(
                icon: Icons.logout,
                label: 'Sign Out',
                onTap: _onSignOut,
                isDestructive: true,
              ),
              const SizedBox(height: AppConstants.spacingXl),
            ],
          ),
        ),
      ),
    );
  }
}

