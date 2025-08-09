import 'package:eimi_buy_or_sell_app/user/product_details_screen.dart';
import 'package:eimi_buy_or_sell_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> allProducts = List.generate(15, (index) {
  return {
    "title": "Product ${index + 1}",
    "category": index % 2 == 0 ? "Plots" : "Electronics",
    "subcategory": "Subcat ${index + 1}",
    "price": 50000 + index * 1000,
    "likes": 10 + index,
    "wishCount": 5 + index,
    "rating": 4 + (index % 2),
    "status": index % 3 == 0 ? "sold" : "available",
    "imageUrl": index % 4 == 0 ? null : "https://picsum.photos/200?random=$index",
    "location": index % 2 == 0 ? "Hyderabad" : "Bangalore"
  };
});

final List<Map<String, dynamic>> bookings = List.generate(10, (index) {
  return {
    "date": "July ${10 + index}, 2025",
    "time": "${10 + index % 4}:00 ${index % 2 == 0 ? 'AM' : 'PM'}",
    "status": index % 3 == 0
        ? "Confirmed"
        : index % 3 == 1
        ? "Pending"
        : "Cancelled",
    "product": allProducts[index],
  };
});

class UserBookingsScreen extends StatelessWidget {
  const UserBookingsScreen({super.key});

  Color _getStatusColor(String status, ColorScheme colorScheme) {
    switch (status) {
      case "Confirmed":
        return AppColors.success;
      case "Pending":
        return AppColors.warning;
      case "Cancelled":
        return Colors.red; // you could also derive a tone from colorScheme.error
      default:
        return colorScheme.outline;
    }
  }
  Color _getStatusBackgroundColor(String status, ColorScheme colorScheme) {
    switch (status) {
      case "Confirmed":
        return colorScheme.primary.withOpacity(0.1);
      case "Pending":
        return colorScheme.tertiary.withOpacity(0.1);
      case "Cancelled":
        return Colors.red.withOpacity(0.1);
      default:
        return colorScheme.surfaceContainerHighest.withOpacity(0.1);
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.onBackground,
        elevation: 0.5,
      ),
      body: bookings.isEmpty
          ? Center(
        child: Text(
          "No bookings yet.",
          style: textTheme.bodyLarge,
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: bookings.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final booking = bookings[index];
          final product = booking["product"];
          final statusColor = _getStatusColor(booking["status"], colorScheme);

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product),
                ),
              );
            },
            child: Card(
              elevation: 2,
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: product["imageUrl"] != null
                          ? Image.network(
                        product["imageUrl"],
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        'assets/images/service_category.jpg',
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["title"],
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product["location"],
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${booking["date"]} at ${booking["time"]}",
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary.withAlpha(10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  booking["status"],
                  style: textTheme.labelMedium?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
