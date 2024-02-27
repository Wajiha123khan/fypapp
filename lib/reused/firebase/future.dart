
import 'firebase.dart';

String profileImage = "";
Future<String> userimageget(String uid) async {
  var collection = firebase.collection(Coll().auth);
  var docSnapshot = await collection.doc(uid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    profileImage = data['image'];
  } else {}
  return profileImage;
}

String username = "";
Future<String> usernameget(String uid) async {
  var collection = firebase.collection(Coll().auth);
  var docSnapshot = await collection.doc(uid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    username = data['name'];
  } else {}
  return username;
}

String useremail = "";
Future<String> useremailget(String uid) async {
  var collection = firebase.collection(Coll().auth);
  var docSnapshot = await collection.doc(uid).get();
  if (docSnapshot.exists) {
    Map<String, dynamic> data = docSnapshot.data()!;
    useremail = data['email'];
  } else {}
  return useremail;
}
