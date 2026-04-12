import 'package:flutter/material.dart';

class ColorConsts {
  static ColorConsts instance = ColorConsts._();

  ColorConsts._();

  factory ColorConsts() {
    return instance;
  }

  static const Color primary = Color(0xFF1F83E6);
  static const Color secondary = Color(0xFF1B2232);
  static const Color accent = Color(0xFFF8F7FC);
  static const Color alto = Color(0xFFD9D9D9);
  static const Color alabaster = Color(0xFFF8F8F8);
  static const Color black = Colors.black;
  static const Color boulder = Color(0xFF7C7C7C);
  static const Color blue = Colors.blue;
  static const Color codGray = Color(0xFF1C1C1C);
  static const Color doveGray = Color(0xFF6C6C6C);
  static const Color dodgerBlue = Color(0xFF45A1FF);
  static const Color emperor = Color(0xFF525252);
  static const Color mercury = Color(0xFFE9E9E9);
  static const Color lightBlue = Colors.lightBlue;
  static const Color gallery = Color(0xFFF0F0F0);
  static const Color green = Colors.green;
  static const Color oceanGreen = Color(0xFF3FB580);
  static const Color silverChalice = Color(0xFFB2B2B2);
  static const Color lightGreen = Colors.lightGreen;
  static const Color white = Colors.white;
  static const Color whisper = Color(0xFFFDFDFE);
  static const Color grey = Color(0xFF394652);
  static const Color lightGrey = Color(0xFFF6F6F6);
  static const Color mischka = Color(0xFFE2E1E5);
  static const Color wildSand = Color(0xFFF5F5F5);
  static const Color whiteLiliac = Color(0xFFEAE2F5);
  static const Color red = Colors.red;
  static const Color transparent = Colors.transparent;
}