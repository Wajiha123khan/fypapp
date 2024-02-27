import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

loadingDailog(context) {
  return showAnimatedDialog(
    barrierDismissible: false,
    animationType: DialogTransitionType.fade,
    curve: Curves.bounceIn,
    duration: const Duration(milliseconds: 300),
    context: context,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        backgroundColor: themeblackcolor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        titlePadding: const EdgeInsets.all(24),
        actionsPadding: const EdgeInsets.all(0),
        buttonPadding: const EdgeInsets.all(0),
        title: Container(
          color: themeblackcolor,
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
