import 'package:classchronicaladminweb/model/student_model.dart';
import 'package:classchronicaladminweb/widget/customSimpleRoundedButtonWidget.dart';
import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/dashboard/config/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentsHomeScreen extends StatefulWidget {
  const StudentsHomeScreen({super.key});

  @override
  State<StudentsHomeScreen> createState() => _StudentsHomeScreenState();
}

class _StudentsHomeScreenState extends State<StudentsHomeScreen> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w600, color: Palette.themecolor, fontSize: 18);
  final formKey = GlobalKey<FormState>();

  TextEditingController degreeNameController = TextEditingController();
  studentTypeUpdateFunc(int value, id) {
    FirebaseFirestore.instance
        .collection("student_auth")
        .doc(id)
        .update({'type': value});
  }

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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                                            SizedBox(
                                              child: Text(
                                                datamodel[i].degree_id,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "JosefinSans",
                                                ),
                                              ),
                                            ),
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
                                                                const BorderRadius
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
                                                                  const BorderRadius
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
                                                                const BorderRadius
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
                                                                const BorderRadius
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
                                                onTap: () {},
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

  Stream<List<StudentModel>> filterStudents() => FirebaseFirestore.instance
      .collection('degree')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => StudentModel.fromJson(document.data()))
          .toList());
}
