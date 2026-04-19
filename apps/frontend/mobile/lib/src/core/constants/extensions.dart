import 'package:flutter/material.dart';

extension MediaQueryBuildContext on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

}