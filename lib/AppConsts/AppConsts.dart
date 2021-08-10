import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConsts {
  static Color primaryColor = Color.fromRGBO(20, 28, 43, 1);
  static Color primaryColorLight = Color.fromRGBO(28, 39, 60, 0.9);
  static Color secondaryColor = Color.fromRGBO(9, 1, 23, 1);
  static Color primaryTextColor = Colors.white;
  static Color secTextColor = Colors.black;
  static Color box1Color = CupertinoColors.systemPink;
  static Color box2Color = CupertinoColors.activeOrange;
  static Color box3Color = CupertinoColors.systemTeal;
  static Color box4Color = CupertinoColors.systemIndigo;
  static String appFont = 'ProximaNovaRg';
  static TextStyle whiteBold = TextStyle(
      color: AppConsts.primaryTextColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'ProximaNovaRg');
  static TextStyle whiteNormal = TextStyle(
      color: AppConsts.primaryTextColor,
      fontWeight: FontWeight.normal,
      fontFamily: 'ProximaNovaRg');
  static TextStyle whiteBoldWithSpacing = TextStyle(
      color: AppConsts.primaryTextColor,
      fontWeight: FontWeight.bold,
      letterSpacing: 2.0,
      fontFamily: 'ProximaNovaRg');
  static TextStyle blackBold = TextStyle(
      color: AppConsts.secTextColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'ProximaNovaRg');
  static TextStyle blackNormal = TextStyle(
      color: AppConsts.secTextColor,
      fontWeight: FontWeight.normal,
      fontFamily: 'ProximaNovaRg');
}
