import 'package:flutter/widgets.dart';

class SizeHelper {
  static double getDeviceHeight(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return height;
  }

  static double getDeviceWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width;
  }

  static Widget h01() => SizedBox(height: 1);
  static Widget h02() => SizedBox(height: 2);
  static Widget h03() => SizedBox(height: 3);
  static Widget h05() => SizedBox(height: 5);
  static Widget h08() => SizedBox(height: 8);
  static Widget h1() => SizedBox(height: 10);
  static Widget h15() => SizedBox(height: 15);
  static Widget h2() => SizedBox(height: 20);
  static Widget h3() => SizedBox(height: 30);
  static Widget h4() => SizedBox(height: 40);
  static Widget h5() => SizedBox(height: 50);
  static Widget h6() => SizedBox(height: 60);
  static Widget h7() => SizedBox(height: 70);
  static Widget h8() => SizedBox(height: 80);
  static Widget h10() => SizedBox(height: 100);
  static Widget h20() => SizedBox(height: 200);

  static Widget hx({
    required BuildContext context,
    required double hMultiplier,
  }) =>
      SizedBox(height: getDeviceHeight(context) * hMultiplier);

  static Widget w01() => SizedBox(width: 1);
  static Widget w02() => SizedBox(width: 2);
  static Widget w05() => SizedBox(width: 5);
  static Widget w1() => SizedBox(width: 10);
  static Widget w015() => SizedBox(width: 15);
  static Widget w2() => SizedBox(width: 20);
  static Widget w3() => SizedBox(width: 30);
  static Widget w4() => SizedBox(width: 40);
  static Widget w6() => SizedBox(width: 60);
  static Widget w8() => SizedBox(width: 80);
}