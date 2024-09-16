import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 6), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return MyHomePage(title: 'BMI Calculator');
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Lottie.asset(
          'assets/animation/animation1a.json',
          width: 300,
          height: 300,
          repeat: true,
          // fit: BoxFit.cover,
        ),
      ),
    ));
  }
}
