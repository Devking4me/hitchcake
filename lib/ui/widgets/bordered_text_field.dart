import 'package:flutter/material.dart';
import 'package:Hitchcake/util/constants.dart';

class BorderedTextField extends StatefulWidget {
  final String labelText;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  bool obscureText;
  final bool autoFocus;
  final TextCapitalization textCapitalization;
  final textController;

  BorderedTextField(
      {required this.labelText,
      required this.onChanged,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.autoFocus = false,
      this.textCapitalization = TextCapitalization.none,
      this.textController});

  @override
  State<BorderedTextField> createState() => _BorderedTextFieldState();
}

class _BorderedTextFieldState extends State<BorderedTextField> {
  @override
  Widget build(BuildContext context) {
    Color color = Color.fromARGB(158, 111, 103, 110);

    return !widget.obscureText
        ? TextField(
            controller: widget.textController,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText,
            autofocus: widget.autoFocus,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            style: TextStyle(color: const Color.fromARGB(255, 68, 61, 61)),
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(color: kSecondaryColor.withOpacity(0.5)),
              border: UnderlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: color),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color.fromARGB(255, 94, 15, 87)),
              ),
            ),
          )
        : TextField(
            controller: widget.textController,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText,
            autofocus: widget.autoFocus,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization,
            style: TextStyle(color: const Color.fromARGB(255, 68, 61, 61)),
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(color: kSecondaryColor.withOpacity(0.5)),
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.obscureText = !widget.obscureText;
                    });
                  },
                  child: Icon(Icons.visibility_outlined)),
              border: UnderlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: color),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color.fromARGB(255, 94, 15, 87)),
              ),
            ),
          );
  }
}
