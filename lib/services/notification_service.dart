import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;
import 'package:app_settings/app_settings.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {
      AppSettings.openNotificationSettings();
      // AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitilization =
        const AndroidInitializationSettings("@mipmap/launcher_icon");
    var iosInitilizationSettings = const DarwinInitializationSettings();

    var initialzationSetting = InitializationSettings(
      android: androidInitilization,
      iOS: iosInitilizationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initialzationSetting,
        onDidReceiveNotificationResponse: (payload) {
      handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) {
    log("firebaseInit");
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        debugPrint(
            "event message title: ${event.notification!.title.toString()}");
        debugPrint(
            "event message body: ${event.notification!.body.toString()}");
        debugPrint("event message data: ${event.data.toString()}");
      }
      if (Platform.isAndroid) {
        log("initLocalNotification");
        initLocalNotification(context, event);
        showNotification(event);
      } else {
        showNotification(event);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    debugPrint("showNotification ***********************************");

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        "com.kashmir.my_kashmir", "High Importance Notifications",
        importance: Importance.max,
        description: 'This channel is used for important notifications.');
    AndroidNotificationDetails androidNotificationDetails;
    // if (message.data['image'] == "" || message.data['image'] == null) {
    androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    // } else {
    //   String image = "";
    //   await urlToFile(
    //     message.data['image'],
    //   ).then((value) {
    //     image = value;
    //   });

    //   androidNotificationDetails = AndroidNotificationDetails(
    //     channel.id.toString(),
    //     channel.name.toString(),
    //     channelDescription: 'your channel description',
    //     importance: Importance.high,
    //     priority: Priority.high,
    //     ticker: 'ticker',
    //     styleInformation: BigPictureStyleInformation(
    //       FilePathAndroidBitmap(image),
    //       hideExpandedLargeIcon: false,
    //     ),
    //   );
    // }

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    try {
      Future.delayed(
        Duration.zero,
        () {
          _flutterLocalNotificationsPlugin.show(
            0,
            message.notification!.title.toString(),
            message.notification!.body.toString(),
            notificationDetails,
          );
        },
      );
    } catch (e) {
      debugPrint("exception **********************$e");
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    debugPrint("token: $token");
    return token!;
  }

  void iSTokenRefreh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        debugPrint("refresh");
      }
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
//terminated

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // ignore: use_build_context_synchronously
      handleMessage(context, initialMessage);
    }

    //background

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  handleMessage(BuildContext context, RemoteMessage message) async {
    log("message:*********");
    log(message.notification!.body.toString());
    log(message.data.toString());

    if (message.data['type'] == 'Register') {
      // context.pushNamed("splash");
    } else if (message.data['type'] == 'Order') {
      // context.replaceNamed('bottomNavBar', queryParams: {
      //   'selectedTab': '2',
      // });
    } else {}
  }

  Future<String> urlToFile(String imageUrl) async {
    var rng = math.Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath${rng.nextInt(100)}.png');
    http.Response response = await http.get(Uri.parse(imageUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }
}
