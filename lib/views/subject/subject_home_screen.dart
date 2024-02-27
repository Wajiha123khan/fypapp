import 'package:classchronicaladminweb/dashboard/config/responsive.dart';
import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/model/subject_model.dart';
import 'package:classchronicaladminweb/utils/futures_methods.dart';
import 'package:classchronicaladminweb/widget/customSimpleRoundedButtonWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';

class SubjectHomeScreen extends StatefulWidget {
  const SubjectHomeScreen({super.key});

  @override
  State<SubjectHomeScreen> createState() => _SubjectHomeScreenState();
}

class _SubjectHomeScreenState extends State<SubjectHomeScreen> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w600, color: Palette.themecolor, fontSize: 18);
  final formKey = GlobalKey<FormState>();

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
              child: const Text(
                "Subject's",
                style: TextStyle(
                    color: Palette.themecolor,
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: StreamBuilder<List<SubjectModel>>(
                stream: filterSubjects(),
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
                                          "Title",
                                          style: textStyle,
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Degree",
                                          style: textStyle,
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Semester",
                                          style: textStyle,
                                        ),
                                      ),
                                      DataColumn(
                                          label: Text(
                                        "View",
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
                                                datamodel[i].title,
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
                                            FutureBuilder<String>(
                                                future: semester_name_get(
                                                    datamodel[i]
                                                        .semester_id
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
                                            SizedBox(
                                              child: InkWell(
                                                onTap: () {
                                                  subjectDetailWidget(context,
                                                      size, datamodel, i);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                                      child: Center(
                                                        child: Text(
                                                          "View",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  themewhitecolor),
                                                        ),
                                                      ),
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
                  }
                  // }
                  else {
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

  Future<Object?> subjectDetailWidget(
      BuildContext context, Size size, List<SubjectModel> datamodel, int i) {
    return showAnimatedDialog(
        barrierDismissible: true,
        animationType: DialogTransitionType.slideFromRight,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 400),
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                titlePadding: const EdgeInsets.all(24),
                actionsPadding: const EdgeInsets.all(0),
                buttonPadding: const EdgeInsets.all(0),
                title: SizedBox(
                    width: size.width / 100 * 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Subject Details",
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
                          datamodel[i].subject_image != ""
                              ? Container(
                                  height: size.height / 100 * 20,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        datamodel[i].subject_image,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: size.height / 100 * 20,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: themegreycolor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Image.network(
                                    "https://hospitalitywebservices.com/wp-content/themes/ryse/assets/images/no-image/No-Image-Found-400x264.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Subject Title: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Text(
                                  datamodel[i].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: themegreytextcolor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Degree: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                FutureBuilder<String>(
                                    future: degree_name_get(
                                        datamodel[i].degree_id.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        String data = snapshot.data!;

                                        return Text(
                                          data,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: themegreytextcolor,
                                            fontSize: 14,
                                          ),
                                        );
                                      } else {
                                        return const Text(
                                          "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: themegreytextcolor,
                                            fontSize: 14,
                                          ),
                                        );
                                      }
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Semester: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                FutureBuilder<String>(
                                    future: semester_name_get(
                                        datamodel[i].semester_id.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        String data = snapshot.data!;

                                        return Text(
                                          data,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: themegreytextcolor,
                                            fontSize: 14,
                                          ),
                                        );
                                      } else {
                                        return const Text(
                                          "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: themegreytextcolor,
                                            fontSize: 14,
                                          ),
                                        );
                                      }
                                    }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Creation Date: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Text(
                                  DateFormat.yMEd()
                                      .format(datamodel[i].date_time.toDate()),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: themegreytextcolor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )),
              ),
            ));
  }

  Stream<List<SubjectModel>> filterSubjects() => FirebaseFirestore.instance
      .collection('subject')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => SubjectModel.fromJson(document.data()))
          .toList());
}
