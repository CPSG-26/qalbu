import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qalbu/common/colors.dart';
import 'package:qalbu/presentation/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
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
