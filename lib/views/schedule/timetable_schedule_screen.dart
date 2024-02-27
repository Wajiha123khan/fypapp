
import 'package:classchronicaladminweb/dashboard/config/responsive.dart';
import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/model/degree_model.dart';
import 'package:classchronicaladminweb/model/timetable_schedule_model.dart';
import 'package:classchronicaladminweb/provider/degree_pro.dart';
import 'package:classchronicaladminweb/provider/notification_pro.dart';
import 'package:classchronicaladminweb/provider/schedule_pro.dart';
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

class TimetableScheduleScreen extends StatefulWidget {
  const TimetableScheduleScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TimetableScheduleScreen> createState() =>
      _TimetableScheduleScreenState();
}

class _TimetableScheduleScreenState extends State<TimetableScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController startTimeC = TextEditingController();
  final TextEditingController endTimeC = TextEditingController();
  final TextEditingController scheduleDateC = TextEditingController();
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w600, color: Palette.themecolor, fontSize: 18);
  String? degree_value = '';
  String Semestervalue = "";
  String Subjectvalue = "";
  String teacher_value = "";
  @override
  void initState() {
    super.initState();
    final Pro_Post = Provider.of<DegreePro>(context, listen: false);
    final Pro_Post_t = Provider.of<TeacherPro>(context, listen: false);
    Pro_Post.Get_degree_fun();
    Pro_Post_t.get_teacher_name_fun();
  }

