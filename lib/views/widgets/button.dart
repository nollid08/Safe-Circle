import 'package:flutter/material.dart';
import 'package:safe_circle/constants.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final Icon icon;
  final String text;

  const Button({this.onPressed, this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ),
      onPressed: onPressed,
      icon: icon,
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
