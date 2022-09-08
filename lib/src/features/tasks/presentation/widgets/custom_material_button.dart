import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  String? text;
  double textSize;
  Color? color;
  double? elevation;
  double height;
  Color? textColor;
  ButtonTextTheme? textTheme;
  double minWidth;
  VoidCallback pressed;

  CustomMaterialButton({
    required this.pressed,
    this.color,
    this.elevation,
    this.height = 50.0,
    this.minWidth = double.infinity,
    this.text,
    this.textColor,
    this.textSize = 25.0,
    this.textTheme,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: pressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        text!,
        style: TextStyle(fontSize: textSize),
      ),
      color: color,
      elevation: elevation,
      height: height,
      textColor: textColor,
      textTheme: textTheme,
      minWidth: minWidth,
    );
  }
}
