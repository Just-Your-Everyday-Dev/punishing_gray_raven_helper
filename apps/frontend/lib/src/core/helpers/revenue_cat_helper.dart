import 'dart:io';

import '../constants/const_imports.dart';
import '../constants/revenue_cat_consts.dart';

class RevenueCatHelper {
  static RevenueCatHelper _instance = RevenueCatHelper._();

  RevenueCatHelper._();

  factory RevenueCatHelper() => _instance;

  String mapEnumToString(RcBundles bundles) {
    final isAndroid = Platform.isAndroid;

    switch (bundles) {
      case RcBundles.annual:
        return isAndroid
            ? RevenueCatConsts.androidAnnual
            : RevenueCatConsts.iOSAnnual;
      case RcBundles.monthly:
        return isAndroid
            ? RevenueCatConsts.androidMonthly
            : RevenueCatConsts.iOSMonthly;
    }
  }

  RcBundles mapStringToEnum(String val) {
    switch (val) {
      case RevenueCatConsts.androidMonthly:
        return RcBundles.monthly;
      case RevenueCatConsts.iOSMonthly:
        return RcBundles.monthly;
      case RevenueCatConsts.androidAnnual:
        return RcBundles.annual;
      case RevenueCatConsts.iOSAnnual:
        return RcBundles.annual;
      default:
        return RcBundles.monthly;
    }
  }
}