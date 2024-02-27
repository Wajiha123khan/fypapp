import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String uid;
  final String name;
  final String surname;
  final String roll_no;
  final String email;
  final String phone_num;
  final String cnic_beform;
  final String password;
  final String address;
  final String gender;
  final String degree_id;
  final String semester_id;
  final String father_name;
  final String mother_name;
  final String p_phone_num;
  final String p_cnic_beform;
  final String p_address;
  final int type;
  final Timestamp date_time;
  final String profile_image;
  final String doc;
  final String token;
  const StudentModel({
    required this.uid,
    required this.name,
    required this.surname,
    required this.roll_no,
    required this.email,
    required this.phone_num,
    required this.cnic_beform,
    required this.password,
    required this.address,
    required this.gender,
    required this.degree_id,
    required this.semester_id,
    required this.father_name,
    required this.mother_name,
    required this.p_phone_num,
    required this.p_cnic_beform,
    required this.p_address,
    required this.type,
    required this.date_time,
    required this.profile_image,
    required this.doc,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'surname': surname,
        'roll_no': roll_no,
        'email': email,
        'phone_num': phone_num,
        'cnic_beform': cnic_beform,
        'password': password,
        'address': address,
        'gender': gender,
        'degree_id': degree_id,
        'semester_id': semester_id,
        'father_name': father_name,
        'mother_name': mother_name,
        'p_phone_num': p_phone_num,
        'p_cnic_beform': p_cnic_beform,
        'p_address': p_address,
        'type': type,
        'date_time': date_time,
        'profile_image': profile_image,
        'doc': doc,
        'token': token,
      };
  static StudentModel fromJson(Map<String, dynamic> json) => StudentModel(
        uid: json['uid'] ?? '',
        name: json['name'] ?? '',
        surname: json['surname'] ?? '',
        roll_no: json['roll_no'] ?? '',
        email: json['email'] ?? '',
        phone_num: json['phone_num'] ?? '',
        cnic_beform: json['cnic_beform'] ?? '',
        password: json['password'] ?? '',
        address: json['address'] ?? '',
        gender: json['gender'] ?? '',
        degree_id: json['degree_id'] ?? '',
        semester_id: json['semester_id'] ?? '',
        father_name: json['father_name'] ?? '',
        mother_name: json['mother_name'] ?? '',
        p_phone_num: json['p_phone_num'] ?? '',
        p_cnic_beform: json['p_cnic_beform'] ?? '',
        p_address: json['p_address'] ?? '',
        type: json['type'] ?? '',
        date_time: json['date_time'] ?? '',
        profile_image: json['profile_image'] ?? '',
        doc: json['doc'] ?? '',
        token: json['token'] ?? '',
      );
  static StudentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return StudentModel(
      uid: snapshot["uid"],
      name: snapshot["name"],
      surname: snapshot["surname"],
      roll_no: snapshot["roll_no"],
      email: snapshot["email"],
      phone_num: snapshot["phone_num"],
      cnic_beform: snapshot["cnic_beform"],
      password: snapshot["password"],
      address: snapshot["address"],
      gender: snapshot["gender"],
      degree_id: snapshot["degree_id"],
      semester_id: snapshot["semester_id"],
      father_name: snapshot["father_name"],
      mother_name: snapshot["mother_name"],
      p_phone_num: snapshot["p_phone_num"],
      p_cnic_beform: snapshot["p_cnic_beform"],
      p_address: snapshot["p_address"],
      type: snapshot["type"],
      date_time: snapshot["date_time"],
      profile_image: snapshot["profile_image"],
      doc: snapshot["doc"],
      token: snapshot["token"],
    );
  }
}
