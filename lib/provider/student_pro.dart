import 'dart:developer';

import 'package:classchronicaladminweb/widget/customDialogWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class StudentPro with ChangeNotifier {
  final crrentUid = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  //student semester update
  List semesterGet = [];
  Future<void> getSemestersListFunc(String degreeId) async {
    log("degreeId: $degreeId");
    semesterGet = [];

    await firestore
        .collection("semester")
        .where("degree_id", isEqualTo: degreeId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        debugPrint("element: ${element.data()}");
        semesterGet.add(element.data());
      });
    });
  }

  //student
  studentSemesterUpdateUpdateFunc(
      String userId, String semesterId, context) async {
    loadingDailog(context);

    await firestore
        .collection("student_auth")
        .doc(
          userId,
        )
        .update({
      "semester_id": semesterId,
    }).then((value) async {
      debugPrint("Updated semester: $semesterId");
      notifyListeners();

      Navigator.pop(context);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      Navigator.pop(context);

      debugPrint(error.toString());
    });
  }
}
