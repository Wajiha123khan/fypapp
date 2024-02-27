import 'package:cloud_firestore/cloud_firestore.dart';

class User_Model {
  final String uid;
  final String profile_image;
  final String full_name;
  final String email;
  final String phone_number;
  final String password;
  final int gender;
  final int status;
  final Timestamp date_time;

  const User_Model({
    required this.uid,
    required this.profile_image,
    required this.full_name,
    required this.email,
    required this.phone_number,
    required this.password,
    required this.gender,
    required this.status,
    required this.date_time,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'profile_image': profile_image,
        'full_name': full_name,
        'email': email,
        'phone_number': phone_number,
        'password': password,
        'gender': gender,
        'status': status,
        'date_time': date_time,
      };
  static User_Model fromJson(Map<String, dynamic> json) => User_Model(
        uid: json['uid'] ?? '',
        profile_image: json['profile_image'] ?? '',
        full_name: json['full_name'] ?? '',
        email: json['email'] ?? '',
        phone_number: json['phone_number'] ?? '',
        password: json['password'] ?? '',
        gender: json['gender'] ?? '',
        status: json['status'] ?? '',
        date_time: json['date_time'] ?? '',
      );
  static User_Model fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User_Model(
      uid: snapshot["uid"],
      profile_image: snapshot["profile_image"],
      full_name: snapshot["full_name"],
      email: snapshot["email"],
      phone_number: snapshot["phone_number"],
      password: snapshot["password"],
      gender: snapshot["gender"],
      status: snapshot["status"],
      date_time: snapshot["date_time"],
    );
  }
}
