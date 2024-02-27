import 'package:cloud_firestore/cloud_firestore.dart';

class HelpCenter_Model {
  final String query_id;
  final String uid;
  final String username;

  final String subject;
  final String question;
  final Timestamp date_time;

  const HelpCenter_Model({
    required this.query_id,
    required this.uid,
    required this.username,
    required this.subject,
    required this.question,
    required this.date_time,
  });

  Map<String, dynamic> toJson() => {
        'query_id': query_id,
        'uid': uid,
        'username': username,
        'subject': subject,
        'question': question,
        'date_time': date_time,
      };
  static HelpCenter_Model fromJson(Map<String, dynamic> json) =>
      HelpCenter_Model(
        query_id: json['query_id'] ?? '',
        uid: json['uid'] ?? '',
        username: json['username'] ?? '',
        subject: json['subject'] ?? '',
        question: json['question'] ?? '',
        date_time: json['date_time'] ?? '',
      );
  static HelpCenter_Model fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return HelpCenter_Model(
      query_id: snapshot["query_id"],
      uid: snapshot["uid"],
      username: snapshot["username"],
      subject: snapshot["subject"],
      question: snapshot["question"],
      date_time: snapshot["date_time"],
    );
  }
}
