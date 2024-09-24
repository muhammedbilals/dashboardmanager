
import 'package:dashboard/core/colors/colors.dart';
import 'package:flutter/material.dart';


class AppStyles {
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight bold = FontWeight.w600;
  static FontWeight extraBold = FontWeight.w700;
  static FontWeight veryBold = FontWeight.w800;

  static TextStyle red28medius = TextStyle(
    fontSize: 28,
    color: colorred,
    fontWeight: medium,
  );

  static TextStyle black18regular = TextStyle(
    fontSize: 18,
    color: colorblack,
    fontWeight: regular,
  );
   static TextStyle black18regularWithOpacity = TextStyle(
    fontSize: 18,
    color: colorblack.withOpacity(0.9),
    fontWeight: regular,
  );
  static TextStyle black26bold = TextStyle(
    fontSize: 30,
    color: colorblack.withOpacity(0.5),
    fontWeight: bold,
  );
  static TextStyle red26bold = TextStyle(
    fontSize: 30,
    color: colorred,
    fontWeight: bold,
  );

  static TextStyle black14medium = TextStyle(
    fontSize: 14,
    color: colorblack,
    fontWeight: medium,
  );
  static TextStyle black14regular = TextStyle(
    fontSize: 14,
    color: colorblack,
    fontWeight: regular,
  );
  static TextStyle black14mediumOpacity5 = TextStyle(
    fontSize: 14,
    color: colorblack.withOpacity(0.5),
    fontWeight: medium,
  );
  static TextStyle black16regularOpacity5 = TextStyle(
    fontSize: 16,
    color: colorblack.withOpacity(0.5),
    fontWeight: regular,
  );
  static TextStyle black16medium = TextStyle(
    fontSize: 16,
    color: colorblack,
    fontWeight: medium,
  );
  static TextStyle red22medium = TextStyle(
    fontSize: 22,
    color: colorred,
    fontWeight: medium,
  );

  static TextStyle black18medium = TextStyle(
    fontSize: 18,
    color: colorblack,
    fontWeight: medium,
  );
  static TextStyle black16regular = TextStyle(
    fontSize: 16,
    color: colorblack,
    fontWeight: regular,
  );
  static TextStyle green16regular = TextStyle(
    fontSize: 16,
    color: Colors.green,
    fontWeight: regular,
  );
  static TextStyle black14bold = TextStyle(
    fontSize: 14,
    color: colorblack,
    fontWeight: bold,
  );
}
