import 'package:asset_tracker/ui/widgets/reload_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/asset.dart';
import '../../services/web_services.dart';
import '../../ui/constants/theme_data.dart';
import '../../ui/utilities/size_config.dart';

class AssetsSats extends StatefulWidget {
  const AssetsSats({
    Key? key,
  }) : super(key: key);
  // final List<Asset> assets;

  @override
  State<AssetsSats> createState() => _AssetsSatsState();
}

class _AssetsSatsState extends State<AssetsSats> {
  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_outlined)),
        title: Text("Assets Statistics"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.print))],
      ),
      body: FutureBuilder(
        future: WebServices().fetchAllAssets(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data!['status']) {
              return ReloadPage(
                erroMsg: snapshot.data!['message'],
                onTap: () {
                  setState(() {});
                },
              );
            }
            List<Asset> assets = snapshot.data!['assets'];
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(defaultSize * 2),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: defaultSize * double.infinity,
                        height: defaultSize * 15,
                        padding: EdgeInsets.only(
                            top: defaultSize * 2,
                            left: defaultSize * 2,
                            right: defaultSize * 2,
                            bottom: defaultSize),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  bluishClr.withOpacity(0.5),
                                  bluishClr
                                ]),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.laptop,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: defaultSize,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Laptops",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: defaultSize * 3,
                                    ),
                                  ),
                                  Text(
                                    Asset.filterType(
                                            "laptop", assets)
                                        .length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: defaultSize * 5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 2,
                      ),
                      Container(
                        width: defaultSize * double.infinity,
                        height: defaultSize * 15,
                        padding: EdgeInsets.only(
                            top: defaultSize * 2,
                            left: defaultSize * 2,
                            right: defaultSize * 2,
                            bottom: defaultSize),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.lightBlueAccent.withOpacity(0.5),
                                  Colors.lightBlueAccent
                                ]),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.desktop_mac_outlined,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: defaultSize,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Desktops",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: defaultSize * 3,
                                    ),
                                  ),
                                  Text(
                                    Asset.filterType("desktop", assets)
                                        .length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: defaultSize * 5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 2,
                      ),
                      Container(
                        width: defaultSize * double.infinity,
                        height: defaultSize * 15,
                        padding: EdgeInsets.only(
                            top: defaultSize * 2,
                            left: defaultSize * 2,
                            right: defaultSize * 2,
                            bottom: defaultSize),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  bluishClr.withOpacity(0.5),
                                  bluishClr
                                ]),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.print,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: defaultSize,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Printers",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: defaultSize * 3,
                                    ),
                                  ),
                                  Text(
                                    Asset.filterType("printer", assets)
                                        .length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: defaultSize * 5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 2,
                      ),
                      Container(
                        width: defaultSize * double.infinity,
                        height: defaultSize * 15,
                        padding: EdgeInsets.only(
                            top: defaultSize * 2,
                            left: defaultSize * 2,
                            right: defaultSize * 2,
                            bottom: defaultSize),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.lightBlueAccent.withOpacity(0.5),
                                  Colors.lightBlueAccent
                                ]),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.adf_scanner_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: defaultSize,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Scanners",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: defaultSize * 3,
                                    ),
                                  ),
                                  Text(
                                    Asset.filterType("scanner", assets)
                                        .length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: defaultSize * 5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 2,
                      ),
                      Container(
                        width: defaultSize * double.infinity,
                        height: defaultSize * 15,
                        padding: EdgeInsets.only(
                            top: defaultSize * 2,
                            left: defaultSize * 2,
                            right: defaultSize * 2,
                            bottom: defaultSize),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  bluishClr.withOpacity(0.5),
                                  bluishClr
                                ]),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.pages_rounded,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: defaultSize,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Projectors",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: defaultSize * 3,
                                    ),
                                  ),
                                  Text(
                                    Asset.filterType("projector", assets)
                                        .length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: defaultSize * 5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 2,
                      ),
                      Container(
                        width: defaultSize * double.infinity,
                        height: defaultSize * 15,
                        padding: EdgeInsets.only(
                            top: defaultSize * 2,
                            left: defaultSize * 2,
                            right: defaultSize * 2,
                            bottom: defaultSize),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.lightBlueAccent.withOpacity(0.5),
                                  Colors.lightBlueAccent
                                ]),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.phone_android_sharp,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: defaultSize,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "VoIP Phones",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: defaultSize * 3,
                                    ),
                                  ),
                                  Text(
                                    Asset.filterType("voip-phone", assets)
                                        .length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: defaultSize * 5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: defaultSize * 2,
                      ),
                      Container(
                        width: defaultSize * double.infinity,
                        height: defaultSize * 15,
                        padding: EdgeInsets.only(
                            top: defaultSize * 2,
                            left: defaultSize * 2,
                            right: defaultSize * 2,
                            bottom: defaultSize),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  bluishClr.withOpacity(0.5),
                                  bluishClr
                                ]),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.tablet,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: defaultSize,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tablets",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: defaultSize * 3,
                                    ),
                                  ),
                                  Text(
                                    Asset.filterType("tablet", assets)
                                        .length
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: defaultSize * 5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return ReloadPage(
                erroMsg: snapshot.error.toString(),
                onTap: () {
                  setState(() {});
                });
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
