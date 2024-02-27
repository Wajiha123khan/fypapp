import 'package:classchronicaladminweb/model/degree_model.dart';
import 'package:classchronicaladminweb/model/semester_model.dart';
import 'package:classchronicaladminweb/widget/customDialogWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class DegreePro with ChangeNotifier {
  final crrentUid = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool degreePostIsloading = false;

  void createDegreeFunc(String title, context) {
    loadingDailog(context);
    try {
      List semestersTilesList = [
        '1st',
        '2nd',
        '3rd',
        '4th',
        '5th',
        '6th',
        '7th',
        '8th'
      ];
      degreePostIsloading = true;
      notifyListeners();
      degreePostIsloading = false;
      var uniqueDegreeId = const Uuid().v1();
      DegreeModel degreeModel = DegreeModel(
          uid: crrentUid.currentUser!.uid,
          degree_id: uniqueDegreeId,
          title: title,
          date_time: Timestamp.now());

      _firestore
          .collection("degree")
          .doc(uniqueDegreeId)
          .set(degreeModel.toJson())
          .then((value) {
        for (int i = 0; i < 8; i++) {
          var uniqueSemesterId = const Uuid().v1();
          SemesterModel semesterModel = SemesterModel(
              uid: crrentUid.currentUser!.uid,
              degree_id: uniqueDegreeId,
              semester_id: uniqueSemesterId,
              title: semestersTilesList[i],
              index: i + 1,
              date_time: Timestamp.now());

          _firestore
              .collection("semester")
              .doc(uniqueSemesterId)
              .set(semesterModel.toJson())
              .then((value) {
            Navigator.pop(context);
          });
        }
      });
    } catch (e) {
      debugPrint("Catch Execption: $e");
    }

    degreePostIsloading = false;
    notifyListeners();
  }

  // Stream<List<DegreeModel>> filter_degree_s() => FirebaseFirestore.instance
  //     .collection('degree')
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs
  //         .map((document) => DegreeModel.fromJson(document.data()))
  //         .toList());

  List degree_get = [];
  bool get_degree_isloading = false;
  int value1 = 0;
  Get_degree_fun() async {
    degree_get = [];
    get_degree_isloading = true;
    value1 = 0;
    // notifyListeners();
    FirebaseFirestore.instance.collection("degree").get().then(
      (value) async {
        value.docs.forEach((doc) {
          degree_get.add(doc.data()["title"]);
          value1 = 1;
          notifyListeners();
          print(value1);
        });
      },
    );
  }
}
