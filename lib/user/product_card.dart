import 'package:cached_network_image/cached_network_image.dart';
import 'package:Eimi/user/product_details_screen.dart';
import 'package:Eimi/utils/core/core.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final String layout;

  const ProductCard({super.key, required this.item, this.layout = "grid"});

  static const String fallbackImage = 'https://via.placeholder.com/150';

  @override
  Widget build(BuildContext context) {
    return _buildListLayout(context);
  }


  Widget _buildListLayout(BuildContext context) {
    final String imageUrl = item["imageUrl"]?.toString() ?? '';
    final String title = item["title"]?.toString() ?? "No Title";
    final String price = item["price"]?.toString() ?? "0";

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailScreen(product: item)),
      ),
      child: Card(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(imageUrl, width: deviceWidth(context) , height: deviceHeight(context)*0.1),
            VerticalSpace(),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customThemeText("₹$price", 18,fontWeight: FontWeight.w700,color: AppColors.black),
                  customThemeText(
                      title,
                      16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis,
                      softWrap: true,
                      textAlign: TextAlign.center
                  ),
                  customThemeText("View Details", 14,fontWeight: FontWeight.w500,color: AppColors.primary)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? url, {double? width, double? height, BoxFit fit = BoxFit.fill}) {
    if (url == null || url.isEmpty) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/car_product2.png"))
        ),);
    } else {
      return CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: Colors.grey.shade200,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/car_product2.png"))
          ),),
      );
    }
  }

}
