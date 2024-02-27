
import 'package:classchronicaladminweb/dashboard/style/theme_colors.dart';
import 'package:classchronicaladminweb/views/quries/helpcenter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../dashboard/config/responsive.dart';

class QueriesScreen extends StatefulWidget {
  const QueriesScreen({super.key});

  @override
  State<QueriesScreen> createState() => _QueriesScreenState();
}

class _QueriesScreenState extends State<QueriesScreen> {
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
                    "Querie's",
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
            child: StreamBuilder<List<HelpCenter_Model>>(
                stream: filter(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final datamodel = snapshot.data!;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          border: TableBorder.all(
                            color: Colors.grey.shade200,
                          ),
                          decoration: BoxDecoration(
                              color: themewhitecolor,
                              border: Border.all(color: Colors.grey.shade200)),
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => themewhitecolor),
                          columns: [
                            DataColumn(
                                label: Container(
                              decoration: const BoxDecoration(),
                              child: Text(
                                Responsive.isDesktop(context) ? "S.No" : "#",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Palette.themecolor,
                                    fontSize: 18),
                              ),
                            )),
                            DataColumn(
                                label: Text(
                              "Username",
                              style: textStyle,
                            )),
                            DataColumn(
                                label: Text(
                              "Subject",
                              style: textStyle,
                            )),
                            DataColumn(
                                label: Text(
                              "Query",
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
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    child: Text(
                                      datamodel[i].username,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: themeblackcolor,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    child: Text(
                                      datamodel[i].subject,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: themeblackcolor,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        100 *
                                        10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        datamodel[i].question,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: themeblackcolor,
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
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                          color: Palette.themecolor,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(5.0),
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

  Stream<List<HelpCenter_Model>> filter() => FirebaseFirestore.instance
      .collection('help_center')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((document) => HelpCenter_Model.fromJson(document.data()))
          .toList());
}
