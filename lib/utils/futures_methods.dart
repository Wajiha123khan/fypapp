import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
String degree_title = "";
Future<String> degree_name_get(String degree_id) async {
  var collection = FirebaseFirestore.instance.collection("degree");
  var docSnapshot = await collection.doc(degree_id).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    degree_title = data['title'];
  } else {}
  return degree_title;
}

String semester_title = "";
Future<String> semester_name_get(String semester_id) async {
  var collection = FirebaseFirestore.instance.collection("semester");
  var docSnapshot = await collection.doc(semester_id).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    semester_title = data['title'];
  } else {}
  return semester_title;
}

Future<String> student_name_get(String student_id) async {
  var collection = FirebaseFirestore.instance.collection("student_auth");
  var docSnapshot = await collection.doc(student_id).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    semester_title = data['name'];
  } else {}
  return semester_title;
}

Future<String> student_Surnname_get(String student_id) async {
  var collection = FirebaseFirestore.instance.collection("student_auth");
  var docSnapshot = await collection.doc(student_id).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    semester_title = data['surname'];
  } else {}
  return semester_title;
}

String teacher_name = "";
Future<String> teacher_name_get(String teacher_id) async {
  var collection = FirebaseFirestore.instance.collection("teacher_auth");
  var docSnapshot = await collection.doc(teacher_id).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    teacher_name = data['first_name'] + " " + data['last_name'];
  } else {}
  return teacher_name;
}

String sunject_name = "";
Future<String> sunject_name_get(String teacher_id) async {
  var collection = FirebaseFirestore.instance.collection("subject");
  var docSnapshot = await collection.doc(teacher_id).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    sunject_name = data['title'];
  } else {}
  return sunject_name;
}
