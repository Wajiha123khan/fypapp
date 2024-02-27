import 'package:classchronicaladminweb/dashboard/config/responsive.dart';
import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/model/degree_model.dart';
import 'package:classchronicaladminweb/provider/degree_pro.dart';
import 'package:classchronicaladminweb/widget/customSimpleRoundedButtonWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DegreeHomeScreen extends StatefulWidget {
  const DegreeHomeScreen({super.key});

  @override
  State<DegreeHomeScreen> createState() => _DegreeHomeScreenState();
}

class _DegreeHomeScreenState extends State<DegreeHomeScreen> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w600, color: Palette.themecolor, fontSize: 18);
  final formKey = GlobalKey<FormState>();

  TextEditingController degreeNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final proDegreeGet = Provider.of<DegreePro>(context);
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
                    "Degree's",
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
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: proDegreeGet.degreePostIsloading ==
                                              false
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Create a New Degree",
                                                        style: TextStyle(
                                                            color: Palette
                                                                .themecolor,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      CustomIconButton(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                              Icons.cancel))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Form(
                                                    key: formKey,
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                          controller:
                                                              degreeNameController,
                                                          decoration: const InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              hintText:
                                                                  "Degree Name"),
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'Please Enter Degree Name';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  CustomSimpleRoundedButton(
                                                    buttonText: "Create",
                                                    onTap: () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        final degreeProvider =
                                                            Provider.of<
                                                                    DegreePro>(
                                                                context,
                                                                listen: false);
                                                        degreeProvider
                                                            .createDegreeFunc(
                                                                degreeNameController
                                                                    .text,
                                                                context);
                                                        degreeNameController
                                                            .clear();
                                                      }
                                                    },
                                                    height:
                                                        kMinInteractiveDimension,
                                                    width:
                                                        MediaQuery.of(context)
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
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Center(
                                              child: Image.asset(
                                                  "assets/loader.gif"),
                                            ),
                                    ),
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
            child: StreamBuilder<List<DegreeModel>>(
                stream: filterDegrees(),
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
                                        "Create Time",
                                        style: textStyle,
                                      )),
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
                                                  degreeDetailWidget(context,
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

  Future<Object?> degreeDetailWidget(
      BuildContext context, Size size, List<DegreeModel> datamodel, int i) {
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
                                "Degree Details",
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
                          // datamodel[i].card != ""
                          //     ? Container(
                          //         height: size.height / 100 * 20,
                          //         width: size.width,
                          //         decoration: BoxDecoration(
                          //           image: DecorationImage(
                          //             image: NetworkImage(
                          //               datamodel[i].card,
                          //             ),
                          //             fit: BoxFit.cover,
                          //           ),
                          //           borderRadius: const BorderRadius.vertical(
                          //             top: Radius.circular(20),
                          //           ),
                          //         ),
                          //       )
                          //     : Container(
                          //         height: size.height / 100 * 20,
                          //         width: size.width,
                          //         decoration: BoxDecoration(
                          //           color: themegreycolor,
                          //           borderRadius: BorderRadius.circular(30),
                          //         ),
                          //         child: Image.asset(
                          //           "assets/png/no-cover.png",
                          //           fit: BoxFit.fill,
                          //         ),
                          //       ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Degree Title: ",
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
                                  "Degree Id: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Text(
                                  datamodel[i].degree_id,
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

  Stream<List<DegreeModel>> filterDegrees() => FirebaseFirestore.instance
      .collection('degree')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => DegreeModel.fromJson(document.data()))
          .toList());
}
