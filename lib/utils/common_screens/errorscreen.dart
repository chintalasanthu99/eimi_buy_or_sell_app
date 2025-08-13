import 'package:Eimi/utils/app_colors.dart';
import 'package:flutter/material.dart';


class ErrorScreen extends StatelessWidget {
  final String text;
  final String? imageId;

  const ErrorScreen(this.text, {Key? key, this.imageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(text, style: TextStyle(color: AppColors.black))));
  }
}
