import 'package:flutter/material.dart';
import 'vendor_notificatons_screen.dart';

class VendorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String storeName;
  final VoidCallback? onLogout;
  final VoidCallback? onNotificationsTap;

  const VendorAppBar({
    super.key,
    required this.storeName,
    this.onLogout,
    this.onNotificationsTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 12);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SizedBox(
        height: kToolbarHeight,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome back,', style: theme.textTheme.bodySmall),
                  Text(
                    storeName,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: onNotificationsTap ??
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>  VendorNotificationScreen()),
                    );
                  },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Confirm Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          if (onLogout != null) onLogout!();
                        },
                        child: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
