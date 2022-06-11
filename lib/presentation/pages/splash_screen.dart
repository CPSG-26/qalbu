import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/presentation/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kPrimary,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Image.asset(
            "assets/logo/qalbu-white-transparent.png",
            height: 64,
          ),
        ),
      ),
    );
  }
}
