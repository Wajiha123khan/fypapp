import 'dart:developer';
import 'dart:typed_data';

import 'package:classchronicaladminweb/utils/storage_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SemesterPro with ChangeNotifier {
  final crrentUid = FirebaseAuth.instance;

//images
  Uint8List? subjectImage;
  Future pickSubjectImage() async {
    try {
      Uint8List file = await pickImage(ImageSource.gallery);

      subjectImage = file;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image:$e');
    }
  }

  List semester_get = ['sa'];
  bool get_semester_isloading = false;
  List Dumy = [];
  void Get_semester_fun(degree_title) async {
    log(degree_title);
    semester_get = [];
    // semester_get.add("semester_get");
    get_semester_isloading = true;
    String degree_id = "";

    notifyListeners();
    FirebaseFirestore.instance
        .collection("degree")
        .where('title', isEqualTo: degree_title.toString())
        .get()
        .then(
      (value) async {
        value.docs.forEach((doc) {
          degree_id = doc.data()["degree_id"].toString();
          FirebaseFirestore.instance
              .collection("semester")
              .where('degree_id', isEqualTo: degree_id.toString())
              .get()
              .then(
            (value) async {
              value.docs.forEach((doc) {
                semester_get.add(doc.data()["title"]);
                print(semester_get.toString() + " ddd");
              });
            },
          ).whenComplete(() {
            notifyListeners();
            // get_semesters(Dumy);
          });
        });
      },
    );
  }
}
