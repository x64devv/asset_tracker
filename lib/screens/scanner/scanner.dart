import 'dart:convert';
import 'dart:io';

import 'package:asset_tracker/services/web_services.dart';
import 'package:asset_tracker/ui/constants/theme_data.dart';
import 'package:asset_tracker/ui/widgets/pry_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../models/asset.dart';
import '../../models/unit.dart';
import '../../ui/utilities/size_config.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  Barcode? result;
  var info;
  Asset? asset;

  // @override
  // void dispose(){
  //   controller?.dispose();
  //   super.dispose();
  // }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await qrController!.pauseCamera();
    }
    qrController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_outlined)),
        title: Text("Add Asset"),
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultSize * 2),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                    width: defaultSize * 50,
                    height: defaultSize * 40,
                    child: buildQRView(context)),
              ),
              SizedBox(
                height: defaultSize * 2,
              ),
              buildResult(),
              SizedBox(
                height: defaultSize * 2,
              ),
              // FutureBuilder(
              //     future: unitData(),
              //     builder: (context, snapshot){
              //       if (snapshot.hasData) {
              //         return Text(
              //             '$snapshot'
              //         );
              //       } else if(snapshot.hasError){
              //         return Text(
              //             "Error"
              //         );
              //       }
              //       else {
              //         return SizedBox(
              //           width: defaultSize,
              //           height: defaultSize,
              //         );
              //       }
              //     }
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<String?> unitData() async{
  //   if(result != null){
  //     setState(() {
  //       info = result!.code;
  //       print(result!.code);
  //     });
  //   }
  //   return null;
  // }

  Widget buildResult() {
    double? defaultSize = SizeConfig.defaultSize!;
    if (result != null) {
      return Container(
        width: defaultSize * double.infinity,
        padding: EdgeInsets.only(
            top: defaultSize * 2,
            left: defaultSize * 2,
            right: defaultSize * 2,
            bottom: defaultSize),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.yellow.withOpacity(0.1),
                  offset: const Offset(0, 3),
                  blurRadius: 10)
            ]),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: defaultSize * 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Asset info"), Icon(Icons.info)],
              ),
              Divider(
                color: textColor.withOpacity(0.1),
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    asset!.name,
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Serial Number:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    asset!.serialNumber,
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Type:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    asset!.type,
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    asset!.location,
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Office:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    asset!.office,
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contact:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    asset!.phone,
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize * 2,
              ),
              PrimaryButton(
                label: "Add",
                onPressed: () {
                  Get.showOverlay(
                    asyncFunction: () async {
                      Map<String, dynamic> result =
                          await WebServices().addAsset(asset!.toMap());
                      if (result['status']) {
                        Get.showSnackbar(
                          const GetSnackBar(
                            duration: Duration(seconds: 3),
                            title: 'Success',
                            message: 'Asset Added Successfully!',
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        qrController!.resumeCamera();
                        Get.showSnackbar(
                          GetSnackBar(
                            duration: const Duration(seconds: 3),
                            title: 'Error',
                            message: result['message'],
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      return result['status'];
                    },
                    loadingWidget: const Center(
                        child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    )),
                  );
                },
                icon: Icons.arrow_forward,
              ),
              SizedBox(
                height: defaultSize * 2,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: defaultSize * double.infinity,
        padding: EdgeInsets.only(
            top: defaultSize * 2,
            left: defaultSize * 2,
            right: defaultSize * 2,
            bottom: defaultSize),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.yellow.withOpacity(0.1),
                  offset: const Offset(0, 3),
                  blurRadius: 10)
            ]),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: defaultSize * 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Asset info"), Icon(Icons.info)],
              ),
              Divider(
                color: textColor.withOpacity(0.1),
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Serial Number:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Type:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Office:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contact:",
                    style: TextStyle(
                        color: textColor,
                        fontSize: defaultSize * 1.6,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "",
                    style: TextStyle(
                      color: textColor,
                      fontSize: defaultSize * 1.6,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: defaultSize * 2,
              )
            ],
          ),
        ),
      );
    }
  }

  Widget buildQRView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 10,
          borderColor: bluishClr,
          // cutOutSize: MediaQuery.of(context).size.width
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      qrController = controller;
    });

    controller.scannedDataStream.listen((barcode) {
      final currentScan = DateTime.now();
      DateTime? lastScan;
      if (lastScan == null ||
          currentScan.difference(lastScan) > const Duration(seconds: 3)) {
        lastScan = currentScan;

        setState(() {
          result = barcode;
          // unit = Unit.fromJson(json.decode(result!.code.toString()));
          debugPrint(coloredText('[32m', result!.code.toString()));
          asset = Asset.fromScan(jsonDecode(result!.code.toString()));
          qrController!.stopCamera();
        });
      }
    });
  }

  String coloredText(String color, String text) {
    return '\x1B$color$text\x1B[0m';
  }
}
