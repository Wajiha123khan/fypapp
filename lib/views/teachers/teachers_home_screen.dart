import 'package:classchronicaladminweb/dashboard/config/responsive.dart';
import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/model/teacher_model.dart';
import 'package:classchronicaladminweb/provider/teacher_pro.dart';
import 'package:classchronicaladminweb/widget/customSimpleRoundedButtonWidget.dart';
import 'package:classchronicaladminweb/widget/customToastWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TeachersHomeScreen extends StatefulWidget {
  const TeachersHomeScreen({super.key});

  @override
  State<TeachersHomeScreen> createState() => _TeachersHomeScreenState();
}

class _TeachersHomeScreenState extends State<TeachersHomeScreen> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w600, color: Palette.themecolor, fontSize: 18);
  final formKey = GlobalKey<FormState>();
  TextEditingController teacherNameC = TextEditingController();
  TextEditingController teacherLastNameC = TextEditingController();
  TextEditingController teacherEmailC = TextEditingController();
  TextEditingController teacherPasswordC = TextEditingController();
  TextEditingController teacherDescriptionC = TextEditingController();

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
                children: [
                  const Text(
                    "Teacher's",
                    style: TextStyle(
                        color: Palette.themecolor,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                  CustomSimpleRoundedButton(
                      buttonText: "Create",
                      onTap: () {
                        showAnimatedDialog(
                            barrierDismissible: true,
                            animationType: DialogTransitionType.slideFromRight,
                            curve: Curves.fastOutSlowIn,
                            duration: const Duration(milliseconds: 400),
                            context: context,
                            builder: (context) => StatefulBuilder(
                                  builder: (context, setState) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    titlePadding: const EdgeInsets.all(24),
                                    actionsPadding: const EdgeInsets.all(0),
                                    buttonPadding: const EdgeInsets.all(0),
                                    title: SizedBox(
                                        width: size.width / 100 * 40,
                                        child: Form(
                                          key: formKey,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Create a New Teacher",
                                                    style: TextStyle(
                                                        color:
                                                            Palette.themecolor,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  CustomIconButton(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                          Icons.cancel))
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Consumer<TeacherPro>(builder:
                                                      ((context, modelValue,
                                                          child) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: InkWell(
                                                        onTap: () async {
                                                          modelValue
                                                              .pickTeacherImage();
                                                        },
                                                        child: modelValue
                                                                    .teacherImage !=
                                                                null
                                                            ? CircleAvatar(
                                                                radius: 50,
                                                                backgroundColor:
                                                                    Palette
                                                                        .themecolor,
                                                                backgroundImage:
                                                                    MemoryImage(
                                                                        modelValue
                                                                            .teacherImage!),
                                                              )
                                                            : const CircleAvatar(
                                                                radius: 50,
                                                                backgroundColor:
                                                                    Palette
                                                                        .themecolor,
                                                                child: Icon(
                                                                  Icons
                                                                      .subject_outlined,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 45,
                                                                ),
                                                              ),
                                                      ),
                                                    );
                                                  })),

                                                  const SizedBox(
                                                    height: 10,
                                                  ),

                                                  //firstname -- lastname
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width /
                                                            100 *
                                                            19.9,
                                                        child: TextFormField(
                                                          controller:
                                                              teacherNameC,
                                                          decoration: const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  "First Name"),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please Enter First Name';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: size.width /
                                                            100 *
                                                            19.9,
                                                        child: TextFormField(
                                                          controller:
                                                              teacherLastNameC,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  hintText:
                                                                      "Last Name"),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please Enter Last Name';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  //email -- password
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width /
                                                            100 *
                                                            19.9,
                                                        child: TextFormField(
                                                          controller:
                                                              teacherEmailC,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  hintText:
                                                                      "Email"),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please Enter Email';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: size.width /
                                                            100 *
                                                            19.9,
                                                        child: TextFormField(
                                                          controller:
                                                              teacherPasswordC,
                                                          obscureText: true,
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                  hintText:
                                                                      "Password"),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please Enter Password';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  //qualification
                                                  Container(
                                                    width:
                                                        size.width / 100 * 40,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                themegreytextcolor)),
                                                    child: TextFormField(
                                                      maxLines: 3,
                                                      controller:
                                                          teacherDescriptionC,
                                                      decoration:
                                                          const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "Qualification"),
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please Enter Qualification';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Consumer<TeacherPro>(builder:
                                                  ((context, modelValue,
                                                      child) {
                                                return CustomSimpleRoundedButton(
                                                  buttonText: "Create",
                                                  onTap: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      if (modelValue
                                                              .teacherImage !=
                                                          null) {
                                                        final teacherProvider =
                                                            Provider.of<
                                                                    TeacherPro>(
                                                                context,
                                                                listen: false);

                                                        teacherProvider
                                                            .addNewTeacherFunc(
                                                                modelValue
                                                                    .teacherImage!,
                                                                teacherNameC
                                                                    .text,
                                                                teacherLastNameC
                                                                    .text,
                                                                teacherEmailC
                                                                    .text,
                                                                teacherPasswordC
                                                                    .text,
                                                                teacherDescriptionC
                                                                    .text,
                                                                context);

                                                        //clearing variables
                                                        teacherNameC.clear();
                                                        teacherLastNameC
                                                            .clear();
                                                        teacherEmailC.clear();
                                                        teacherPasswordC
                                                            .clear();
                                                        teacherDescriptionC
                                                            .clear();
                                                        setState(() {
                                                          modelValue
                                                                  .teacherImage =
                                                              null;
                                                        });
                                                      } else {

                                                        showCustomToast(  "Select Teacher Image",context);
                                                      
                                                      }
                                                    }
                                                  },
                                                  height:
                                                      kMinInteractiveDimension,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.60,
                                                  buttoncolor:
                                                      Palette.themecolor,
                                                  buttontextcolor:
                                                      themeprimarycolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                );
                                              })),
                                            ],
                                          ),
                                        )),
                                  ),
                                ));
                      },
                      height: 50,
                      width: 150,
                      buttoncolor: Palette.themecolor,
                      buttontextcolor: Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: StreamBuilder<List<TeacherModel>>(
                stream: filterTeachers(),
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
                                          "First Name",
                                          style: textStyle,
                                        ),
                                      ),
                                      DataColumn(
                                          label: Text(
                                        "Last Name",
                                        style: textStyle,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Email",
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
                                                datamodel[i].first_name,
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
                                                datamodel[i].last_name,
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
                                                datamodel[i].email,
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
                                                  teacherDetailWidget(context,
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

  Future<Object?> teacherDetailWidget(
      BuildContext context, Size size, List<TeacherModel> datamodel, int i) {
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
                                "Teacher Details",
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
                          datamodel[i].profile != ""
                              ? Container(
                                  height: size.height / 100 * 20,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        datamodel[i].profile,
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
                                  "First name: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Text(
                                  datamodel[i].first_name,
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
                                  "Last name: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Text(
                                  datamodel[i].last_name,
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
                                  "Email: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Text(
                                  datamodel[i].email,
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
                                  "Qualification: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Text(
                                  datamodel[i].qualification,
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
                                  "About Teacher: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Text(
                                  datamodel[i].aboutMe,
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

  Stream<List<TeacherModel>> filterTeachers() => FirebaseFirestore.instance
      .collection('teacher_auth')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => TeacherModel.fromJson(document.data()))
          .toList());
}
