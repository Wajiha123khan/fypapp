import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final mycurrentuid = FirebaseAuth.instance.currentUser!.uid;
final firebase = FirebaseFirestore.instance;

class Coll {
  final auth = "auth";
  final adminauth = "admin-auth";
}
