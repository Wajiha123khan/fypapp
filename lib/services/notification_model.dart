import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationM {
  final String notification_id;
  final String degree_id;

  final String semester_id;
  final String subject_id;

  final Map data;
  final String teacher_id;

  final int status;
  final Timestamp dateTime;
  const NotificationM({
    required this.notification_id,
    required this.degree_id,
    required this.semester_id,
    required this.subject_id,
    required this.data,
    required this.teacher_id,
    required this.status,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'notification_id': notification_id,
        'degree_id': degree_id,
        'semester_id': semester_id,
        'subject_id': subject_id,
        'data': data,
        'teacher_id': teacher_id,
        'status': status,
        'dateTime': dateTime,
      };
  static NotificationM fromJson(Map<String, dynamic> json) => NotificationM(
        notification_id: json['notification_id'] ?? '',
        degree_id: json['degree_id'] ?? '',
        semester_id: json['semester_id'] ?? '',
        subject_id: json['subject_id'] ?? '',
        data: json['data'] ?? '',
        teacher_id: json['teacher_id'] ?? '',
        status: json['status'] ?? '',
        dateTime: json['dateTime'] ?? '',
      );
  static NotificationM fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return NotificationM(
      notification_id: snapshot["notification_id"],
      degree_id: snapshot["degree_id"],
      semester_id: snapshot["semester_id"],
      subject_id: snapshot["subject_id"],
      data: snapshot["data"],
      teacher_id: snapshot["teacher_id"],
      status: snapshot["status"],
      dateTime: snapshot["dateTime"],
    );
  }
}
