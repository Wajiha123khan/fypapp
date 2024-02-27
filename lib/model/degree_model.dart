import 'package:cloud_firestore/cloud_firestore.dart';

class DegreeModel {
  final String uid;
  final String degree_id;
  final String title;
  final Timestamp date_time;

  const DegreeModel({
    required this.uid,
    required this.degree_id,
    required this.title,
    required this.date_time,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'degree_id': degree_id,
        'title': title,
        'date_time': date_time,
      };
  static DegreeModel fromJson(Map<String, dynamic> json) => DegreeModel(
        uid: json['uid'] ?? '',
        degree_id: json['degree_id'] ?? '',
        title: json['title'] ?? '',
        date_time: json['date_time'] ?? '',
      );
  static DegreeModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return DegreeModel(
      uid: snapshot["uid"],
      degree_id: snapshot["degree_id"],
      title: snapshot["title"],
      date_time: snapshot["date_time"],
    );
  }
}
