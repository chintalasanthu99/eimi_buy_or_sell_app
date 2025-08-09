import 'package:eimi_buy_or_sell_app/user/review_screen.dart';
import 'package:eimi_buy_or_sell_app/user/user_bookings_screen.dart';
import 'package:eimi_buy_or_sell_app/user/user_edit_profile_screen.dart';
import 'package:eimi_buy_or_sell_app/user/user_notifications_screen.dart';
import 'package:eimi_buy_or_sell_app/user/user_settings_screen.dart';
import 'package:eimi_buy_or_sell_app/user/user_wish_list_screen.dart';
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/size_utils.dart';
import 'package:eimi_buy_or_sell_app/utils/text_utils.dart';
import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              foregroundColor: Colors.white,
            ),
            child: const Text("Logout"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: colorScheme.background,
        elevation: 0.5,
        foregroundColor: colorScheme.onBackground,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserEditProfileScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=5"),
                  ),
                  SizeUtils.height10,
                  Text("John Doe", style: TextUtils.headingStyle(context)),
                  SizeUtils.height6,
                  Text(
                    "johndoe@example.com",
                    style: TextUtils.smallTextStyle(context).copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  SizeUtils.height6,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "Tap to edit",
                      style: TextUtils.smallTextStyle(context).copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Options List
          _buildCard(context, children: [
            _buildOption(
              context,
              icon: Icons.favorite_border,
              label: "My Wishlist",
              destination: const UserWishlistScreen(),
            ),
            _buildOption(
              context,
              icon: Icons.book_online_outlined,
              label: "My Bookings",
              destination: const UserBookingsScreen(),
            ),
            _buildOption(
              context,
              icon: Icons.rate_review_outlined,
              label: "My Reviews",
              destination: const ReviewScreen(),
            ),
            _buildOption(
              context,
              icon: Icons.notifications_outlined,
              label: "Notifications",
              destination: const UserNotificationScreen(),
            ),
            _buildOption(
              context,
              icon: Icons.settings,
              label: "Settings",
              destination: const UserSettingsScreen(),
            ),
          ]),

          SizeUtils.height20,

          // Logout Button
          _buildCard(
            context,
            children: [
              ListTile(
                leading: Icon(Icons.logout, color: AppColors.danger),
                title: Text(
                  "Logout",
                  style: TextUtils.bodyStyle(context).copyWith(
                    color: AppColors.danger,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => _showLogoutDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // A container card wrapper for grouped list items
  Widget _buildCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // ListTile builder
  Widget _buildOption(
      BuildContext context, {
        required IconData icon,
        required String label,
        required Widget destination,
      }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(label, style: TextUtils.bodyStyle(context)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => destination),
        );
      },
    );
  }
}
