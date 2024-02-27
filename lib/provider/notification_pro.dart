import 'dart:convert';

import 'package:classchronicaladminweb/services/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class NotificationPro with ChangeNotifier {
  final auth = FirebaseAuth.instance.currentUser;
  final firebase = FirebaseFirestore.instance;

  void SendMessage(msg, data) async {
    print("SendMessage");
    firebase.collection("auth").doc(auth!.uid).get().then((value) {
      print("sendNotification");
      print(value.data());
      sendNotification(
        value.data()!['name'],
        msg,
        {},
        value.data()!['token'],
      );
    });
  }

  void sendNotification(title, des, data, token) async {
    var body = {
      // 'to': token,
      'to':
          "ccbCTEzZRhmrR-5mf9_AHI:APA91bETZf1tiurYN1uqNnSRpNl4Ta8v7fvpPBm9h-dYtWZZmF0D2Ua09eKy5DDY0mlsNislthfiXHDPJwCFWgZTgE29Ihs-U4z0HS_RUVUyZU0ddom2WMUu_9j4Jy7kw4jx2c7bPIiD",
      // "ccbCTEzZRhmrR-5mf9_AHI:APA91bETZf1tiurYN1uqNnSRpNl4Ta8v7fvpPBm9h-dYtWZZmF0D2Ua09eKy5DDY0mlsNislthfiXHDPJwCFWgZTgE29Ihs-U4z0HS_RUVUyZU0ddom2WMUu_9j4Jy7kw4jx2c7bPIiD",

      'priority': 'high',
      'notification': {
        'title': title,
        'body': des,
      },
      'android': {
        'notification': {
          'channel_id': 'com.mrhassyy.classchronicalapp',
        },
      },
      'data': data,
    };

    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // 'Authorization':
          //     'key=AAAAPGT3-7c:APA91bEv8NtQJbttP_-mpVa7jc3IEyK66Aw1jQUy2phjh9FmPSfDUXXjVn7YUare4ltOE43fU_t1-8xw4Szo4FWE3OHc1UgtzCBJU3K71dxBzpHWJrP91WQVyLtuFk22LnS0utohBnoV',
          'Authorization':
              'key=AAAAGr702tY:APA91bGkGiW3nX8xpE6hSzreKP1DnapoNbiSEzHlL4tENd08fbrqkKRQfDnmM6RkvSFmolAZEC_FoNtAV3NbufPioFtfKzcyrib_sH6_OQPggRb22-SbGfMNl8_7oHquo_ZRlbg3gZ8P',
        });
  }

  void sendNotificationTwo() async {
    var data = {
      'to':
          "ccbCTEzZRhmrR-5mf9_AHI:APA91bETZf1tiurYN1uqNnSRpNl4Ta8v7fvpPBm9h-dYtWZZmF0D2Ua09eKy5DDY0mlsNislthfiXHDPJwCFWgZTgE29Ihs-U4z0HS_RUVUyZU0ddom2WMUu_9j4Jy7kw4jx2c7bPIiD",
      'notification': {
        'title': 'Asif',
        'body': 'Subscribe to my channel',
        "sound": "jetsons_doorbell.mp3"
      },
      'android': {
        'notification': {
          'notification_count': 23,
        },
      },
      'data': {'type': 'msj', 'id': 'Asif Taj'}
    };

    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAGr702tY:APA91bGlSmydZSIMtkFLoioxu-1rQhVpx-BcBKnbvABMIr_7I9PseRA3lCJSRflOOfiSKgEQkR0tdHFUBD9eLOd1l9n_NaExxcNJKxUmJfc5EX90PiDfxO_Lmy6nGv96wr46B990W-X1'
        }).then((value) {
      if (kDebugMode) {
        print(value.body.toString());
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    });
  }

  sendNotificationbulk(
    title,
    des,
    Map data,
    List token,
    List uidlist,
  ) async {
    print(title);
    print(des);
    print(data);
    print(token);
    print(uidlist);
    // savefirebase(
    //   title,
    //   des,
    //   data,
    //   uidlist,
    // );
    for (int i = 0; i < token.length; i++) {
      var body = {
        'to': token[i],
        'priority': 'high',
        'notification': {
          'title': title,
          'body': des,
        },
        'android': {
          'notification': {
            'channel_id': 'com.example.mended_new',
          },
        },
        'data': data,
      };

      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization':
                'key=AAAAPGT3-7c:APA91bEv8NtQJbttP_-mpVa7jc3IEyK66Aw1jQUy2phjh9FmPSfDUXXjVn7YUare4ltOE43fU_t1-8xw4Szo4FWE3OHc1UgtzCBJU3K71dxBzpHWJrP91WQVyLtuFk22LnS0utohBnoV',
          }).then((value) {
        print("value.toString()");
        print(value.body.toString());
      });
    }
  }

  // void savefirebase(title, description, Map data, List receiverId) {
  //   var notifyId = const Uuid().v4();
  //   NotificationM model = NotificationM(
  //     senderId: auth!.uid,
  //     notifyId: notifyId,
  //     title: title,
  //     description: description,
  //     data: data,
  //     receiverId: receiverId,
  //     seenId: [],
  //     status: 0,
  //     dateTime: Timestamp.now(),
  //   );
  //   FirebaseFirestore.instance.collection("notification").doc(notifyId).set(
  //         model.toJson(),
  //       );
  // }

  void addseen(notifyId) {
    FirebaseFirestore.instance.collection("notification").doc(notifyId).update({
      'seenId': FieldValue.arrayUnion([auth!.uid])
    });
  }

  ///final
  String subjectName = "";
  Future<void> sendNotificationToMultipleDevices(
      List<String> deviceTokens,
      String degreeId,
      String semesterId,
      String subjectId,
      String teacherId,
      String startEndTime,
      String scheduleDate,
      String roomNo) async {
    await FirebaseFirestore.instance
        .collection("subject")
        .doc(subjectId)
        .get()
        .then((value) {
      if (value.exists) {
        subjectName = value.data()?["title"];
        notifyListeners();
      }
    });
    var data = {
      'registration_ids': deviceTokens,
      'notification': {
        'title': subjectName,
        'body': 'Your Class will be on $startEndTime at $roomNo',
        "sound": "jetsons_doorbell.mp3"
      },
      'android': {
        'notification': {
          'notification_count': 23,
        },
      },
      'data': {'type': 'msj', 'id': 'Hassaan Ali'}
    };

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'key=AAAAGr702tY:APA91bGlSmydZSIMtkFLoioxu-1rQhVpx-BcBKnbvABMIr_7I9PseRA3lCJSRflOOfiSKgEQkR0tdHFUBD9eLOd1l9n_NaExxcNJKxUmJfc5EX90PiDfxO_Lmy6nGv96wr46B990W-X1'
      },
    ).then((value) {
      debugPrint(value.body.toString());
      saveNotificationHistoryFunc(
        degreeId,
        semesterId,
        subjectId,
        teacherId,
        {
          'subject': subjectName,
          'roomNo': roomNo,
          'startEndTime': startEndTime,
          'scheduleDate': scheduleDate
        },
      );
    }).onError((error, stackTrace) {
      debugPrint("error: $error");
    });
  }

  //saving it to firebase
  Future<void> saveNotificationHistoryFunc(
    String degreeId,
    String semester_id,
    String subject_id,
    String teacher_id,
    Map data,
  ) async {
    var notifyId = const Uuid().v4();
    NotificationM model = NotificationM(
      notification_id: notifyId,
      degree_id: degreeId,
      semester_id: semester_id,
      subject_id: subject_id,
      data: data,
      teacher_id: teacher_id,
      status: 0,
      dateTime: Timestamp.now(),
    );

    await FirebaseFirestore.instance
        .collection("notification")
        .doc(notifyId)
        .set(
          model.toJson(),
        )
        .then((value) {
      debugPrint("Done History saved");
    });
  }
}
