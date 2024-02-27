
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../reused/firebase/firebase.dart';

class GlobalPro with ChangeNotifier {
  List<String> totalStudents = [];
  List<String> totalTeachers = [];
  List<String> totalDegrees = [];
  List<String> totalSubjects = [];
  List<String> timetableSchedules = [];

  fetchDashboardItems() async {
    try {
      totalStudents = [];
      totalTeachers = [];
      totalDegrees = [];
      totalSubjects = [];
      timetableSchedules = [];

      //fetching users
      var studentSnapshot = await firebase.collection("student_auth").get();
      if (studentSnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> documents = studentSnapshot.docs;
        totalStudents = documents.map((doc) => doc.id).toList();
        debugPrint("totalStudents: $totalStudents");
        debugPrint("documents: $documents");
        notifyListeners();
      }

      //fetching teachers
      var teacherSnapshot = await firebase.collection("teacher_auth").get();

      if (teacherSnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> documents = teacherSnapshot.docs;
        totalTeachers = documents.map((doc) => doc.id).toList();
        debugPrint("totalTeachers: $totalTeachers");
        notifyListeners();
      }
      //fetching degree
      var degreeSnapshot = await firebase.collection("degree").get();
      if (degreeSnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> documents = degreeSnapshot.docs;
        totalDegrees = documents.map((doc) => doc.id).toList();
        notifyListeners();
      }

      //fetching subjects
      var subjectSnapshot = await firebase.collection("subject").get();
      if (subjectSnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> documents = subjectSnapshot.docs;
        totalSubjects = documents.map((doc) => doc.id).toList();
        notifyListeners();
      }

      //fetching queriess
      var timetableSnapshot =
          await firebase.collection("subject_timetable").get();
      if (timetableSnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> documents = timetableSnapshot.docs;
        timetableSchedules = documents.map((doc) => doc.id).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Catch Exception: $e");
    }
  }
}
