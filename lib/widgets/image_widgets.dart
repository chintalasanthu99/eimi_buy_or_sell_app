import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  final String imagePath;

  const ImageItem({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Image.asset(
        imagePath,
        width: 300,
        fit: BoxFit.cover,
      ),
    );
  }
}
