import 'package:flutter/material.dart';
import 'package:Hitchcake/util/constants.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  RoundedOutlinedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsetsDirectional.symmetric(vertical: 13),
            primary: Colors.white,
            onPrimary: kAccentColor,
            side: BorderSide(color: kSecondaryColor, width: 2.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          onPressed: onPressed,
          child: Text(text, style: Theme.of(context).textTheme.button),
        ));
  }
}
