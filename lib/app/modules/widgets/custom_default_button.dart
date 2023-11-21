import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Color? buttonColor;
  final double? width;
  final Function() onTap;
  final TextStyle? textStyle;

  const DefaultButton({
    super.key,
    required this.text,
    this.color,
    this.buttonColor,
    required this.width,
    required this.onTap,
    this.textColor,
    this.height,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 60,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(30.0)),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? TextStyle(color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
