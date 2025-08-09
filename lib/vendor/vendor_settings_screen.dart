import 'package:flutter/material.dart';

class VendorSettingsScreen extends StatefulWidget {
  const VendorSettingsScreen({super.key});

  @override
  State<VendorSettingsScreen> createState() => _VendorSettingsScreenState();
}

class _VendorSettingsScreenState extends State<VendorSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        elevation: 1,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 8),

          // Toggle: Notifications
          SwitchListTile(
            title: const Text("Enable Notifications", style: TextStyle(fontWeight: FontWeight.w500)),
            secondary: Icon(Icons.notifications_active_outlined, color: theme.colorScheme.primary),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          _buildDivider(context),

          // Navigation tile: Privacy
          _buildSettingTile(
            context,
            icon: Icons.lock_outline,
            title: "Privacy Settings",
            onTap: () {
              // Handle navigation
            },
          ),
          _buildDivider(context),

          // Toggle: Dark mode
          SwitchListTile(
            title: const Text("Dark Mode", style: TextStyle(fontWeight: FontWeight.w500)),
            secondary: Icon(Icons.dark_mode_outlined, color: theme.colorScheme.primary),
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          _buildDivider(context),

          // Navigation tile: App Theme
          _buildSettingTile(
            context,
            icon: Icons.color_lens_outlined,
            title: "App Theme",
            onTap: () {
              // Handle navigation
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(BuildContext context, {
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      indent: 72,
      endIndent: 16,
      thickness: 0.5,
      color: Theme.of(context).dividerColor.withOpacity(0.3),
    );
  }
}
