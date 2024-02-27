import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:classchronicaladminweb/dashboard/config/Sidemenupro.dart';
import 'package:classchronicaladminweb/navigator/navigator.dart';
import 'package:classchronicaladminweb/views/auth/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../config/size_config.dart';
import '../style/theme_colors.dart';

// ignore: must_be_immutable
class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  var title = [
    'Dashboard',
    'Degree\'s',
    'Semester\'s',
    'Subject\'s',
    'Schedule\'s',
    'Students\'s',
    'Teachers\'s',
    'Teachers Assign\'s',
    'Logout',
  ];

  var route = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  List<Icon> icon = [
    const Icon(CupertinoIcons.home, color: themewhitecolor),
    const Icon(CupertinoIcons.profile_circled, color: themewhitecolor),
    const Icon(CupertinoIcons.placemark, color: themewhitecolor),
    const Icon(CupertinoIcons.drop_triangle, color: themewhitecolor),
    const Icon(CupertinoIcons.time, color: themewhitecolor),
    const Icon(CupertinoIcons.news_solid, color: themewhitecolor),
    const Icon(CupertinoIcons.news_solid, color: themewhitecolor),
    const Icon(CupertinoIcons.person_add_solid, color: themewhitecolor),
    const Icon(CupertinoIcons.return_icon, color: themewhitecolor),
  ];

  List<Icon> icon_color = [
    const Icon(
      CupertinoIcons.home,
      color: themewhitecolor,
    ),
    const Icon(CupertinoIcons.profile_circled, color: themewhitecolor),
    const Icon(CupertinoIcons.placemark_fill, color: themewhitecolor),
    const Icon(CupertinoIcons.drop_triangle_fill, color: themewhitecolor),
    const Icon(CupertinoIcons.time_solid, color: themewhitecolor),
    const Icon(CupertinoIcons.news_solid, color: themewhitecolor),
    const Icon(CupertinoIcons.news_solid, color: themewhitecolor),
    const Icon(CupertinoIcons.person_add_solid, color: themewhitecolor),
    const Icon(CupertinoIcons.return_icon, color: themewhitecolor),
  ];

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Sidemenupro>(context, listen: false);
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(color: Palette.themecolor2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: const [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: themewhitecolor,
                      child: CircleAvatar(
                        radius: 42,
                        backgroundColor: themewhitecolor,
                        backgroundImage: AssetImage(
                          "assets/images/png/logo.png",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        "Admin@gmail.com",
                        style: TextStyle(
                          color: themewhitecolor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                color: themewhitecolor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "General",
                      style: TextStyle(
                        color: themewhitecolor,
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    const Divider(
                      color: themegreycolor,
                    ),
                    Consumer<Sidemenupro>(builder: ((context, value, child) {
                      return Column(
                        children: List.generate(title.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: value.home_value == index
                                ? InkWell(
                                    onTap: () {
                                      post.shift_new_page(route[index]);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                        color: Palette.themecolor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: icon_color[index],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Text(
                                              title[index],
                                              style: const TextStyle(
                                                color: themewhitecolor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      if (index == 8) {
                                        log("Logout");
                                        FirebaseAuth.instance.signOut();
                                        RouteNavigator.pushandremoveroute(
                                            context, const LoginScreen());
                                      } else {
                                        post.shift_new_page(route[index]);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: icon[index],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Text(
                                              title[index],
                                              style: const TextStyle(
                                                color: themewhitecolor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          );
                        }),
                      );
                    })),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
