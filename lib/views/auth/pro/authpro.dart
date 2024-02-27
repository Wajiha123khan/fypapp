import 'package:classchronicaladminweb/widget/customToastWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../dashboard/dashboard.dart';
import '../../../reused/firebase/firebase.dart';
import '../../../reused/fun.dart';
import '../../../navigator/navigator.dart';

class authpro with ChangeNotifier {
  void loginfun(email, password, context) async {
    final post = Provider.of<ReusedPro>(context, listen: false);
    post.showloadingoverlay(context);
    print(email);
    print(password);
    var coll =
        firebase.collection("admin").where('email', isEqualTo: email).where(
              'password',
              isEqualTo: password,
            );

    coll.get().then((value) async {
      if (value.docs.isEmpty) {
        showCustomToast("Please enter the correct email and password", context);
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.toString(), password: password.toString());
        RouteNavigator.pushandremoveroute(context, Dashboard());
      }
    });
    await Future.delayed(const Duration(seconds: 1));
    post.removeoverlay(context);
  }
}
