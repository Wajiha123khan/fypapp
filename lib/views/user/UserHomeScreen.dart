import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/views/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../dashboard/config/responsive.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w600, color: Palette.themecolor, fontSize: 18);
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
                    "User's",
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
            child: StreamBuilder<List<User_Model>>(
                stream: filter(),
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
                              color: themewhitecolor,
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
                                        "Email",
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
                                                datamodel[i].full_name,
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
                                          DataCell(InkWell(
                                            onTap: () {},
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                color: themegreencolor,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Text(
                                                  datamodel[i].status == 0
                                                      ? " Active "
                                                      : "Deactive",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: themewhitecolor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
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

  Stream<List<User_Model>> filter() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => User_Model.fromJson(document.data()))
          .toList());
}
