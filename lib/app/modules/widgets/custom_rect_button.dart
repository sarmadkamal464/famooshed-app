import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class DefaultRectButton extends StatelessWidget {
  final String text;
  final double? height;
  final Color? color;
  final Color? textColor;
  final Color? buttonColor;
  final double? width;
  final GestureTapCallback? onTap;

  const DefaultRectButton({
    super.key,
    required this.text,
    this.color,
    this.buttonColor,
    required this.width,
    required this.onTap,
    this.textColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 50,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(4.0)),
        child: Center(
          child: Text(
            text,
            style: textStyle(textColor ?? color),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  textStyle(color) {
    return urbanistBold.copyWith(
        color: color, fontSize: 12, fontWeight: FontWeight.bold);
  }
}
