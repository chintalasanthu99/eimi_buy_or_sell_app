import 'package:eimi_buy_or_sell_app/bloc/theme_bloc.dart';
import 'package:eimi_buy_or_sell_app/bloc/theme_event.dart';
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:eimi_buy_or_sell_app/utils/size_utils.dart';
import 'package:eimi_buy_or_sell_app/utils/text_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({super.key});

  void _showLanguageDialog(
      BuildContext context, String selectedLanguage, void Function(String) onSelect) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Select Language", style: TextUtils.titleMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ["English", "Hindi", "Telugu", "Kannada"]
              .map(
                (lang) => RadioListTile<String>(
              title: Text(lang, style: TextUtils.bodyLarge),
              value: lang,
              groupValue: selectedLanguage,
              onChanged: (value) {
                if (value != null) {
                  onSelect(value);
                  Navigator.pop(context);
                }
              },
            ),
          )
              .toList(),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Confirm Logout", style: TextUtils.titleMedium),
        content: Text("Are you sure you want to logout?", style: TextUtils.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logged out")),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.danger, foregroundColor: Colors.white,),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeBloc>().state.isDarkMode;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String selectedLanguage = "English";

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextUtils.appBarTitle),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SizeUtils.pagePadding),
        child: ListView(
          children: [
            const SizedBox(height: SizeUtils.spacingXL),

            SwitchListTile(
              title: Text("Enable Notifications", style: TextUtils.bodyLarge),
              value: true,
              onChanged: (_) {},
              secondary: Icon(Icons.notifications, color: AppColors.primary),
            ),

            SwitchListTile(
              title: Text("Dark Mode", style: TextUtils.bodyLarge),
              value: isDarkMode,
              onChanged: (value) {
                context.read<ThemeBloc>().add(ToggleThemeEvent(value));
              },
              secondary: Icon(Icons.dark_mode, color: AppColors.primary),
            ),

            ListTile(
              leading: Icon(Icons.language, color: AppColors.primary),
              title: Text("Change Language", style: TextUtils.bodyLarge),
              trailing: const Icon(Icons.arrow_forward_ios, size: SizeUtils.iconXS),
              onTap: () => _showLanguageDialog(context, selectedLanguage, (lang) {
                selectedLanguage = lang;
              }),
            ),

            ListTile(
              leading: Icon(Icons.lock, color: AppColors.primary),
              title: Text("Privacy & Security", style: TextUtils.bodyLarge),
              trailing:  Icon(Icons.arrow_forward_ios, size: SizeUtils.iconXS),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Privacy screen coming soon")),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.logout, color: AppColors.white),
              title: Text("Logout", style: TextUtils.bodyLarge),
              trailing: Icon(Icons.arrow_forward_ios, size: SizeUtils.iconXS),
              onTap: () => _confirmLogout(context),
            ),
          ],
        ),
      ),
    );
  }
}
