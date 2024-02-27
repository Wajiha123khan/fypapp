import 'dart:developer';

import 'package:classchronicaladminweb/dashboard/config/responsive.dart';
import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/model/student_model.dart';
import 'package:classchronicaladminweb/provider/student_pro.dart';
import 'package:classchronicaladminweb/utils/futures_methods.dart';
import 'package:classchronicaladminweb/utils/teacher_futures_methods.dart';
import 'package:classchronicaladminweb/widget/customSimpleRoundedButtonWidget.dart';
import 'package:classchronicaladminweb/widget/customToastWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';

class StudentsHomeScreen extends StatefulWidget {
  const StudentsHomeScreen({super.key});

  @override
  State<StudentsHomeScreen> createState() => _StudentsHomeScreenState();
}

class _StudentsHomeScreenState extends State<StudentsHomeScreen> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w600, color: Palette.themecolor, fontSize: 18);
  final formKey = GlobalKey<FormState>();
  void studentTypeUpdateFunc(int value, id) {
    FirebaseFirestore.instance
        .collection("student_auth")
        .doc(id)
        .update({'type': value});
  }

  final TextEditingController startTimeC = TextEditingController();
  @override
  void initState() {
    final semesterPro = Provider.of<StudentPro>(context, listen: false);
    semesterPro.semesterGet.clear();
    super.initState();
  }

  String semesterId = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Container(
              width: size.width / 100 * 90,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: themewhitecolor,
                  border: Border.all(color: Colors.grey.shade100)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Student's",
                    style: TextStyle(
                        color: Palette.themecolor,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: StreamBuilder<List<StudentModel>>(
                stream: filterStudents(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final datamodel = snapshot.data!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: themewhitecolor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: DataTable(
                                    border: TableBorder.all(
                                      color: Colors.grey.shade200,
                                    ),
                                    decoration: BoxDecoration(
                                        color: themewhitecolor,
                                        border: Border.all(
                                            color: Colors.grey.shade200)),
                                    headingRowColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => themewhitecolor),
                                    columns: [
                                      DataColumn(
                                          label: Container(
                                        decoration: const BoxDecoration(),
                                        child: Text(
                                          Responsive.isDesktop(context)
                                              ? "S.No"
                                              : "#",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Palette.themecolor,
                                              fontSize: 18),
                                        ),
                                      )),
                                      DataColumn(
                                        label: Text(
                                          "Name",
                                          style: textStyle,
                                        ),
                                      ),
                                      DataColumn(
                                          label: Text(
                                        "Surname",
                                        style: textStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Degree",
                                        style: textStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Status",
                                        style: textStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Detail",
                                        style: textStyle,
                                      )),
                                    ],
                                    rows: [
                                      for (int i = 0; i < datamodel.length; i++)
                                        DataRow(cells: [
                                          DataCell(
                                            SizedBox(
                                              child: Text(
                                                '${i + 1}',
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            SizedBox(
                                              child: Text(
                                                datamodel[i].name,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "JosefinSans",
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            SizedBox(
                                              child: Text(
                                                datamodel[i].surname,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "JosefinSans",
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            FutureBuilder<String>(
                                                future: degree_name_get(
                                                    datamodel[i]
                                                        .degree_id
                                                        .toString()),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    String data =
                                                        snapshot.data!;

                                                    return Center(
                                                        child: Text(
                                                      data.toString(),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "JosefinSans",
                                                      ),
                                                    ));
                                                  } else {
                                                    return const Text(
                                                      "N/a",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "JosefinSans",
                                                      ),
                                                    );
                                                  }
                                                }),
                                          ),
                                          DataCell(
                                            datamodel[i].type == 0
                                                ? SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          CustomSimpleRoundedButton(
                                                            buttonText:
                                                                "Approve",
                                                            onTap: () {
                                                              studentTypeUpdateFunc(
                                                                  1,
                                                                  datamodel[i]
                                                                      .uid);
                                                            },
                                                            height: 60,
                                                            width: 100,
                                                            buttoncolor:
                                                                themebluecolor,
                                                            buttontextcolor:
                                                                themeprimarycolor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  0),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5.0),
                                                            child:
                                                                CustomSimpleRoundedButton(
                                                              buttonText:
                                                                  "Decline",
                                                              onTap: () {
                                                                studentTypeUpdateFunc(
                                                                    2,
                                                                    datamodel[i]
                                                                        .uid);
                                                              },
                                                              height: 60,
                                                              width: 100,
                                                              buttoncolor:
                                                                  Colors.red,
                                                              buttontextcolor:
                                                                  themeprimarycolor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    0),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : datamodel[i].type == 1
                                                    ? SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            100 *
                                                            90 /
                                                            9,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              CustomSimpleRoundedButton(
                                                            buttonText:
                                                                "Decline",
                                                            onTap: () {
                                                              studentTypeUpdateFunc(
                                                                  2,
                                                                  datamodel[i]
                                                                      .uid);
                                                            },
                                                            height: 60,
                                                            width: 100,
                                                            buttoncolor:
                                                                Colors.red,
                                                            buttontextcolor:
                                                                themeprimarycolor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  0),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            100 *
                                                            90 /
                                                            9,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              CustomSimpleRoundedButton(
                                                            buttonText:
                                                                "Approve",
                                                            onTap: () {
                                                              studentTypeUpdateFunc(
                                                                  1,
                                                                  datamodel[i]
                                                                      .uid);
                                                            },
                                                            height: 60,
                                                            width: 100,
                                                            buttoncolor:
                                                                themebluecolor,
                                                            buttontextcolor:
                                                                themeprimarycolor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                          ),
                                          DataCell(
                                            SizedBox(
                                              child: InkWell(
                                                onTap: () async {
                                                  final semesterPro =
                                                      Provider.of<StudentPro>(
                                                          context,
                                                          listen: false);
                                                  await semesterPro
                                                      .getSemestersListFunc(
                                                          datamodel[i]
                                                              .degree_id);
                                                  studentDetailsDialog(context,
                                                      size, datamodel, i);
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    color: Palette.themecolor,
                                                  ),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Icon(
                                                      Icons.info,
                                                      size: 18,
                                                      color: themewhitecolor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                            color: Colors.grey.shade200));
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<Object?> studentDetailsDialog(
      BuildContext context, Size size, List<StudentModel> datamodel, int i) {
    return showAnimatedDialog(
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromRight,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 400),
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => SingleChildScrollView(
                child: AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  titlePadding: const EdgeInsets.all(24),
                  actionsPadding: const EdgeInsets.all(0),
                  buttonPadding: const EdgeInsets.all(0),
                  title: SizedBox(
                      width: size.width / 100 * 40,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Student Details",
                                style: TextStyle(
                                    color: Palette.themecolor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              CustomIconButton(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.cancel))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width / 100 * 19,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: themegreycolor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Full Name: ${datamodel[i].name} ${datamodel[i].surname}",
                                  style: const TextStyle(
                                      color: themegreytextcolor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: size.width / 100 * 19,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: themegreycolor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Roll Number: ${datamodel[i].roll_no}",
                                  style: const TextStyle(
                                      color: themegreytextcolor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: size.width / 100 * 19,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: themegreycolor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: FutureBuilder<String>(
                                      future: TeacherFutureMethods()
                                          .degree_name_get(
                                              datamodel[i].degree_id),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          String degreeName = snapshot.data!;
                                          debugPrint(
                                              "datamodel[i].degree_id: ${datamodel[i].degree_id}");
                                          return Text(
                                            "Degree: $degreeName",
                                            style: const TextStyle(
                                                color: themegreytextcolor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          );
                                        } else {
                                          return const Text("Degree: ");
                                        }
                                      })),
                              Container(
                                  width: size.width / 100 * 19,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: themegreycolor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: FutureBuilder<String>(
                                      future: TeacherFutureMethods()
                                          .semester_name_get(
                                              datamodel[i].semester_id),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          String semesterName = snapshot.data!;

                                          return Text(
                                            "Semester: $semesterName",
                                            style: const TextStyle(
                                                color: themegreytextcolor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          );
                                        } else {
                                          return const Text("Semester: ");
                                        }
                                      })),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Consumer<StudentPro>(
                              builder: ((context, modelValue, child) {
                            return modelValue.semesterGet.isEmpty
                                ? Container()
                                : Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      DropdownButtonFormField(
                                          style: const TextStyle(
                                              color: themeblackcolor),
                                          decoration: InputDecoration(
                                            fillColor: themelightgreycolor,
                                            filled: true,
                                            hintText: "Select Your Semester",
                                            hintStyle: const TextStyle(
                                              fontSize: 12,
                                            ),
                                            labelText: "Select Semester",
                                            labelStyle: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
                                            alignLabelWithHint: true,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          items: modelValue.semesterGet
                                              .map((item) => DropdownMenuItem(
                                                  value: item['semester_id'],
                                                  child: Text(
                                                    item['title'],
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: themeblackcolor,
                                                    ),
                                                  )))
                                              .toList(),
                                          onChanged: (item) {
                                            log("semester Id: $item");
                                            semesterId = item.toString();
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return "Please Select Semester";
                                            }
                                            return null;
                                          }),
                                    ],
                                  );
                          })),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomSimpleRoundedButton(
                            buttonText: "Update",
                            onTap: () {
                              if (semesterId != "") {
                                final studentPro = Provider.of<StudentPro>(
                                    context,
                                    listen: false);

                                studentPro.studentSemesterUpdateUpdateFunc(
                                    datamodel[i].uid, semesterId, context);
                              } else {
                                  showCustomToast(
                                    "Please Select Semester to Update", context);
                               
                              }
                            },
                            height: size.height / 100 * 5,
                            width: size.width / 100 * 15,
                            buttoncolor: Palette.themecolor,
                            buttontextcolor: themewhitecolor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ));
  }

  Stream<List<StudentModel>> filterStudents() => FirebaseFirestore.instance
      .collection('student_auth')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => StudentModel.fromJson(document.data()))
          .toList());
}
