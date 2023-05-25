import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData iconData;
  final double iconSize;
  final paddingReduce;
  final Color? buttonColor;
  final Color? color;

  RoundedIconButton(
      {required this.onPressed,
      required this.iconData,
      this.iconSize = 30,
      this.buttonColor,
      this.color,
      this.paddingReduce = 0});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0,
      elevation: 5,
      textColor: color,
      color: buttonColor != null ? buttonColor : buttonColor,
      onPressed: onPressed,
      padding: EdgeInsets.all((iconSize / 2) - paddingReduce),
      child: Icon(iconData, size: iconSize),
      shape: CircleBorder(),
    );
  }
}
