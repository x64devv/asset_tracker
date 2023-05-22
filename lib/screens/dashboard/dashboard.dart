
import 'dart:io';

import 'package:asset_tracker/screens/activities/check_in_out.dart';
import 'package:asset_tracker/screens/activities/stats.dart';
import 'package:asset_tracker/services/web_services.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:asset_tracker/ui/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/asset.dart';
import '../../ui/utilities/routes.dart';
import '../../ui/utilities/size_config.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: defaultSize * double.infinity,
              height: defaultSize * 30,
              color: bluishClr,
              child: Column(
                children: [
                  SizedBox(
                    height: defaultSize * 10,
                  ),
                  CircleAvatar(
                    child: Image.asset("assets/logo/bcc.png"),
                    radius: 40,
                    backgroundColor: bluishClr.withOpacity(0.0),
                  ),
                  SizedBox(
                    height: defaultSize * 2,
                  ),
                  Text(
                    "BCC Assets Tracker",
                    style: TextStyle(color: Colors.white, fontSize: defaultSize * 2.4),
                  ),
                  SizedBox(
                    height: defaultSize * 0.5,
                  ),
                  Text(
                    "Admin",
                    style: TextStyle(color: Colors.white, fontSize: defaultSize * 1.8, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: defaultSize * 2,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(GetRoutes.scanner);
                        },
                        child: Container(
                          width: defaultSize * 17,
                          height: defaultSize * 10,
                          padding: EdgeInsets.only(top: defaultSize * 2, left: defaultSize * 2, right: defaultSize * 2, bottom: defaultSize),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Colors.yellow.withOpacity(0.1), offset: const Offset(0, 3), blurRadius: 10)]),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: defaultSize * 0.2,
                                ),
                                Icon(
                                  Icons.qr_code_scanner_outlined,
                                  color: bluishClr,
                                ),
                                SizedBox(
                                  height: defaultSize,
                                ),
                                Text(
                                  "Add Asset",
                                  style: TextStyle(color: textColor.withOpacity(0.5), fontSize: defaultSize * 1.6),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(GetRoutes.view_assets);
                        },
                        child: Container(
                          width: defaultSize * 17,
                          height: defaultSize * 10,
                          padding: EdgeInsets.only(top: defaultSize * 2, left: defaultSize * 2, right: defaultSize * 2, bottom: defaultSize),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Colors.yellow.withOpacity(0.1), offset: const Offset(0, 3), blurRadius: 10)]),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: defaultSize * 0.2,
                                ),
                                Icon(
                                  Icons.search,
                                  color: bluishClr,
                                ),
                                SizedBox(
                                  height: defaultSize,
                                ),
                                Text(
                                  "View Assets",
                                  style: TextStyle(color: textColor.withOpacity(0.5), fontSize: defaultSize * 1.6),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultSize * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.showOverlay(
                            asyncFunction: () => printAssets(),
                            loadingWidget: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: defaultSize * 17,
                          height: defaultSize * 10,
                          padding: EdgeInsets.only(top: defaultSize * 2, left: defaultSize * 2, right: defaultSize * 2, bottom: defaultSize),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Colors.yellow.withOpacity(0.1), offset: const Offset(0, 3), blurRadius: 10)]),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: defaultSize * 0.2,
                                ),
                                Icon(
                                  Icons.print,
                                  color: bluishClr,
                                ),
                                SizedBox(
                                  height: defaultSize,
                                ),
                                Text(
                                  "Print Assets",
                                  style: TextStyle(color: textColor.withOpacity(0.5), fontSize: defaultSize * 1.6),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckInOut(
                                // assets: snapshot.data!['assets'],
                                ),
                          ),
                        ),
                        child: Container(
                          width: defaultSize * 17,
                          height: defaultSize * 10,
                          padding: EdgeInsets.only(top: defaultSize * 2, left: defaultSize * 2, right: defaultSize * 2, bottom: defaultSize),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Colors.yellow.withOpacity(0.1), offset: const Offset(0, 3), blurRadius: 10)]),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: defaultSize * 0.2,
                                ),
                                Icon(
                                  Icons.compare_arrows,
                                  color: bluishClr,
                                ),
                                SizedBox(
                                  height: defaultSize,
                                ),
                                Text(
                                  "Check In/Out",
                                  style: TextStyle(color: textColor.withOpacity(0.5), fontSize: defaultSize * 1.6),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: defaultSize * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AssetsSats()));
                        },
                        child: Container(
                          width: defaultSize * 17,
                          height: defaultSize * 10,
                          padding: EdgeInsets.only(top: defaultSize * 2, left: defaultSize * 2, right: defaultSize * 2, bottom: defaultSize),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Colors.yellow.withOpacity(0.1), offset: const Offset(0, 3), blurRadius: 10)]),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: defaultSize * 0.2,
                                ),
                                Icon(
                                  Icons.stacked_line_chart,
                                  color: bluishClr,
                                ),
                                SizedBox(
                                  height: defaultSize,
                                ),
                                Text(
                                  "Statistics",
                                  style: TextStyle(color: textColor.withOpacity(0.5), fontSize: defaultSize * 1.6),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(GetRoutes.auth),
                        child: Container(
                          width: defaultSize * 17,
                          height: defaultSize * 10,
                          padding: EdgeInsets.only(top: defaultSize * 2, left: defaultSize * 2, right: defaultSize * 2, bottom: defaultSize),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(color: Colors.yellow.withOpacity(0.1), offset: const Offset(0, 3), blurRadius: 10)]),
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: defaultSize * 0.2,
                                ),
                                Icon(
                                  Icons.logout_outlined,
                                  color: bluishClr,
                                ),
                                SizedBox(
                                  height: defaultSize,
                                ),
                                Text(
                                  "Sign Out",
                                  style: TextStyle(color: textColor.withOpacity(0.5), fontSize: defaultSize * 1.6),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  printAssets() async {
    Map<String, dynamic> result = await WebServices().fetchAllAssets();
    List<Asset> assets = [];

    if (result['status']) {
      assets = result['assets'];
    }

    final pdf = pw.Document();

    PermissionStatus status = await Permission.storage.status;
    if(status.isGranted){
      pdf.addPage(
        pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Container(
                child: pw.Column(children: [
                  pw.Text(
                    "Name\t\tSerial Number\t\ttype\t\tUser's Name\t\tIn Use\t\tCondition\t\tLocation\t\tOffice\t\tPhone",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  ...List.generate(
                      assets.length,
                          (index) => pw.Text(
                        "${assets[index].name}\t\t${assets[index].serialNumber}\t\t${assets[index].type}\t\t${assets[index].user['name']} ${assets[index].user['lastname']}\t\t${assets[index].inUse}\t\t${assets[index].productCondition}\t\t${assets[index].location}\t\t${assets[index].office}\t\t${assets[index].phone}",
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ))
                ]),
              ); // Center
            }),
      ); //


      final file = File("assets.pdf");
      await file.writeAsBytes(await pdf.save());// Page

      Get.showSnackbar(GetSnackBar(duration: const Duration(seconds: 3), title: "Success", message: "File Saved successfully",),);
    } else{
      PermissionStatus requestStatus = await Permission.storage.request();
      // if(requestStatus.isGranted){
      //   printAssets();
      //   return;
      // }
      // Get.showSnackbar(GetSnackBar(duration: const Duration(seconds: 3), title: "Failed", message: "File not saved. Please grant permisions",),);
    }



  }
}
