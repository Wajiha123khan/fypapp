import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/provider/degree_pro.dart';
import 'package:classchronicaladminweb/provider/semester_pro.dart';
import 'package:classchronicaladminweb/provider/subject_pro.dart';
import 'package:classchronicaladminweb/provider/teacher_pro.dart';
import 'package:classchronicaladminweb/utils/teacher_futures_methods.dart';
import 'package:classchronicaladminweb/widget/customSimpleRoundedButtonWidget.dart';
import 'package:classchronicaladminweb/widget/customToastWidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class TeacherAssignSubjectScreen extends StatefulWidget {
  const TeacherAssignSubjectScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherAssignSubjectScreen> createState() =>
      _TeacherAssignSubjectScreenState();
}

class _TeacherAssignSubjectScreenState
    extends State<TeacherAssignSubjectScreen> {
  void Student_fees_type_update(int value, id) {
    FirebaseFirestore.instance
        .collection("student_fees")
        .doc(id)
        .update({'type': value});
  }

  String? degree_value = '';
  String teacher_value = "";
  String Semestervalue = "";
  String Subjectvalue = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final Pro_Post = Provider.of<DegreePro>(context, listen: false);
    final Pro_Post_t = Provider.of<TeacherPro>(context, listen: false);
    Pro_Post.Get_degree_fun();
    Pro_Post_t.get_teacher_name_fun();
  }

  @override
  Widget build(BuildContext context) {
    final _pro_d_get = Provider.of<DegreePro>(context);
    final _pro_s_get = Provider.of<SemesterPro>(context);
    final _pro_t_get = Provider.of<TeacherPro>(context);
    final _pro_sub_get = Provider.of<SubjectPro>(context);
    final size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 100 * 85,
        child: Scaffold(
          // backgroundColor: themeprimarycolor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(color: themeblackcolor),
            backgroundColor: Colors.grey.shade100,
            elevation: 1,
            centerTitle: true,
            title: const Text(
              "Teacher",
              style: TextStyle(color: themeblackcolor),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 15.0, left: 15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: SizedBox(
                          width: size.width / 100 * 30,
                          child: DropdownButtonFormField(
                              style: const TextStyle(color: themeblackcolor),
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: themewhitecolor,
                                  labelText: "Select Teacher",
                                  labelStyle: TextStyle(color: themeblackcolor),
                                  isDense: true,
                                  alignLabelWithHint: true,
                                  contentPadding: EdgeInsets.all(8)),
                              // value: degree_value,
                              items: _pro_t_get.teacher_name
                                  .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: themeblackcolor,
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (item) {
                                teacher_value = item.toString();
                                print(teacher_value);
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: SizedBox(
                          width: size.width / 100 * 30,
                          child: DropdownButtonFormField(
                            style: const TextStyle(color: themeblackcolor),
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: themewhitecolor,
                                labelText: "Select Degree",
                                labelStyle: TextStyle(color: themeblackcolor),
                                isDense: true,
                                alignLabelWithHint: true,
                                contentPadding: EdgeInsets.all(8)),
                            items: _pro_d_get.degree_get
                                .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: themeblackcolor,
                                      ),
                                    )))
                                .toList(),
                            onChanged: (item) => setState(() {
                              degree_value = item.toString();
                              print(degree_value);

                              final ProPost = Provider.of<SemesterPro>(context,
                                  listen: false);
                              _pro_s_get.semester_get.clear();
                              _pro_sub_get.Subject.clear();
                              ProPost.Get_semester_fun(degree_value);
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: SizedBox(
                          width: size.width / 100 * 30,
                          child: DropdownButtonFormField(
                            style: const TextStyle(color: themeblackcolor),
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: themewhitecolor,
                                labelText: "Select Semester",
                                labelStyle: TextStyle(color: themeblackcolor),
                                isDense: true,
                                alignLabelWithHint: true,
                                contentPadding: EdgeInsets.all(8)),
                            items: _pro_s_get.semester_get
                                .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: themeblackcolor,
                                      ),
                                    )))
                                .toList(),
                            onChanged: (item) => setState(() {
                              Semestervalue = item.toString();
                              final ProPost = Provider.of<SubjectPro>(context,
                                  listen: false);
                              ProPost.get_Subject(
                                  degree_value, item.toString());
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15.0),
                        child: SizedBox(
                          width: size.width / 100 * 30,
                          child: DropdownButtonFormField(
                            style: const TextStyle(color: themeblackcolor),
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: themewhitecolor,
                                labelText: "Select Subject",
                                labelStyle: TextStyle(color: themeblackcolor),
                                isDense: true,
                                alignLabelWithHint: true,
                                contentPadding: EdgeInsets.all(8)),
                            items: _pro_sub_get.Subject.map(
                                (item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: themeblackcolor,
                                      ),
                                    ))).toList(),
                            onChanged: (item) => setState(() {
                              Subjectvalue = item.toString();
                              print(Subjectvalue);

                              // final ProPost = Provider.of<semester_pro>(context,
                              //     listen: false);
                              // ProPost.Get_semester_fun(degree_value);
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Consumer<SubjectPro>(builder: ((context, modelValue, child) {
                    return Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: CustomSimpleRoundedButton(
                            buttonText: "Assign",
                            onTap: () {
                              if (modelValue.degree_id == "") {
                                showCustomToast(
                                    "Please Select Degree", context);
                              } else if (modelValue.semester_id == "") {
                                showCustomToast(
                                    "Please Select Semester", context);
                              } else if (Subjectvalue == "") {
                                showCustomToast(
                                    "Please Select Subject", context);
                              } else if (teacher_value == "") {
                                showCustomToast(
                                    "Please Select Teacher", context);
                              } else {
                                Provider.of<TeacherPro>(context, listen: false)
                                    .assign_Subject(
                                        modelValue.degree_id,
                                        modelValue.semester_id,
                                        Subjectvalue,
                                        teacher_value,
                                        context);
                              }
                            },
                            height: 50,
                            width: 150,
                            buttoncolor: Palette.themecolor,
                            buttontextcolor: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                      ),
                    );
                  })),
                 
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeprimarycolor,
                        border: Border.all(),
                        boxShadow: [
                          BoxShadow(
                            color: themeblackcolor.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('teacher_assign')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  'Something went wrong! ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              var data = snapshot.data!.docs;
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    headingRowColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.grey.shade200),
                                    columns: [
                                      const DataColumn(label: Text("Teacher")),
                                      const DataColumn(label: Text("Degree")),
                                      const DataColumn(label: Text("Semester")),
                                      const DataColumn(label: Text("Subject")),
                                      const DataColumn(
                                          label: Text("Date Time")),
                                      const DataColumn(label: Text("Delete")),
                                    ],
                                    rows: [
                                      for (int i = 0; i < data.length; i++)
                                        DataRow(cells: [
                                          DataCell(
                                            SizedBox(
                                                width: size.width / 100 * 8,
                                                child: FutureBuilder<String>(
                                                    future: TeacherFutureMethods()
                                                        .teacher_name_get(data[
                                                                i]["teacher_id"]
                                                            .toString()),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        String Datara =
                                                            snapshot.data!;

                                                        return Text(
                                                          Datara,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        );
                                                      } else {
                                                        return const Text("");
                                                      }
                                                    })),
                                          ),
                                          DataCell(
                                            SizedBox(
                                                width: size.width / 100 * 10,
                                                child: FutureBuilder<String>(
                                                    future: TeacherFutureMethods()
                                                        .degree_name_get(data[i]
                                                                ["degree_id"]
                                                            .toString()),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        String Datara =
                                                            snapshot.data!;

                                                        return Text(
                                                          Datara,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        );
                                                      } else {
                                                        return const Text("");
                                                      }
                                                    })),
                                          ),
                                          DataCell(
                                            SizedBox(
                                                width: size.width / 100 * 5,
                                                child: FutureBuilder<String>(
                                                    future: TeacherFutureMethods()
                                                        .semester_name_get(data[
                                                                    i]
                                                                ["semester_id"]
                                                            .toString()),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        String Datara =
                                                            snapshot.data!;

                                                        return Text(
                                                          Datara,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        );
                                                      } else {
                                                        return const Text("");
                                                      }
                                                    })),
                                          ),
                                          DataCell(
                                            SizedBox(
                                                width: size.width / 100 * 10,
                                                child: FutureBuilder<String>(
                                                    future: TeacherFutureMethods()
                                                        .sunject_name_get(data[
                                                                i]["subject_id"]
                                                            .toString()),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        String Datara =
                                                            snapshot.data!;

                                                        return Text(
                                                          Datara,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                        );
                                                      } else {
                                                        return const Text("");
                                                      }
                                                    })),
                                          ),
                                          DataCell(
                                            SizedBox(
                                              width: size.width / 100 * 10,
                                              child: Text(
                                                DateFormat.yMd()
                                                    .add_jm()
                                                    .format(data[i]["date_time"]
                                                        .toDate()),
                                                style: const TextStyle(
                                                    fontSize: 18),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CustomSimpleRoundedButton(
                                                buttonText: "Delete",
                                                onTap: () {
                                                  teacherDeleteDialog(
                                                      context, size, data, i);
                                                },
                                                height: size.height / 100 * 4,
                                                width: size.width / 100 * 20,
                                                buttoncolor: Colors.red,
                                                buttontextcolor:
                                                    themeprimarycolor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),
                                    ]),
                              );
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.grey.shade200));
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Object?> teacherDeleteDialog(BuildContext context, Size size,
      List<QueryDocumentSnapshot<Object?>> data, int i) {
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
                              Text(
                                "Are you sure you want to delete this Teacher?",
                                style: TextStyle(
                                    color: Palette.themecolor,
                                    fontSize: 18,
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
                              CustomSimpleRoundedButton(
                                buttonText: "Yes",
                                onTap: () {
                                  Provider.of<TeacherPro>(context,
                                          listen: false)
                                      .removeAssignedSubject(
                                          data[i]["assign_id"], context);
                                },
                                height: kMinInteractiveDimension,
                                width: size.width / 100 * 18.5,
                                buttoncolor: themeredcolor,
                                buttontextcolor: themeprimarycolor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              CustomSimpleRoundedButton(
                                buttonText: "No",
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                height: kMinInteractiveDimension,
                                width: size.width / 100 * 18.5,
                                buttoncolor: Palette.themecolor,
                                buttontextcolor: themeprimarycolor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ));
  }
}
