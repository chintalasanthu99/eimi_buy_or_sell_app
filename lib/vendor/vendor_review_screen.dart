import 'package:flutter/material.dart';

class VendorReviewsScreen extends StatelessWidget {
  const VendorReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Reviews"),elevation: 1,),
      body: const Center(
        child: Text("You have no reviews yet."),
      ),
    );
  }
}
