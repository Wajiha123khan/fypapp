import 'package:classchronicaladminweb/model/timetable_schedule_model.dart';
import 'package:classchronicaladminweb/widget/customDialogWidget.dart';
import 'package:classchronicaladminweb/widget/customToastWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SchedulePro with ChangeNotifier {
  final firestore = FirebaseFirestore.instance;

  List teacherList = [];
  String degree_id = "";
  String semester_id = "";
  String subject_id = "";
  String teacher_id = "";

  void get_teacher(degree_title, semester_title, subject_title) async {
    debugPrint("degree_title: $degree_title");
    debugPrint("semester_title: $semester_title");
    debugPrint("subject_title: $subject_title");
    teacherList = [];
    degree_id = "";
    semester_id = "";
    subject_id = "";
    teacher_id = "";

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
                    .where('title', isEqualTo: subject_title.toString())
                    .get()
                    .then(
                  (value) async {
                    value.docs.forEach((doc) {
                      subject_id = doc.data()["subject_id"].toString();
                      // Subject.add(doc.data()["title"].toString());
                      print("subject_id: $subject_id");
                      notifyListeners();
                    });
                    //fetching assignedteacher uid from "teacher_assign" collection
                    Future.delayed(Duration(seconds: 2));
                    await FirebaseFirestore.instance
                        .collection("teacher_assign")
                        .where('degree_id', isEqualTo: degree_id.toString())
                        .where('semester_id', isEqualTo: semester_id.toString())
                        .where('subject_id', isEqualTo: subject_id)
                        .get()
                        .then((value) async {
                      value.docs.forEach((doc) {
                        teacher_id = doc.data()["teacher_id"].toString();
                        print("teacher_id: $teacher_id");

                        notifyListeners();
                      });

                      //fetching teacher name from teacher_auth collection
                      Future.delayed(const Duration(seconds: 2));

                      await FirebaseFirestore.instance
                          .collection("teacher_auth")
                          .doc(teacher_id)
                          .get()
                          .then((value) {
                        if (value.exists) {
                          teacherList
                              .add(value.data()?["first_name"].toString());
                          notifyListeners();
                        }
                      });
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

//schedule timtable
  createSubjectScheduleFunc(
      degree_id,
      semester_id,
      subject_id,
      teacher_id,
      String startTime,
      String endTime,
      String scheduleDate,
      String roomNo,
      context) {
    try {
      loadingDailog(context);
      var uniqueTimetableId = const Uuid().v4();
      TimetableScheduleModel timetableModel = TimetableScheduleModel(
          timetable_id: uniqueTimetableId,
          degree_id: degree_id,
          semester_id: semester_id,
          subject_id: subject_id,
          teacher_id: teacher_id,
          startTime: startTime,
          endTime: endTime,
          roomNo: roomNo,
          status: 1, // 0 - active --- 1 - inactive
          scheduleDate: scheduleDate,
          creationTime: Timestamp.now());

      firestore
          .collection("subject_timetable")
          .doc(uniqueTimetableId)
          .set(timetableModel.toJson())
          .then((value) {
            customToast("Timetable added Successfuly", context);
        // customSuccessfulToast(
        //     "Timetable", "Timetable added Successfuly.", context);

        Navigator.pop(context);
      }).onError((error, stackTrace) {
        Navigator.pop(context);

        debugPrint("Error: $error");
      });
    } catch (e) {
      Navigator.pop(context);

      debugPrint("Catch Exception: $e");
    }
  }

//timetable status update func
  timetableStatusUpdateFunc(int value, String timetableId) async {
    try {
      await firestore
          .collection("subject_timetable")
          .doc(timetableId)
          .update({'status': value});
    } catch (e) {
      debugPrint("Exception Error: $e");
    }
  }

//timetable delete func
  timetableDeleteFunc(timetableId, context) {
    try {
      loadingDailog(context);

      firestore
          .collection("subject_timetable")
          .doc(timetableId)
          .delete()
          .then((value) {
            customToast("Timetable Deleted Successfuly", context);
     

        Navigator.pop(context);
      }).onError((error, stackTrace) {
        Navigator.pop(context);

        debugPrint("Error: $error");
      });
    } catch (e) {
      Navigator.pop(context);

      debugPrint("Catch Exception: $e");
    }
    Navigator.pop(context);
  }
}
