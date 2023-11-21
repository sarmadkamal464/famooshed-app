import 'package:famooshed/app/common/util/exports.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

abstract class AppColors {
  static const Color kPrimaryColor = Color(0xFF1976D2);
  static const Color mineShaft = Color(0xFF2B2B2B);
  static const Color doveGray = Color(0xFF646464);
  static const Color caribbeanGreen = Color(0xFF06C5AC);
  static const Color amaranth = Color(0xFFea435d);
  static const Color appTheme = Color(0xFF215034);
  static const Color loginBackgroud = Color(0xFFEBF9DC);
  static Color darkGreenColor = HexColor('215034');
  static Color lightGreenColor = HexColor('697A70');
  static Color redColor = HexColor('C95C54');
  static Color lightRed = HexColor('F3BFBD');
  static Color blueColor = HexColor('3871B2');
  static Color lightBlue = HexColor('6D98C9');
  static Color lightBlack = HexColor('555555');
  static Color greyText = HexColor('#9D9D9D');
  static Color appBarbackground = HexColor('F5FFEB');
  static Color appThemeLight = HexColor('#EBF9DC');
  static Color appThemeText = HexColor('#29AD5F');
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static Color lightGrey = HexColor('#F4F4F4');
  static Color blueColorLight = HexColor('#F3F8FC');
  static Color deleteButton = HexColor('#FFF1F1');
  static Color viewAllText = HexColor('217041');
  static Color bottomNavItemColor = "#217041".fromHex;

  //order status color
  static Color orderPending = HexColor('#F0B414');
  static Color orderSucess = HexColor('#29AD5F');
  static Color orderCancel = HexColor('#E34D4D');
}
