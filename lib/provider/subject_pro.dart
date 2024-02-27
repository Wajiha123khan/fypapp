import 'dart:typed_data';

import 'package:classchronicaladminweb/model/subject_model.dart';
import 'package:classchronicaladminweb/utils/storage_methods.dart';
import 'package:classchronicaladminweb/widget/customDialogWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class SubjectPro with ChangeNotifier {
  final crrentUid = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;
  bool subjectPostIsLoading = false;

  addSubjectFunc(
      Uint8List _image,
      String degree_id,
      String semester_id,
      String title,
      String course_des,
      String course_obj,
      String learning_outc,
      String txt_reference,
      context) async {
    try {
      loadingDailog(context);
      subjectPostIsLoading = true;
      notifyListeners();

      var uniqueSubjectId = const Uuid().v1();

      String url = await StorageMethods()
          .uploadImageToStorage('subject/image/', _image, false);
      SubjectModel subjectModel = SubjectModel(
          subject_image: url,
          uid: crrentUid,
          degree_id: degree_id,
          semester_id: semester_id,
          subject_id: uniqueSubjectId,
          title: title,
          date_time: Timestamp.now(),
          course_description: course_des,
          course_objectives: course_obj,
          learning_outcomes: learning_outc,
          text_referencebooks: txt_reference);

      await _firestore
          .collection("subject")
          .doc(uniqueSubjectId)
          .set(subjectModel.toJson())
          .then((value) {
        Navigator.pop(context);
      });
    } catch (e) {
      debugPrint("Catch Exeption: $e");
      Navigator.pop(context);
    }

    subjectPostIsLoading = false;
    notifyListeners();
    Navigator.pop(context);
  }

  List Subject = [];
  String degree_id = "";
  String semester_id = "";
  String subject_id = "";

  void get_Subject(degree_title, semester_title) async {
    // semester_get.add("semester_get");
    degree_id = "";
    semester_id = "";
    subject_id = "";
    // notifyListeners();
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
              .where('title', isEqualTo: semester_title.toString())
              .get()
              .then(
            (value) async {
              value.docs.forEach((doc) {
                semester_id = doc.data()["semester_id"].toString();
                FirebaseFirestore.instance
                    .collection("subject")
                    .where('degree_id', isEqualTo: degree_id.toString())
                    .where('semester_id', isEqualTo: semester_id.toString())
                    .get()
                    .then(
                  (value) async {
                    value.docs.forEach((doc) {
                      subject_id = doc.data()["subject_id"].toString();
                      Subject.add(doc.data()["title"].toString());
                      print(Subject);
                      notifyListeners();

                      ///insert
                      // teacher_assign _model_assign = teacher_assign(uid: _current_uid.currentUser!.uid,
                      // degree_id: degree_id, semester_id: semester_id, subject_id: subject_id,
                      //  assign_id: assign_id, date_time: Timestamp.now());
                      //  _firestore.collection("teacher_assign").doc(assign_id).set(_model_assign.toJson()).then((value){

                      //  });
                    });
                  },
                );
              });
            },
          );
        });
      },
    );
  }
}
