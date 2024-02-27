import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherModel {
  final String profile;
  final String uid;
  final String first_name;
  final String last_name;
  final String email;
  final String password;
  final String qualification;
  final String aboutMe;
  final Timestamp date_time;
  final String token;

  const TeacherModel({
    required this.profile,
    required this.uid,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.password,
    required this.qualification,
    required this.aboutMe,
    required this.token,
    required this.date_time,
  });

  Map<String, dynamic> toJson() => {
        'profile': profile,
        'uid': uid,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'password': password,
        'qualification': qualification,
        'aboutMe': aboutMe,
        'token': token,
        'date_time': date_time,
      };
  static TeacherModel fromJson(Map<String, dynamic> json) => TeacherModel(
        profile: json['profile'] ?? '',
        uid: json['uid'] ?? '',
        first_name: json['first_name'] ?? '',
        last_name: json['last_name'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        qualification: json['qualification'] ?? '',
        aboutMe: json['aboutMe'] ?? '',
        token: json['token'] ?? '',
        date_time: json['date_time'] ?? '',
      );

  static TeacherModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TeacherModel(
      profile: snapshot["profile"],
      uid: snapshot["uid"],
      first_name: snapshot["first_name"],
      last_name: snapshot["last_name"],
      email: snapshot["email"],
      password: snapshot["password"],
      qualification: snapshot["qualification"],
      aboutMe: snapshot["aboutMe"],
      token: snapshot["token"],
      date_time: snapshot["date_time"],
    );
  }
}
