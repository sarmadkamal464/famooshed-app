import 'package:famooshed/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color? buttonColor;
  final double? width;
  final Widget? prefixImg;
  final Color textColor;
  final String logo;
  final Function() onTap;
  const CustomIconButtonWidget(
      {Key? key,
      this.prefixImg,
      required this.text,
      required this.color,
      this.buttonColor,
      this.width,
      required this.textColor,
      required this.logo,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: SizedBox(
          width: width,
          height: 60,
          child: Row(
            children: [
              Container(
                color: color,
                height: 60,
                width: 80,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    logo,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Container(
                height: 60,
                width: width! * .7,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: urbanistBold.copyWith(
                        color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
