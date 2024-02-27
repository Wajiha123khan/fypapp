// import 'package:cherry_toast/cherry_toast.dart';
// import 'package:cherry_toast/resources/arrays.dart';
import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

showCustomToast(String msg, BuildContext context) {
  return showToast(
    msg,
    context: context,
    animation: StyledToastAnimation.scale,
    reverseAnimation: StyledToastAnimation.fade,
    position: StyledToastPosition.center,
    animDuration: const Duration(seconds: 1),
    duration: const Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
  );
}


customToast(String msg, context){
  return  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1000),
      dismissDirection: DismissDirection.down,
      backgroundColor: themewhitecolor.withOpacity(0.9),
      elevation: 7,
      content: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              "assets/images/png/logo.png",
              height: 60,
              // width: 40,
              fit: BoxFit.fitHeight,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: Text(
              msg,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: themeblackcolor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    ),
  );

}