import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/const_imports.dart';
import 'size_helper.dart';

class AppHelper {
  static final AppHelper _instance = AppHelper._();

  AppHelper._();

  factory AppHelper() => _instance;

  static void launchUrl(String url) async {
    final canLaunch = await canLaunchUrlString(url);
    if (canLaunch) {
      await launchUrlString(url);
    } else {
      debugPrint('could not launch url');
    }
  }

  static void dismissKeyboard({required BuildContext ctx}) {
    if (ctx.mounted) {
      final currentFocus = FocusScope.of(ctx);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    } else {
      return;
    }
  }

  static void showSnackBar({
    required BuildContext ctx,
    required String msg,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        backgroundColor: ColorConsts.primary,
        content: Text(
          msg,
          style: AppTextStyles.regular(color: ColorConsts.white),
        ),
        duration: duration,
      ),
    );
  }

  static Future<void> showConfirmationModalBottomSheet({
    required BuildContext context,
    bool showYesButton = true,
    bool showNoButton = true,
    String? noBtnTitle,
    String? yesBtnTitle,
    String title = '',
    String message = '',
    VoidCallback? onYesClick,
    VoidCallback? onNoClick,
  }) async {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(Dimensions.px20),
      topRight: Radius.circular(Dimensions.px20),
    );
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      builder: (_) {
        return SafeArea(
          child: Container(
            padding: PaddingConsts.screenHigh,
            decoration: BoxDecoration(borderRadius: borderRadius),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizeHelper.h1(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.semiBold(fontSize: Dimensions.px20),
                ),
                SizeHelper.h1(),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular(),
                ),
                SizeHelper.h2(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onYesClick,
                        child: Text(StringConsts.yes),
                      ),
                    ),
                    SizeHelper.w1(),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          if (onNoClick != null) {
                            onNoClick();
                          }
                          Navigator.pop(context);
                        },
                        child: Text(StringConsts.no),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showSimpleDialogue<T>({
    bool showOkayButton = false,
    bool showIcon = false,
    bool showNoButton = false,
    String cancelBtnTitle = 'No',
    String okBtnTitle = 'Ok',
    required BuildContext context,
    String title = 'Alert',
    String message = '',
    Function? onClick,
    bool isDismiss = true,
  }) async {
    await showDialog<T>(
      context: context,
      barrierDismissible: isDismiss,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: SizeHelper.getDeviceWidth(context) / Dimensions.px1,
                decoration: BoxDecoration(
                  color: ColorConsts.white,
                  borderRadius: BorderRadius.circular(Dimensions.px10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.px15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: Dimensions.px20),
                      if (showIcon)
                        Icon(Icons.done, size: 40, color: ColorConsts.primary),
                      SizedBox(height: Dimensions.px10),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.semiBold(
                          fontSize: Dimensions.px18,
                        ),
                      ),
                      SizedBox(height: Dimensions.px10),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regular(fontSize: Dimensions.px14),
                      ),
                      SizedBox(height: Dimensions.px25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          if (showOkayButton)
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (onClick == null) {
                                    Navigator.pop(context);
                                    return;
                                  }
                                  onClick();
                                  Navigator.pop(context);
                                },
                                child: Text(okBtnTitle),
                              ),
                            ),
                          SizeHelper.w1(),
                          if (showNoButton)
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(cancelBtnTitle),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: Dimensions.px10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
