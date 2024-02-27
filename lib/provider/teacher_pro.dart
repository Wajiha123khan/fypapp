import 'dart:typed_data';

import 'package:classchronicaladminweb/model/teacher_assign_model.dart';
import 'package:classchronicaladminweb/model/teacher_model.dart';
import 'package:classchronicaladminweb/utils/storage_methods.dart';
import 'package:classchronicaladminweb/widget/customDialogWidget.dart';
import 'package:classchronicaladminweb/widget/customToastWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class TeacherPro with ChangeNotifier {
  final current_uid = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

//images
  Uint8List? teacherImage;
  Future pickTeacherImage() async {
    try {
      Uint8List file = await pickImage(ImageSource.gallery);

      teacherImage = file;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image:$e');
    }
  }

  void addNewTeacherFunc(
      Uint8List pickedImage,
      String firstName,
      String lastName,
      String email,
      String password,
      String qualification,
      context) async {
    try {
      loadingDailog(context);
      var uniqueTeacherId = const Uuid().v4();
      String url = await StorageMethods()
          .uploadImageToStorage('teacher_auth/image/', pickedImage, false);
      TeacherModel teacherModel = TeacherModel(
          profile: url,
          uid: uniqueTeacherId,
          first_name: firstName,
          last_name: lastName,
          email: email,
          password: password,
          aboutMe: "",
          token: "",
          qualification: qualification,
          date_time: Timestamp.now());

      _firestore
          .collection("teacher_auth")
          .doc(uniqueTeacherId)
          .set(teacherModel.toJson())
          .then((value) {
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        Navigator.pop(context);
      });
    } catch (e) {
      debugPrint("Catch Exception: $e");
    }

    Navigator.pop(context);
  }

  List teacher_name = [];
  void get_teacher_name_fun() {
    teacher_name = [];
    FirebaseFirestore.instance.collection("teacher_auth").get().then(
      (value) async {
        value.docs.forEach(
          (doc) {
            teacher_name.add(doc.data()["first_name"]);
            notifyListeners();
          },
        );
      },
    );
  }

  void assign_Subject(
      degree_id, semester_id, subject_title, teacher_value, context) {
    debugPrint(degree_id);
    debugPrint(semester_id);
    debugPrint(subject_title);
    debugPrint(teacher_value);
    String teacher_id;
    loadingDailog(context);
    int check = 0;

    _firestore
        .collection("teacher_auth")
        .where('first_name', isEqualTo: teacher_value.toString())
        .get()
        .then(
      (value) async {
        value.docs.forEach((doc) {
          _firestore
              .collection("subject")
              .where('title', isEqualTo: subject_title.toString())
              .get()
              .then(
            (value) async {
              value.docs.forEach((doc_subject) {
                String subject_id = doc_subject.data()["subject_id"].toString();
                var assign_id = Uuid().v4();
                teacher_id = doc.data()["uid"].toString();
                debugPrint(doc.data()["uid"].toString());

                _firestore
                    .collection("teacher_assign")
                    .where('degree_id', isEqualTo: degree_id.toString())
                    .where('semester_id', isEqualTo: semester_id.toString())
                    .where('subject_id', isEqualTo: subject_id.toString())
                    .where('teacher_id', isEqualTo: teacher_id.toString())
                    .get()
                    .then((value2) {
                  debugPrint(value2.docs.length.toString());
                  if (value2.docs.length == 0) {
                    check = 0;
                  } else {
                    check = 1;
                  }
                }).whenComplete(() {
                  debugPrint(check.toString());
                  debugPrint('check');
                  if (check == 1) {
        showCustomToast("Already Exist", context);

                    
                    Navigator.pop(context);
                  } else {
                    ///insert
                    TeacherAssignModel teacherAssigbModel = TeacherAssignModel(
                        uid: current_uid.currentUser!.uid,
                        degree_id: degree_id,
                        semester_id: semester_id,
                        subject_id: subject_id,
                        teacher_id: teacher_id,
                        assign_id: assign_id,
                        date_time: Timestamp.now());
                    _firestore
                        .collection("teacher_assign")
                        .doc(assign_id)
                        .set(teacherAssigbModel.toJson())
                        .then((value) {
                      Navigator.pop(context);
                    }).onError((error, stackTrace) {
                      Navigator.pop(context);
                    });
                  }
                });
              });
            },
          ).onError((error, stackTrace) {
            Navigator.pop(context);
          });
        });
      },
    ).onError((error, stackTrace) {
      Navigator.pop(context);
    });
  }

//remove assigned subject
  void removeAssignedSubject(String assignId, context) async {
    try {
      loadingDailog(context);

      _firestore
          .collection("teacher_assign")
          .doc(assignId)
          .delete()
          .then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    } catch (e) {
      Navigator.pop(context);
      Navigator.pop(context);
      debugPrint("Catch Exception: $e");
    }
  }

//for schedule
  List subject_teacher_name = [];
  void get_subject_teacher_name_fun() {
    teacher_name = [];
    FirebaseFirestore.instance
        .collection("teacher_auth")
        .where("field")
        .get()
        .then(
      (value) async {
        value.docs.forEach(
          (doc) {
            subject_teacher_name.add(doc.data()["first_name"]);
            notifyListeners();
          },
        );
      },
    );
  }
}
