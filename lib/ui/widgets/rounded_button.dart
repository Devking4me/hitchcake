import 'package:flutter/material.dart';
import 'package:Hitchcake/util/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;

  RoundedButton({required this.text, required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Color.fromRGBO(228, 124, 158, 1);
              }
              return Color.fromRGBO(
                  234, 100, 144, 1); // Use the default button color.
            },
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: 14),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: Theme.of(context).textTheme.button!.copyWith(color: color)),
      ),
    );
  }
}
