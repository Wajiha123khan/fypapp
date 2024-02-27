import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  final String subject_image;
  final String uid;
  final String degree_id;
  final String semester_id;
  final String subject_id;
  final String title;
  final Timestamp date_time;
  final String course_description;
  final String course_objectives;
  final String learning_outcomes;
  final String text_referencebooks;

  const SubjectModel({
    required this.subject_image,
    required this.uid,
    required this.degree_id,
    required this.semester_id,
    required this.subject_id,
    required this.title,
    required this.date_time,
    required this.course_description,
    required this.course_objectives,
    required this.learning_outcomes,
    required this.text_referencebooks,
  });

  Map<String, dynamic> toJson() => {
        'subject_image': subject_image,
        'uid': uid,
        'degree_id': degree_id,
        'semester_id': semester_id,
        'subject_id': subject_id,
        'title': title,
        'date_time': date_time,
        'course_description': course_description,
        'course_objectives': course_objectives,
        'learning_outcomes': learning_outcomes,
        'text_referencebooks': text_referencebooks,
      };
  static SubjectModel fromJson(Map<String, dynamic> json) => SubjectModel(
        subject_image: json['subject_image'] ?? '',
        uid: json['uid'] ?? '',
        degree_id: json['degree_id'] ?? '',
        semester_id: json['semester_id'] ?? '',
        subject_id: json['subject_id'] ?? '',
        title: json['title'] ?? '',
        date_time: json['date_time'] ?? '',
        course_description: json['course_description'] ?? '',
        course_objectives: json['course_objectives'] ?? '',
        learning_outcomes: json['learning_outcomes'] ?? '',
        text_referencebooks: json['text_referencebooks'] ?? '',
      );
  static SubjectModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return SubjectModel(
      subject_image: snapshot["subject_image"],
      uid: snapshot["uid"],
      degree_id: snapshot["degree_id"],
      semester_id: snapshot["semester_id"],
      subject_id: snapshot["subject_id"],
      title: snapshot["title"],
      date_time: snapshot["date_time"],
      course_description: snapshot["course_description"],
      course_objectives: snapshot["course_objectives"],
      learning_outcomes: snapshot["learning_outcomes"],
      text_referencebooks: snapshot["text_referencebooks"],
    );
  }
}
