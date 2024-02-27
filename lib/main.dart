import 'package:classchronicaladminweb/dashboard/config/Sidemenupro.dart';
import 'package:classchronicaladminweb/dashboard/dashboard.dart';
import 'package:classchronicaladminweb/provider/degree_pro.dart';
import 'package:classchronicaladminweb/provider/global_pro.dart';
import 'package:classchronicaladminweb/provider/notification_pro.dart';
import 'package:classchronicaladminweb/provider/schedule_pro.dart';
import 'package:classchronicaladminweb/provider/semester_pro.dart';
import 'package:classchronicaladminweb/provider/student_pro.dart';
import 'package:classchronicaladminweb/provider/subject_pro.dart';
import 'package:classchronicaladminweb/provider/teacher_pro.dart';
import 'package:classchronicaladminweb/reused/fun.dart';
import 'package:classchronicaladminweb/views/auth/LoginScreen.dart';
import 'package:classchronicaladminweb/views/auth/pro/authpro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'dashboard/style/theme_colors.dart';

void main() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC092bP3PkHfs2QubaNbN1qlx8r00G_1WE",
      authDomain: "class-chronincal.firebaseapp.com",
      projectId: "class-chronincal",
      storageBucket: "class-chronincal.appspot.com",
      messagingSenderId: "114872867542",
      appId: "1:114872867542:web:f6d71b34160243c2a00777",
      measurementId: "G-9JXZ4CWC1L",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<authpro>(create: (_) => authpro()),
        ChangeNotifierProvider<ReusedPro>(create: (_) => ReusedPro()),
        ChangeNotifierProvider<Sidemenupro>(create: (_) => Sidemenupro()),
        ChangeNotifierProvider<DegreePro>(create: (_) => DegreePro()),
        ChangeNotifierProvider<SubjectPro>(create: (_) => SubjectPro()),
        ChangeNotifierProvider<TeacherPro>(create: (_) => TeacherPro()),
        ChangeNotifierProvider<SemesterPro>(create: (_) => SemesterPro()),
        ChangeNotifierProvider<SchedulePro>(create: (_) => SchedulePro()),
        ChangeNotifierProvider<StudentPro>(create: (_) => StudentPro()),
        ChangeNotifierProvider<GlobalPro>(create: (_) => GlobalPro()),
        //FOR NOTIFICATIONS
        ChangeNotifierProvider<NotificationPro>(
            create: (_) => NotificationPro()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Class Chronical Admin Web',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: themegreycolor,
        ),
        home: FirebaseAuth.instance.currentUser != null
            ? Dashboard()
            : const LoginScreen(),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
      ),
    );
  }
}