//room list slack
  String selectedRoomValue = "";
  int roomValue = 0;
  var roomList = [
    'Select Room No',
    'Room No 01',
    'Room No 02',
    'Room No 03',
    'Room No 04',
    'Room No 05',
    'Room No 06',
    'Room No 07',
    'Room No 08',
    'Room No 09',
    'Room No 10',
    'Room No 11',
    'Room No 12',
    'Room No 13',
    'Room No 14',
    'Room No 15',
    'Lab No 01',
    'Lab No 02',
    'Lab No 03',
    'Lab No 04',
    'Lab No 05',
    'Lab No 06',
    'Lab No 07',
    'Lab No 08',
    'Lab No 09',
    'Lab No 10',
  ];
  List<String> studentsList = [];

  @override
  Widget build(BuildContext context) {
    final _pro_d_get = Provider.of<DegreePro>(context);
    final _pro_s_get = Provider.of<SemesterPro>(context);
    final _pro_sub_get = Provider.of<SubjectPro>(context);
    final _pro_schedule_get = Provider.of<SchedulePro>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                child: Container(
                  width: size.width / 100 * 90,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: themewhitecolor,
                      border: Border.all(color: Colors.grey.shade100)),
                  child: const Text(
                    "Schedule Timetable's",
                    style: TextStyle(
                        color: Palette.themecolor,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                child: Container(
                    width: size.width / 100 * 90,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: themewhitecolor,
                        borderRadius: BorderRadius.circular(15)),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              "Add Subject Timetable",
                              style: TextStyle(
                                  color: Palette.themecolor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22),
                            ),
                          ),
                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width / 100 * 37,
                                child: TextFormField(
                                  style:
                                      const TextStyle(color: themeblackcolor),
                                  controller: startTimeC,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.date_range),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(15),
                                    labelText: "Start Time",
                                    labelStyle:
                                        TextStyle(color: themeblackcolor),
                                    isDense: true,
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 10, minute: 47),
                                            builder: (context, Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            false),
                                                child: child!,
                                              );
                                            });

                                    if (pickedTime != null) {
                                      debugPrint(
                                          "Parsed Time: ${pickedTime.format(context)}"); //output 10:51 PM
                                      setState(() {
                                        startTimeC.text =
                                            pickedTime.format(context);
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },
                                  validator: ((value) {
                                    if (value!.isEmpty && value == "") {
                                      return "Please Select the Start time";
                                    }
                                    return null;
                                  }),
                                ),
                              ),
                              //end time
                              SizedBox(
                                width: size.width / 100 * 37,
                                child: TextFormField(
                                  style:
                                      const TextStyle(color: themeblackcolor),
                                  controller: endTimeC,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.date_range),
                                    contentPadding: EdgeInsets.all(15),
                                    labelText: "End Time",
                                    labelStyle:
                                        TextStyle(color: themeblackcolor),
                                    isDense: true,
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? pickedTime =
                                        await showTimePicker(
                                            context: context,
                                            initialTime: const TimeOfDay(
                                                hour: 10, minute: 47),
                                            builder: (context, Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context)
                                                    .copyWith(
                                                        alwaysUse24HourFormat:
                                                            false),
                                                child: child!,
                                              );
                                            });

                                    if (pickedTime != null) {
                                      debugPrint(
                                          "Parsed Time: ${pickedTime.format(context)}"); //output 10:51 PM
                                      setState(() {
                                        endTimeC.text =
                                            pickedTime.format(context);
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },
                                  validator: ((value) {
                                    if (value!.isEmpty && value == "") {
                                      return "Please Select the End time";
                                    }
                                    return null;
                                  }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          //schedule date -- room no
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: size.width / 100 * 37,
                                  child: TextFormField(
                                      autofocus: false,
                                      controller: scheduleDateC,
                                      keyboardType: TextInputType.none,
                                      style: const TextStyle(
                                          color: themeblackcolor),
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          prefixIcon: Icon(Icons.timer),
                                          contentPadding: EdgeInsets.all(15),
                                          isDense: true,
                                          labelText: "Schedule Date",
                                          labelStyle:
                                              TextStyle(color: themeblackcolor),
                                          hintStyle: TextStyle(fontSize: 12)),
                                      onTap: () async {
                                        DateTime? pickeddate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2100));
                                        if (pickeddate != null) {
                                          setState(() {
                                            scheduleDateC.text =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(pickeddate);
                                            debugPrint(
                                                "scheduleDateC: ${scheduleDateC.text}");
                                          });
                                        }
                                      },
                                      validator: ((value) {
                                        if (value!.isEmpty && value == "") {
                                          return "Please Select the date";
                                        }
                                        return null;
                                      })),
                                ),
                                SizedBox(
                                    width: size.width / 100 * 37,
                                    child: DropdownButtonFormField(
                                      borderRadius: BorderRadius.circular(15),
                                      menuMaxHeight: 200,
                                      elevation: 6,
                                      dropdownColor: themewhitecolor,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      iconEnabledColor: themegreytextcolor,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  themeblackcolor.withOpacity(
                                                0.3,
                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          )),
                                      value: roomList[0],
                                      items: roomList
                                          .map((item) => DropdownMenuItem(
                                              value: item.toString(),
                                              child: Text(
                                                item.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: themeblackcolor,
                                                ),
                                              )))
                                          .toList(),
                                      onChanged: (item) => setState(() {
                                        selectedRoomValue = item.toString();
                                        debugPrint(
                                            "selectedRoomValue: $selectedRoomValue");
                                      }),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please Select Room No';
                                        } else if (value == 'Select Room No') {
                                          return 'Please Select Room No';
                                        }
                                        return null;
                                      },
                                    )),
                              ]),

                          const SizedBox(height: 20),

                          //degree -- semester
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width / 100 * 37,
                                child: DropdownButtonFormField(
                                  style:
                                      const TextStyle(color: themeblackcolor),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.school),
                                    contentPadding: EdgeInsets.all(15),
                                    labelText: "Select Degree",
                                    labelStyle:
                                        TextStyle(color: themeblackcolor),
                                    isDense: true,
                                    alignLabelWithHint: true,
                                  ),
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
                                    debugPrint("degree_value: $degree_value");

                                    final ProPost = Provider.of<SemesterPro>(
                                        context,
                                        listen: false);
                                    _pro_s_get.semester_get.clear();
                                    _pro_sub_get.Subject.clear();
                                    ProPost.Get_semester_fun(degree_value);

                                    //clearing teacher uid
                                    _pro_schedule_get.teacherList.clear();
                                  }),
                                ),
                              ),
                              SizedBox(
                                width: size.width / 100 * 37,
                                child: DropdownButtonFormField(
                                  style:
                                      const TextStyle(color: themeblackcolor),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.book),
                                    contentPadding: EdgeInsets.all(15),
                                    labelText: "Select Semester",
                                    labelStyle:
                                        TextStyle(color: themeblackcolor),
                                    isDense: true,
                                    alignLabelWithHint: true,
                                  ),
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
                                    debugPrint("Semestervalue: $Semestervalue");

                                    final ProPost = Provider.of<SubjectPro>(
                                        context,
                                        listen: false);
                                    ProPost.get_Subject(
                                        degree_value, item.toString());

                                    //clearing teacher uid
                                    _pro_schedule_get.teacherList.clear();
                                  }),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          //subject teacher
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width / 100 * 37,
                                child: DropdownButtonFormField(
                                  style:
                                      const TextStyle(color: themeblackcolor),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.description),
                                    contentPadding: EdgeInsets.all(15),
                                    labelText: "Select Subject",
                                    labelStyle:
                                        TextStyle(color: themeblackcolor),
                                    isDense: true,
                                    alignLabelWithHint: true,
                                  ),
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
                                    debugPrint("Subjectvalue: $Subjectvalue");

                                    //calling get selected teacher name
                                    final schedulePost =
                                        Provider.of<SchedulePro>(context,
                                            listen: false);
                                    schedulePost.get_teacher(degree_value,
                                        Semestervalue, Subjectvalue);
                                  }),
                                ),
                              ),
                              //teacher
                              SizedBox(
                                width: size.width / 100 * 37,
                                child: DropdownButtonFormField(
                                    style:
                                        const TextStyle(color: themeblackcolor),
                                    borderRadius: BorderRadius.circular(25),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.person),
                                      contentPadding: EdgeInsets.all(15),
                                      labelText: "Select Teacher",
                                      labelStyle:
                                          TextStyle(color: themeblackcolor),
                                      isDense: true,
                                      alignLabelWithHint: true,
                                    ),
                                    items: _pro_schedule_get.teacherList
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
                                      debugPrint(
                                          "teacher_value: $teacher_value");
                                    }),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              Consumer<SchedulePro>(
                builder: ((context, modelValue, child) {
                  return Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12.0),
                      child: CustomSimpleRoundedButton(
                          buttonText: "Create Timetable",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (degree_value == "") {
                                                                  showCustomToast(
                                    "Please Select Degree", context);
                              
                              } else if (Semestervalue == "") {
                                                                  showCustomToast(
                                    "Please Select Semester", context);
                              
                              } else if (Subjectvalue == "") {
                                                                  showCustomToast(
                                    "Please Select Subject", context);
                                
                              } else if (teacher_value == "") {
                                                                  showCustomToast(
                                    "Please Select Teacher", context);
                           
                              } else {
                                final semesterPost = Provider.of<SemesterPro>(
                                    context,
                                    listen: false);
                                final subjectPost = Provider.of<SubjectPro>(
                                    context,
                                    listen: false);
                                final schedulePost = Provider.of<SchedulePro>(
                                    context,
                                    listen: false);
                                schedulePost.createSubjectScheduleFunc(
                                    modelValue.degree_id,
                                    modelValue.semester_id,
                                    modelValue.subject_id,
                                    modelValue.teacher_id,
                                    startTimeC.text,
                                    endTimeC.text,
                                    scheduleDateC.text,
                                    selectedRoomValue,
                                    context);
                                //clearing variables
                                setState(() {
                                  startTimeC.clear();
                                  endTimeC.clear();
                                  scheduleDateC.clear();
                                  selectedRoomValue = "";
                                  subjectPost.Subject.clear();
                                  semesterPost.semester_get.clear();
                                  schedulePost.teacherList.clear();
                                });
                              }
                            }
                          },
                          height: size.height / 100 * 5,
                          width: size.width / 100 * 20,
                          buttoncolor: Palette.themecolor,
                          buttontextcolor: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                child: StreamBuilder<List<TimetableScheduleModel>>(
                    stream: filterSubjectTimetable(),
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
                                              "Teacher",
                                              style: textStyle,
                                            ),
                                          ),
                                          DataColumn(
                                              label: Text(
                                            "Degree",
                                            style: textStyle,
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Semester",
                                            style: textStyle,
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Subject",
                                            style: textStyle,
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Date Time",
                                            style: textStyle,
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Status",
                                            style: textStyle,
                                          )),
                                          DataColumn(
                                              label: Text(
                                            "Action",
                                            style: textStyle,
                                          )),
                                        ],
                                        rows: [
                                          for (int i = 0;
                                              i < datamodel.length;
                                              i++)
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
                                                    child: FutureBuilder<
                                                            String>(
                                                        future: TeacherFutureMethods()
                                                            .teacher_name_get(
                                                                datamodel[i]
                                                                    .teacher_id),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            String teacherName =
                                                                snapshot.data!;

                                                            return Text(
                                                              teacherName,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "JosefinSans",
                                                              ),
                                                            );
                                                          } else {
                                                            return const Text(
                                                                "");
                                                          }
                                                        })),
                                              ),
                                              //degree name
                                              DataCell(
                                                SizedBox(
                                                    child: FutureBuilder<
                                                            String>(
                                                        future: TeacherFutureMethods()
                                                            .degree_name_get(
                                                                datamodel[i]
                                                                    .degree_id),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            String degreeName =
                                                                snapshot.data!;

                                                            return Text(
                                                              degreeName,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "JosefinSans",
                                                              ),
                                                            );
                                                          } else {
                                                            return const Text(
                                                                "");
                                                          }
                                                        })),
                                              ),
                                              //semester
                                              DataCell(
                                                SizedBox(
                                                    child: FutureBuilder<
                                                            String>(
                                                        future: TeacherFutureMethods()
                                                            .semester_name_get(
                                                                datamodel[i]
                                                                    .semester_id),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            String subjectName =
                                                                snapshot.data!;

                                                            return Text(
                                                              subjectName,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "JosefinSans",
                                                              ),
                                                            );
                                                          } else {
                                                            return const Text(
                                                                "");
                                                          }
                                                        })),
                                              ),
                                              //semester
                                              DataCell(
                                                SizedBox(
                                                    child: FutureBuilder<
                                                            String>(
                                                        future: TeacherFutureMethods()
                                                            .sunject_name_get(
                                                                datamodel[i]
                                                                    .subject_id),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            String subjectName =
                                                                snapshot.data!;

                                                            return Text(
                                                              subjectName,
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    "JosefinSans",
                                                              ),
                                                            );
                                                          } else {
                                                            return const Text(
                                                                "");
                                                          }
                                                        })),
                                              ),
                                              DataCell(
                                                SizedBox(
                                                  child: Text(
                                                    // DateFormat.yMd()
                                                    //     .add_jm()
                                                    //     .format(datamodel[i]
                                                    //         .scheduleDate
                                                    //         .toDate()),
                                                    datamodel[i].scheduleDate,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: "JosefinSans",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //status

                                              DataCell(
                                                datamodel[i].status == 0
                                                    ? SizedBox(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color: Palette
                                                                .themecolor,
                                                          ),
                                                          child: const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Text(
                                                                "Active",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      themewhitecolor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "JosefinSans",
                                                                ),
                                                              )),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color:
                                                                themeredcolor,
                                                          ),
                                                          child: const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              child: Text(
                                                                "Deactive",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      themewhitecolor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      "JosefinSans",
                                                                ),
                                                              )),
                                                        ),
                                                      ),
                                              ),

                                              //action
                                              DataCell(
                                                Row(
                                                  children: [
                                                    //active -- deactive
                                                    SizedBox(
                                                      child:
                                                          datamodel[i].status ==
                                                                  0
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    final timetablePro = Provider.of<
                                                                            SchedulePro>(
                                                                        context,
                                                                        listen:
                                                                            false);

                                                                    timetablePro.timetableStatusUpdateFunc(
                                                                        1,
                                                                        datamodel[i]
                                                                            .timetable_id);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            5),
                                                                      ),
                                                                      color:
                                                                          themegreencolor,
                                                                    ),
                                                                    child:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .auto_mode_rounded,
                                                                        size:
                                                                            18,
                                                                        color:
                                                                            themeblackcolor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    final timetablePro = Provider.of<
                                                                            SchedulePro>(
                                                                        context,
                                                                        listen:
                                                                            false);

                                                                    await timetablePro.timetableStatusUpdateFunc(
                                                                        0,
                                                                        datamodel[i]
                                                                            .timetable_id);

                                                                    //now calling the notificaiton function
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "student_auth")
                                                                        .where(
                                                                            'degree_id',
                                                                            isEqualTo: datamodel[i]
                                                                                .degree_id)
                                                                        .where(
                                                                            'semester_id',
                                                                            isEqualTo: datamodel[i]
                                                                                .semester_id)
                                                                        .get()
                                                                        .then(
                                                                            (value) async {
                                                                      value.docs
                                                                          .forEach(
                                                                              (doc) {
                                                                        studentsList.add(doc
                                                                            .data()["token"]
                                                                            .toString());
                                                                      });
                                                                    });
                                                                    debugPrint(
                                                                        "studentsList: $studentsList");
                                                                    // -- ADDING THE TEACHER ID TOO FOR THE NOTIFICATIONS
                                                                    await FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "teacher_auth")
                                                                        .where(
                                                                            'uid',
                                                                            isEqualTo: datamodel[i]
                                                                                .teacher_id)
                                                                        .get()
                                                                        .then(
                                                                            (value) async {
                                                                      value.docs
                                                                          .forEach(
                                                                              (doc) {
                                                                        studentsList.add(doc
                                                                            .data()["token"]
                                                                            .toString());
                                                                      });
                                                                    });

                                                                    debugPrint(
                                                                        "studentsList: $studentsList");
                                                                    final notificationPro = Provider.of<
                                                                            NotificationPro>(
                                                                        context,
                                                                        listen:
                                                                            false);

                                                                    await notificationPro.sendNotificationToMultipleDevices(
                                                                        studentsList,
                                                                        datamodel[i]
                                                                            .degree_id,
                                                                        datamodel[i]
                                                                            .semester_id,
                                                                        datamodel[i]
                                                                            .subject_id,
                                                                        datamodel[i]
                                                                            .teacher_id,
                                                                        "${datamodel[i].startTime} - ${datamodel[i].endTime}",
                                                                        datamodel[i]
                                                                            .scheduleDate,
                                                                        datamodel[i]
                                                                            .roomNo);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            5),
                                                                      ),
                                                                      color:
                                                                          themeredcolor,
                                                                    ),
                                                                    child:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .notifications_active_rounded,
                                                                        size:
                                                                            18,
                                                                        color:
                                                                            themewhitecolor,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    //details
                                                    SizedBox(
                                                      child: InkWell(
                                                        onTap: () async {},
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color: Palette
                                                                .themecolor,
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Icon(
                                                              Icons.info,
                                                              size: 18,
                                                              color:
                                                                  themewhitecolor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),

                                                    //delete
                                                    SizedBox(
                                                      child: InkWell(
                                                        onTap: () {
                                                          timetableDeleteDialog(
                                                              context,
                                                              size,
                                                              datamodel,
                                                              i);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                            color:
                                                                themeredcolor,
                                                          ),
                                                          child: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Icon(
                                                              Icons.delete,
                                                              size: 18,
                                                              color:
                                                                  themewhitecolor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
        ),
      ),
    );
  }

  Future<Object?> timetableDeleteDialog(BuildContext context, Size size,
      List<TimetableScheduleModel> datamodel, int i) {
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
                    width: size.width / 100 * 35,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10.0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Confirmation",
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
                          height: 20,
                        ),
                        const Text(
                          "Are you sure? you want to delete this timetable",
                          style: TextStyle(
                              color: themeblackcolor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
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
                                  final timetablePro = Provider.of<SchedulePro>(
                                      context,
                                      listen: false);
                                  timetablePro.timetableDeleteFunc(
                                      datamodel[i].timetable_id, context);
                                },
                                height: size.height / 100 * 5,
                                width: size.width / 100 * 16,
                                buttoncolor: themeredcolor,
                                buttontextcolor: themeprimarycolor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              CustomSimpleRoundedButton(
                                buttonText: "No",
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                height: size.height / 100 * 5,
                                width: size.width / 100 * 16,
                                buttoncolor: Palette.themecolor,
                                buttontextcolor: themeprimarycolor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ]),
                      ]),
                    )),
              ),
            ));
  }

  Stream<List<TimetableScheduleModel>> filterSubjectTimetable() =>
      FirebaseFirestore.instance
          .collection('subject_timetable')
          .orderBy('creationTime', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((document) =>
                  TimetableScheduleModel.fromJson(document.data()))
              .toList());

  int sno = 0;
  Widget Grid_data(DegreeModel _model) {
    sno++;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: Container(
        decoration: BoxDecoration(border: Border.all()),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${sno}",
                style: const TextStyle(fontSize: 18),
              ),
              // Expanded(child: VerticalDivider(thickness: 5,color: themeblackcolor,)),

              Text(
                _model.title,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                _model.date_time.toDate().toString(),
                style: const TextStyle(fontSize: 18),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Palette.themecolor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "view",
                    style: TextStyle(fontSize: 18, color: themeprimarycolor),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Palette.themecolor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Active",
                    style: TextStyle(fontSize: 20, color: themeprimarycolor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Grid_Header() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(), color: themegreycolor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "S.No",
                  style: TextStyle(fontSize: 20, color: Palette.themecolor),
                ),
                // Expanded(child: VerticalDivider(thickness: 5,color: themeblackcolor,)),

                const Text(
                  "Degree",
                  style: TextStyle(fontSize: 20, color: Palette.themecolor),
                ),
                const Text(
                  "Created Time",
                  style: TextStyle(fontSize: 20, color: Palette.themecolor),
                ),
                const Text(
                  "View",
                  style: TextStyle(fontSize: 20, color: Palette.themecolor),
                ),
                const Text(
                  "Status",
                  style: TextStyle(fontSize: 20, color: Palette.themecolor),
                ),
              ],
            ),
          ),
        ),
      );
}
