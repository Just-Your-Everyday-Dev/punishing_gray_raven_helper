import 'package:flutter/material.dart';

class RoutingHelper {
  static void pushAndRemoveUntilToScreen({
    required BuildContext ctx,
    required Widget screen,
  }) {
    final route = MaterialPageRoute(builder: (ctx) => screen);
    Navigator.pushAndRemoveUntil(ctx, route, (route) => false);
  }

  static void pushReplacementToScreen({
    required BuildContext ctx,
    bool fullscreenDialog = false,
    required Widget screen,
  }) {
    final route = MaterialPageRoute(
      builder: (ctx) => screen,
      fullscreenDialog: fullscreenDialog,
    );
    Navigator.pushReplacement(ctx, route);
  }

  static Future<void> pushToScreen({
    required BuildContext ctx,
    bool fullscreenDialog = false,
    required Widget screen,
  }) {
    if (fullscreenDialog) {
      return Navigator.of(ctx).push(
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) {
              return screen;
            }),
      );
    } else {
      final route = MaterialPageRoute(
        builder: (ctx) => screen,
        fullscreenDialog: fullscreenDialog,
      );
      return Navigator.push(ctx, route);
    }
  }

  static void popUntilIsFirst({required BuildContext ctx}) {
    Navigator.popUntil(ctx, (materialRoute) => materialRoute.isFirst);
  }
}