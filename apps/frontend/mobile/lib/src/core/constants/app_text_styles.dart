import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_consts.dart';
import 'dimension_consts.dart';

class AppTextStyles {
  static TextStyle button({Color? lblColor, double? fontSize}) {
    return AppTextStyles.medium(
      color: lblColor ?? ColorConsts.white,
      fontSize: fontSize ?? Dimensions.px15,
    );
  }

  static TextStyle header() {
    return AppTextStyles.bold(fontSize: Dimensions.px20);
  }

  static TextStyle label() {
    return AppTextStyles.regular();
  }

  static TextStyle subHeader() {
    return AppTextStyles.medium(fontSize: Dimensions.px18);
  }

  static TextStyle title() {
    return AppTextStyles.regular(fontSize: Dimensions.px16);
  }

  static TextStyle inter14CodGray() => GoogleFonts.inter(
    textStyle: TextStyle(
      fontSize: Dimensions.px14,
      color: ColorConsts.codGray,
      fontWeight: FontWeight.w400,
    ),
  );

  static TextStyle regular({
    double? height,
    Color color = ColorConsts.secondary,
    bool isUnderline = false,
    double fontSize = Dimensions.px14,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color,
        height: height,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        decorationColor: color,
      ),
    );
  }

  static TextStyle medium({
    double? height,
    Color color = ColorConsts.secondary,
    bool isUnderline = false,
    double fontSize = Dimensions.px14,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
        height: height,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
        decorationColor: color,
      ),
    );
  }

  static TextStyle semiBold({
    double? height,
    Color color = ColorConsts.codGray,
    bool isUnderline = false,
    double fontSize = Dimensions.px14,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
        height: height,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }

  static TextStyle bold({
    double? height,
    Color color = ColorConsts.secondary,
    bool isUnderline = false,
    double fontSize = Dimensions.px14,
  }) {
    return GoogleFonts.inter(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
        height: height,
        decorationColor: color,
        decoration:
            isUnderline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}