
import 'package:classchronicaladminweb/dashboard/config/responsive.dart';
import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/model/semester_model.dart';
import 'package:classchronicaladminweb/provider/semester_pro.dart';
import 'package:classchronicaladminweb/provider/subject_pro.dart';
import 'package:classchronicaladminweb/utils/futures_methods.dart';
import 'package:classchronicaladminweb/widget/customSimpleRoundedButtonWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SemesterHomeScreen extends StatefulWidget {
  const SemesterHomeScreen({super.key});

  @override
  State<SemesterHomeScreen> createState() => _SemesterHomeScreenState();
}

class _SemesterHomeScreenState extends State<SemesterHomeScreen> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w600, color: Palette.themecolor, fontSize: 18);
  final formKey = GlobalKey<FormState>();

//controllers
  final _formKey = GlobalKey<FormState>();
  TextEditingController subjectNameC = TextEditingController();
  TextEditingController subjectDescriptionC = TextEditingController();
  TextEditingController subjectObjectiveC = TextEditingController();
  TextEditingController subjectLearningOutcomeC = TextEditingController();
  TextEditingController subjectTextRefrenceC = TextEditingController();

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
                "Semester's",
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
            child: StreamBuilder<List<SemesterModel>>(
                stream: filterSemesters(),
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
                                          "Semester",
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
                                        "Create Time",
                                        style: textStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Add Course",
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
                                            SizedBox(
                                              child: Text(
                                                DateFormat.yMd()
                                                    .add_jm()
                                                    .format(datamodel[i]
                                                        .date_time
                                                        .toDate()),
                                                // datamodel[i].date_time,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "JosefinSans",
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            SizedBox(
                                              child: InkWell(
                                                onTap: () {
                                                  addSemesterSubjectWidget(
                                                      context,
                                                      size,
                                                      datamodel,
                                                      i);
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
                                                          "Add Course",
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

  Future<Object?> addSemesterSubjectWidget(
      BuildContext context, Size size, List<SemesterModel> datamodel, int i) {
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
                      width: size.width / 100 * 45,
                      // height: size.height / 100 * 90,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Create a New Subject",
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

                            Consumer<SemesterPro>(
                                builder: ((context, modelValue, child) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  onTap: () async {
                                    modelValue.pickSubjectImage();
                                  },
                                  child: modelValue.subjectImage != null
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Palette.themecolor,
                                          backgroundImage: MemoryImage(
                                              modelValue.subjectImage!),
                                        )
                                      : const CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Palette.themecolor,
                                          child: Icon(
                                            Icons.subject_outlined,
                                            color: Colors.white,
                                            size: 45,
                                          ),
                                        ),
                                ),
                              );
                            })),

                            const SizedBox(
                              height: 10,
                            ),

                            //subject name
                            TextFormField(
                                controller: subjectNameC,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: themegreycolor,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: "Subject Name",
                                  hintText: "Enter Subject Name",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  errorStyle: const TextStyle(fontSize: 0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            //course desciption
                            TextFormField(
                                controller: subjectDescriptionC,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: themegreycolor,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: "Course Description",
                                  hintText: "Enter Course Description",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  errorStyle: const TextStyle(fontSize: 0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            //course objectives
                            TextFormField(
                                controller: subjectObjectiveC,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: themegreycolor,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: "Course Objectives",
                                  hintText: "Enter Course Objectives",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  errorStyle: const TextStyle(fontSize: 0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            //learning outcomes
                            TextFormField(
                                controller: subjectLearningOutcomeC,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: themegreycolor,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: "Learning Outcomes",
                                  hintText: "Enter Learning Outcomes",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  errorStyle: const TextStyle(fontSize: 0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            //learning outcomes
                            TextFormField(
                                controller: subjectTextRefrenceC,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: themegreycolor,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  labelText: "Text / Reference Books",
                                  hintText: "Enter Text / Reference Books",
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                  errorStyle: const TextStyle(fontSize: 0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 15,
                            ),
                            Consumer<SemesterPro>(
                                builder: ((context, modelValue, child) {
                              return CustomSimpleRoundedButton(
                                buttonText: "Create",
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (modelValue.subjectImage != null) {
                                      final subjectProvider =
                                          Provider.of<SubjectPro>(context,
                                              listen: false);

                                      subjectProvider.addSubjectFunc(
                                        modelValue.subjectImage!,
                                        datamodel[i].degree_id.toString(),
                                        datamodel[i].semester_id.toString(),
                                        subjectNameC.text,
                                        subjectDescriptionC.text,
                                        subjectObjectiveC.text,
                                        subjectLearningOutcomeC.text,
                                        subjectTextRefrenceC.text,
                                        context,
                                      );

                                      setState(() {
                                        modelValue.subjectImage = null;
                                        subjectNameC.clear();
                                        subjectDescriptionC.clear();
                                        subjectObjectiveC.clear();
                                        subjectLearningOutcomeC.clear();
                                        subjectTextRefrenceC.clear();
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please Select Subject Image")));
                                    }
                                  }
                                },
                                height: kMinInteractiveDimension,
                                width: size.width,
                                buttoncolor: Palette.themecolor,
                                buttontextcolor: themeprimarycolor,
                                borderRadius: BorderRadius.circular(12.0),
                              );
                            })),
                          ],
                        ),
                      )),
                ),
              ),
            ));
  }

  Stream<List<SemesterModel>> filterSemesters() => FirebaseFirestore.instance
      .collection('semester')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => SemesterModel.fromJson(document.data()))
          .toList());
}
