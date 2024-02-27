import 'dart:typed_data';

import 'package:classchronicaladminweb/utils/storage_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../dashboard/style/theme_colors.dart';

class reused {
  void navipop(int value, context) {
    for (int i = 0; i < value; i++) {
      Navigator.pop(context);
    }
  }
}

class ReusedPro with ChangeNotifier {
  Uint8List? slctImageV;
  Future slctimage() async {
    try {
      Uint8List file;
      file = await pickImage(ImageSource.gallery);

      slctImageV = file;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  late OverlayEntry overlay2;
  void showloadingoverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    overlay2 = OverlayEntry(
      builder: (context) {
        return Container(
          height: 100,
          width: 100,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: themewhitecolor.withOpacity(0.2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
              child: CupertinoActivityIndicator(
            color: Colors.blue,
            radius: 50,
          )),
        );
      },
    );

    overlayState.insertAll([
      overlay2,
    ]);
  }

  void removeoverlay(context) async {
    overlay2.remove();
    notifyListeners();
  }
}

String timeAgo(Timestamp d) {
  Duration diff = DateTime.now().difference(d.toDate());
  if (diff.inDays > 365) return DateFormat.yMMMd().format(d.toDate());
  if (diff.inDays > 30) return DateFormat.yMMMd().format(d.toDate());
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}
