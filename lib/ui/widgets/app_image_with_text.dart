import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppIconTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset(
      'images/logo.png',
      width: 100.0,
      height: 120.0,
      fit: BoxFit.contain,
    ));
  }
}
