import 'package:cloud_firestore/cloud_firestore.dart';

class SemesterModel {
  final String uid;
  final String degree_id;
  final String semester_id;
  final String title;
  final int index;
  final Timestamp date_time;

  const SemesterModel({
    required this.uid,
    required this.degree_id,
    required this.semester_id,
    required this.title,
    required this.index,
    required this.date_time,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'degree_id': degree_id,
        'semester_id': semester_id,
        'title': title,
        'index': index,
        'date_time': date_time,
      };
  static SemesterModel fromJson(Map<String, dynamic> json) => SemesterModel(
        uid: json['uid'] ?? '',
        degree_id: json['degree_id'] ?? '',
        title: json['title'] ?? '',
        semester_id: json['semester_id'] ?? '',
        index: json['index'] ?? '',
        date_time: json['date_time'] ?? '',
      );
  static SemesterModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return SemesterModel(
      uid: snapshot["uid"],
      degree_id: snapshot["degree_id"],
      semester_id: snapshot["semester_id"],
      title: snapshot["title"],
      index: snapshot["index"],
      date_time: snapshot["date_time"],
    );
  }
}
