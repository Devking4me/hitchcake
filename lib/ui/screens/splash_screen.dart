import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Hitchcake/ui/screens/start_screen.dart';
import 'package:Hitchcake/ui/screens/top_navigation_screen.dart';
import 'package:Hitchcake/util/constants.dart';
import 'package:Hitchcake/util/shared_preferences_utils.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkIfUserExists();
  }

  Future<void> checkIfUserExists() async {
    String? userId = await SharedPreferencesUtil.getUserId();

    if (userId != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => TopNavigationScreen()));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => StartScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Image.asset(
        'images/logo.png',
        width: 100.0,
        height: 120.0,
      )),
    );
  }
}
