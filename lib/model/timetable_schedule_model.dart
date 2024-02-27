import 'package:cloud_firestore/cloud_firestore.dart';

class TimetableScheduleModel {
  final String timetable_id;
  final String degree_id;
  final String semester_id;
  final String subject_id;
  final String teacher_id;
  final String startTime;
  final String endTime;
  final String roomNo;
  final int status;
  final String scheduleDate;
  final Timestamp creationTime;

  const TimetableScheduleModel({
    required this.timetable_id,
    required this.degree_id,
    required this.semester_id,
    required this.subject_id,
    required this.teacher_id,
    required this.startTime,
    required this.endTime,
    required this.roomNo,
    required this.status,
    required this.scheduleDate,
    required this.creationTime,
  });

  Map<String, dynamic> toJson() => {
        'timetable_id': timetable_id,
        'degree_id': degree_id,
        'semester_id': semester_id,
        'subject_id': subject_id,
        'teacher_id': teacher_id,
        'startTime': startTime,
        'endTime': endTime,
        'roomNo': roomNo,
        'status': status,
        'scheduleDate': scheduleDate,
        'creationTime': creationTime,
      };
  static TimetableScheduleModel fromJson(Map<String, dynamic> json) =>
      TimetableScheduleModel(
        timetable_id: json['timetable_id'] ?? '',
        degree_id: json['degree_id'] ?? '',
        semester_id: json['semester_id'] ?? '',
        subject_id: json['subject_id'] ?? '',
        teacher_id: json['teacher_id'] ?? '',
        startTime: json['startTime'] ?? '',
        endTime: json['endTime'] ?? '',
        roomNo: json['roomNo'] ?? '',
        status: json['status'] ?? '',
        scheduleDate: json['scheduleDate'] ?? '',
        creationTime: json['creationTime'] ?? '',
      );
  static TimetableScheduleModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TimetableScheduleModel(
      timetable_id: snapshot["timetable_id"],
      degree_id: snapshot["degree_id"],
      semester_id: snapshot["semester_id"],
      subject_id: snapshot["subject_id"],
      teacher_id: snapshot["teacher_id"],
      startTime: snapshot["startTime"],
      endTime: snapshot["endTime"],
      roomNo: snapshot["roomNo"],
      status: snapshot["status"],
      scheduleDate: snapshot["scheduleDate"],
      creationTime: snapshot["creationTime"],
    );
  }
}
