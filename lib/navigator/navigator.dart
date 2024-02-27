import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteNavigator {
  static route(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static dialogroute(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => screen,
      ),
    );
  }

  static replacementroute(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }

  static pushandremoveroute(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => screen,
        ),
        (route) => false);
  }
}
