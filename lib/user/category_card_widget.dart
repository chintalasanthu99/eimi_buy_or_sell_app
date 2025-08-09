import 'package:cached_network_image/cached_network_image.dart';
import 'package:eimi_buy_or_sell_app/utils/core/core.dart';
import 'package:eimi_buy_or_sell_app/utils/text_utils.dart';
import 'package:eimi_buy_or_sell_app/vendor/models/Category.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final Function() onTap;

   CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  final Map<String, Map<String, dynamic>> categoryMeta = {
    "Cars": {
      "icon": Icons.directions_car,
      "color": Colors.redAccent,
    },
    "Properties": {
      "icon": Icons.house,
      "color": Colors.deepPurple,
    },
    "Mobiles": {
      "icon": Icons.smartphone,
      "color": Colors.green,
    },
    "Jobs": {
      "icon": Icons.work,
      "color": Colors.blueAccent,
    },
    "Bikes": {
      "icon": Icons.pedal_bike,
      "color": Colors.orange,
    },
    "Electronic & Appliances": {
      "icon": Icons.electrical_services,
      "color": Colors.indigo,
    },
    "Commercial Vehicles & Spares": {
      "icon": Icons.local_shipping,
      "color": Colors.brown,
    },
    "Furniture": {
      "icon": Icons.weekend,
      "color": Colors.deepOrange,
    },
    "Fashion": {
      "icon": Icons.checkroom,
      "color": Colors.pinkAccent,
    },
    "Books Sports & Hobbies": {
      "icon": Icons.sports_esports,
      "color": Colors.purple,
    },
    "Pets": {
      "icon": Icons.pets,
      "color": Colors.teal,
    },
    "Services": {
      "icon": Icons.miscellaneous_services,
      "color": Colors.cyan,
    },
  };


  @override
  Widget build(BuildContext context) {
    final String? imageUrl = category.image?.toString();
    final String title = category.title.toString();
    IconData icon = categoryMeta[category.title]?["icon"] as IconData? ?? Icons.category;
    Color color = categoryMeta[category.title]?["color"] as Color? ?? AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            //
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.grey10,
            ),
            child: imageUrl != null && imageUrl.isNotEmpty
                ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Icon(icon, size: 60, color: color),
              errorWidget: (context, url, error) =>
                  Icon(icon, size: 60, color: color),
            )
                : Center(child: Image.asset("assets/images/home_image.png")),
          ),
          const SizedBox(height: 8),
          Container(
            width: 70, // <-- width constraint!
            child: customThemeText(
              title,
              12,
              fontWeight: FontWeight.w700,
              color: AppColors.black10,
              maxLines: 1,
              overFlow: TextOverflow.ellipsis,
              softWrap: true,
              textAlign: TextAlign.center
            ),
          )


        ],
      ),
    );
  }

}
