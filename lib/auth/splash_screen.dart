import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/route_constants.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      print("lkfmkfl");
      Navigator.pushReplacementNamed(context, RouteStrings.SIGNIN);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Text(
          'MyApp',
          style: TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}