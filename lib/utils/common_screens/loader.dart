import 'package:Eimi/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.1),
        body:
        Center(
            child: Lottie.asset(
              "assets/jsons/app_loader.json",
              width: 120,
              height: 120,
              // fit: BoxFit.fill,
            ))
        // const Center(
        //     child:
        //     CircularProgressIndicator(semanticsLabel: Strings.LOADING))
    );
  }
}
class CustomLoader extends StatelessWidget {
  final String content;

  const CustomLoader({super.key,this.content="Loading"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // body: const Center(
        //     child: CircularProgressIndicator(
        //         semanticsLabel: AppStrings.LOADING)));
        body: Center(
            child: Lottie.asset(
              "assets/jsons/payment_loading.json",
              width: 240,
              height: 240,
              // fit: BoxFit.fill,
            )));
  }
}