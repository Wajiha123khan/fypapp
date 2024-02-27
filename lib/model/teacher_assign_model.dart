import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherAssignModel {
  final String uid;
  final String degree_id;
  final String semester_id;
  final String subject_id;
  final String teacher_id;
  final String assign_id;
  final Timestamp date_time;

  const TeacherAssignModel({
    required this.uid,
    required this.degree_id,
    required this.semester_id,
    required this.subject_id,
    required this.teacher_id,
    required this.assign_id,
    required this.date_time,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'degree_id': degree_id,
        'semester_id': semester_id,
        'subject_id': subject_id,
        'teacher_id': teacher_id,
        'assign_id': assign_id,
        'date_time': date_time,
      };
  static TeacherAssignModel fromJson(Map<String, dynamic> json) =>
      TeacherAssignModel(
        uid: json['uid'] ?? '',
        degree_id: json['degree_id'] ?? '',
        semester_id: json['semester_id'] ?? '',
        subject_id: json['subject_id'] ?? '',
        teacher_id: json['teacher_id'] ?? '',
        assign_id: json['assign_id'] ?? '',
        date_time: json['date_time'] ?? '',
      );
  static TeacherAssignModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TeacherAssignModel(
      uid: snapshot["uid"],
      degree_id: snapshot["degree_id"],
      semester_id: snapshot["semester_id"],
      subject_id: snapshot["subject_id"],
      teacher_id: snapshot["teacher_id"],
      assign_id: snapshot["assign_id"],
      date_time: snapshot["date_time"],
    );
  }
}
