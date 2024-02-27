import 'package:classchronicaladminweb/dashboard/component/infoCard.dart';
import 'package:classchronicaladminweb/dashboard/component/sideMenu.dart';
import 'package:classchronicaladminweb/dashboard/config/Sidemenupro.dart';
import 'package:classchronicaladminweb/dashboard/config/responsive.dart';
import 'package:classchronicaladminweb/dashboard/config/size_config.dart';
import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/provider/global_pro.dart';
import 'package:classchronicaladminweb/views/degree/degree_home_screen.dart';
import 'package:classchronicaladminweb/views/schedule/timetable_schedule_screen.dart';
import 'package:classchronicaladminweb/views/semester/semester_home_screen.dart';
import 'package:classchronicaladminweb/views/students/students_home_screen.dart';
import 'package:classchronicaladminweb/views/subject/subject_home_screen.dart';
import 'package:classchronicaladminweb/views/teacher_assign/teacher_assign_screen.dart';
import 'package:classchronicaladminweb/views/teachers/teachers_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
 @override
  void initState() {
      Provider.of<GlobalPro>(context, listen: false).fetchDashboardItems();

      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final modelMenu = Provider.of<Sidemenupro>(
      context,
    );
   
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 250, child: SideMenu()),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              elevation: 0,
              backgroundColor: themewhitecolor,
              leading: IconButton(
                  onPressed: () {
                    _drawerKey.currentState?.openDrawer();
                  },
                  icon: const Icon(Icons.menu, color: themeblackcolor)),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        icon: SvgPicture.asset(
                          'assets/calendar.svg',
                          width: 20,
                        ),
                        onPressed: () {}),
                    const SizedBox(width: 10),
                    IconButton(
                        icon: SvgPicture.asset('assets/ring.svg', width: 20.0),
                        onPressed: () {}),
                    const SizedBox(width: 15),
                    Row(children: const [
                      CircleAvatar(
                          radius: 17,
                          backgroundImage:
                              AssetImage('assets/images/png/logo.png')),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        color: themeblackcolor,
                      )
                    ]),
                  ],
                )
              ],
            )
          : const PreferredSize(
              preferredSize: Size.zero,
              child: SizedBox(),
            ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 3,
                child: SideMenu(),
              ),
            Expanded(
              flex: 14,
              child: modelMenu.home_value == 0
                  ? SafeArea(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: SizeConfig.blockSizeVertical! * 4,
                            ),
                            Consumer<GlobalPro>(
                                builder: ((context, modelValue, child) {
                              return SizedBox(
                                width: SizeConfig.screenWidth,
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    InfoCard(
                                      icon: 'assets/transfer.svg',
                                      label: 'Total Students',
                                      amount:
                                          "${modelValue.totalSubjects.length}",
                                    ),
                                    InfoCard(
                                      icon: 'assets/transfer.svg',
                                      label: 'Total Teachers',
                                      amount:
                                          "${modelValue.totalTeachers.length}",
                                    ),
                                    InfoCard(
                                      icon: 'assets/transfer.svg',
                                      label: 'Degrees Counts',
                                      amount:
                                          "${modelValue.totalDegrees.length}",
                                    ),
                                    InfoCard(
                                      icon: 'assets/transfer.svg',
                                      label: 'Subjects Count',
                                      amount:
                                          "${modelValue.totalSubjects.length}",
                                    ),
                                    InfoCard(
                                      icon: 'assets/transfer.svg',
                                      label: 'Timetable Schedules',
                                      amount:
                                          "${modelValue.timetableSchedules.length}",
                                    ),
                                  ],
                                ),
                              );
                            })),
                            SizedBox(
                              height: size.height / 100 * 15,
                            ),
                            Center(
                              child: Image.network(
                                "https://qph.cf2.quoracdn.net/main-qimg-a838b7784b11fe4e442e2a916f8b2792",
                                width: size.width,
                                fit: BoxFit.contain,
                                height: size.height / 100 * 40,
                              ),
                            ),
                            SizedBox(
                              height: size.height / 100 * 3,
                            ),
                            Center(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  "Welcome to Smart Rental House\nAdmin Dashboard.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Palette.themecolor2,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical! * 4,
                            ),
                          ],
                        ),
                      ),
                    )
                  : modelMenu.home_value == 1
                      ? const DegreeHomeScreen()
                      : modelMenu.home_value == 2
                          ? const SemesterHomeScreen()
                          : modelMenu.home_value == 3
                              ? const SubjectHomeScreen()
                              : modelMenu.home_value == 4
                                  ? const TimetableScheduleScreen()
                                  : modelMenu.home_value == 5
                                      ? const StudentsHomeScreen()
                                      : modelMenu.home_value == 6
                                          ? const TeachersHomeScreen()
                                          : modelMenu.home_value == 7
                                              ? const TeacherAssignSubjectScreen()
                                              : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
