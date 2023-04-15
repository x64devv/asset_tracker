import 'package:asset_tracker/screens/activities/check_in_out.dart';
import 'package:asset_tracker/screens/activities/stats.dart';
import 'package:asset_tracker/services/web_services.dart';
import 'package:asset_tracker/ui/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ui/utilities/routes.dart';
import '../../ui/utilities/size_config.dart';

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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: defaultSize * 2.4),
                            ),
                            SizedBox(
                              height: defaultSize * 0.5,
                            ),
                            Text(
                              "Admin",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: defaultSize * 1.8,
                                  fontStyle: FontStyle.italic),
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
                                              color:
                                                  Colors.yellow.withOpacity(0.1),
                                              offset: const Offset(0, 3),
                                              blurRadius: 10)
                                        ]),
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
                                            style: TextStyle(
                                                color: textColor.withOpacity(0.5),
                                                fontSize: defaultSize * 1.6),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: defaultSize * 17,
                                  height: defaultSize * 10,
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
                                        Icon(
                                          Icons.search,
                                          color: bluishClr,
                                        ),
                                        SizedBox(
                                          height: defaultSize,
                                        ),
                                        Text(
                                          "View Assets",
                                          style: TextStyle(
                                              color: textColor.withOpacity(0.5),
                                              fontSize: defaultSize * 1.6),
                                        )
                                      ],
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
                                Container(
                                  width: defaultSize * 17,
                                  height: defaultSize * 10,
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
                                        Icon(
                                          Icons.print,
                                          color: bluishClr,
                                        ),
                                        SizedBox(
                                          height: defaultSize,
                                        ),
                                        Text(
                                          "Print Assets",
                                          style: TextStyle(
                                              color: textColor.withOpacity(0.5),
                                              fontSize: defaultSize * 1.6),
                                        )
                                      ],
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
                                              color:
                                                  Colors.yellow.withOpacity(0.1),
                                              offset: const Offset(0, 3),
                                              blurRadius: 10)
                                        ]),
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
                                            style: TextStyle(
                                                color: textColor.withOpacity(0.5),
                                                fontSize: defaultSize * 1.6),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AssetsSats()));
                                  },
                                  child: Container(
                                    width: defaultSize * 17,
                                    height: defaultSize * 10,
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
                                              color:
                                                  Colors.yellow.withOpacity(0.1),
                                              offset: const Offset(0, 3),
                                              blurRadius: 10)
                                        ]),
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
                                            style: TextStyle(
                                                color: textColor.withOpacity(0.5),
                                                fontSize: defaultSize * 1.6),
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
                                              color:
                                                  Colors.yellow.withOpacity(0.1),
                                              offset: const Offset(0, 3),
                                              blurRadius: 10)
                                        ]),
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
                                            style: TextStyle(
                                                color: textColor.withOpacity(0.5),
                                                fontSize: defaultSize * 1.6),
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
                  )
                ,
      // FutureBuilder(
      //       future: WebServices().fetchAllAssets(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           if (snapshot.data!['status']) {
      //             return Column(
      //               children: [
      //                 Container(
      //                   width: defaultSize * double.infinity,
      //                   height: defaultSize * 30,
      //                   color: bluishClr,
      //                   child: Column(
      //                     children: [
      //                       SizedBox(
      //                         height: defaultSize * 10,
      //                       ),
      //                       CircleAvatar(
      //                         child: Image.asset("assets/logo/bcc.png"),
      //                         radius: 40,
      //                         backgroundColor: bluishClr.withOpacity(0.0),
      //                       ),
      //                       SizedBox(
      //                         height: defaultSize * 2,
      //                       ),
      //                       Text(
      //                         "BCC Assets Tracker",
      //                         style: TextStyle(
      //                             color: Colors.white,
      //                             fontSize: defaultSize * 2.4),
      //                       ),
      //                       SizedBox(
      //                         height: defaultSize * 0.5,
      //                       ),
      //                       Text(
      //                         "Admin",
      //                         style: TextStyle(
      //                             color: Colors.white,
      //                             fontSize: defaultSize * 1.8,
      //                             fontStyle: FontStyle.italic),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: defaultSize * 2,
      //                 ),
      //                 Container(
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                         children: [
      //                           GestureDetector(
      //                             onTap: () {
      //                               Get.toNamed(GetRoutes.scanner);
      //                             },
      //                             child: Container(
      //                               width: defaultSize * 17,
      //                               height: defaultSize * 10,
      //                               padding: EdgeInsets.only(
      //                                   top: defaultSize * 2,
      //                                   left: defaultSize * 2,
      //                                   right: defaultSize * 2,
      //                                   bottom: defaultSize),
      //                               decoration: BoxDecoration(
      //                                   color: Colors.white,
      //                                   borderRadius: BorderRadius.circular(10),
      //                                   boxShadow: [
      //                                     BoxShadow(
      //                                         color:
      //                                             Colors.yellow.withOpacity(0.1),
      //                                         offset: const Offset(0, 3),
      //                                         blurRadius: 10)
      //                                   ]),
      //                               child: Center(
      //                                 child: Column(
      //                                   children: [
      //                                     SizedBox(
      //                                       height: defaultSize * 0.2,
      //                                     ),
      //                                     Icon(
      //                                       Icons.qr_code_scanner_outlined,
      //                                       color: bluishClr,
      //                                     ),
      //                                     SizedBox(
      //                                       height: defaultSize,
      //                                     ),
      //                                     Text(
      //                                       "Add Asset",
      //                                       style: TextStyle(
      //                                           color: textColor.withOpacity(0.5),
      //                                           fontSize: defaultSize * 1.6),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                           Container(
      //                             width: defaultSize * 17,
      //                             height: defaultSize * 10,
      //                             padding: EdgeInsets.only(
      //                                 top: defaultSize * 2,
      //                                 left: defaultSize * 2,
      //                                 right: defaultSize * 2,
      //                                 bottom: defaultSize),
      //                             decoration: BoxDecoration(
      //                                 color: Colors.white,
      //                                 borderRadius: BorderRadius.circular(10),
      //                                 boxShadow: [
      //                                   BoxShadow(
      //                                       color: Colors.yellow.withOpacity(0.1),
      //                                       offset: const Offset(0, 3),
      //                                       blurRadius: 10)
      //                                 ]),
      //                             child: Center(
      //                               child: Column(
      //                                 children: [
      //                                   SizedBox(
      //                                     height: defaultSize * 0.2,
      //                                   ),
      //                                   Icon(
      //                                     Icons.search,
      //                                     color: bluishClr,
      //                                   ),
      //                                   SizedBox(
      //                                     height: defaultSize,
      //                                   ),
      //                                   Text(
      //                                     "View Assets",
      //                                     style: TextStyle(
      //                                         color: textColor.withOpacity(0.5),
      //                                         fontSize: defaultSize * 1.6),
      //                                   )
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       SizedBox(
      //                         height: defaultSize * 2,
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                         children: [
      //                           Container(
      //                             width: defaultSize * 17,
      //                             height: defaultSize * 10,
      //                             padding: EdgeInsets.only(
      //                                 top: defaultSize * 2,
      //                                 left: defaultSize * 2,
      //                                 right: defaultSize * 2,
      //                                 bottom: defaultSize),
      //                             decoration: BoxDecoration(
      //                                 color: Colors.white,
      //                                 borderRadius: BorderRadius.circular(10),
      //                                 boxShadow: [
      //                                   BoxShadow(
      //                                       color: Colors.yellow.withOpacity(0.1),
      //                                       offset: const Offset(0, 3),
      //                                       blurRadius: 10)
      //                                 ]),
      //                             child: Center(
      //                               child: Column(
      //                                 children: [
      //                                   SizedBox(
      //                                     height: defaultSize * 0.2,
      //                                   ),
      //                                   Icon(
      //                                     Icons.print,
      //                                     color: bluishClr,
      //                                   ),
      //                                   SizedBox(
      //                                     height: defaultSize,
      //                                   ),
      //                                   Text(
      //                                     "Print Assets",
      //                                     style: TextStyle(
      //                                         color: textColor.withOpacity(0.5),
      //                                         fontSize: defaultSize * 1.6),
      //                                   )
      //                                 ],
      //                               ),
      //                             ),
      //                           ),
      //                           GestureDetector(
      //                             onTap: () => Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                 builder: (context) => CheckInOut(
      //                                   assets: snapshot.data!['assets'],
      //                                 ),
      //                               ),
      //                             ),
      //                             child: Container(
      //                               width: defaultSize * 17,
      //                               height: defaultSize * 10,
      //                               padding: EdgeInsets.only(
      //                                   top: defaultSize * 2,
      //                                   left: defaultSize * 2,
      //                                   right: defaultSize * 2,
      //                                   bottom: defaultSize),
      //                               decoration: BoxDecoration(
      //                                   color: Colors.white,
      //                                   borderRadius: BorderRadius.circular(10),
      //                                   boxShadow: [
      //                                     BoxShadow(
      //                                         color:
      //                                             Colors.yellow.withOpacity(0.1),
      //                                         offset: const Offset(0, 3),
      //                                         blurRadius: 10)
      //                                   ]),
      //                               child: Center(
      //                                 child: Column(
      //                                   children: [
      //                                     SizedBox(
      //                                       height: defaultSize * 0.2,
      //                                     ),
      //                                     Icon(
      //                                       Icons.compare_arrows,
      //                                       color: bluishClr,
      //                                     ),
      //                                     SizedBox(
      //                                       height: defaultSize,
      //                                     ),
      //                                     Text(
      //                                       "Check In/Out",
      //                                       style: TextStyle(
      //                                           color: textColor.withOpacity(0.5),
      //                                           fontSize: defaultSize * 1.6),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       SizedBox(
      //                         height: defaultSize * 2,
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                         children: [
      //                           GestureDetector(
      //                             onTap: () {
      //                               Navigator.push(
      //                                 context,
      //                                 MaterialPageRoute(
      //                                   builder: ((context) => AssetsSats(
      //                                       assets: snapshot.data!['assets'])),
      //                                 ),
      //                               );
      //                             },
      //                             child: Container(
      //                               width: defaultSize * 17,
      //                               height: defaultSize * 10,
      //                               padding: EdgeInsets.only(
      //                                   top: defaultSize * 2,
      //                                   left: defaultSize * 2,
      //                                   right: defaultSize * 2,
      //                                   bottom: defaultSize),
      //                               decoration: BoxDecoration(
      //                                   color: Colors.white,
      //                                   borderRadius: BorderRadius.circular(10),
      //                                   boxShadow: [
      //                                     BoxShadow(
      //                                         color:
      //                                             Colors.yellow.withOpacity(0.1),
      //                                         offset: const Offset(0, 3),
      //                                         blurRadius: 10)
      //                                   ]),
      //                               child: Center(
      //                                 child: Column(
      //                                   children: [
      //                                     SizedBox(
      //                                       height: defaultSize * 0.2,
      //                                     ),
      //                                     Icon(
      //                                       Icons.stacked_line_chart,
      //                                       color: bluishClr,
      //                                     ),
      //                                     SizedBox(
      //                                       height: defaultSize,
      //                                     ),
      //                                     Text(
      //                                       "Statistics",
      //                                       style: TextStyle(
      //                                           color: textColor.withOpacity(0.5),
      //                                           fontSize: defaultSize * 1.6),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                           GestureDetector(
      //                             onTap: () => Get.toNamed(GetRoutes.auth),
      //                             child: Container(
      //                               width: defaultSize * 17,
      //                               height: defaultSize * 10,
      //                               padding: EdgeInsets.only(
      //                                   top: defaultSize * 2,
      //                                   left: defaultSize * 2,
      //                                   right: defaultSize * 2,
      //                                   bottom: defaultSize),
      //                               decoration: BoxDecoration(
      //                                   color: Colors.white,
      //                                   borderRadius: BorderRadius.circular(10),
      //                                   boxShadow: [
      //                                     BoxShadow(
      //                                         color:
      //                                             Colors.yellow.withOpacity(0.1),
      //                                         offset: const Offset(0, 3),
      //                                         blurRadius: 10)
      //                                   ]),
      //                               child: Center(
      //                                 child: Column(
      //                                   children: [
      //                                     SizedBox(
      //                                       height: defaultSize * 0.2,
      //                                     ),
      //                                     Icon(
      //                                       Icons.logout_outlined,
      //                                       color: bluishClr,
      //                                     ),
      //                                     SizedBox(
      //                                       height: defaultSize,
      //                                     ),
      //                                     Text(
      //                                       "Sign Out",
      //                                       style: TextStyle(
      //                                           color: textColor.withOpacity(0.5),
      //                                           fontSize: defaultSize * 1.6),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             );
      //           }
      //           return Center(
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text("Ooops: ${snapshot.data!['message']}"),
      //                 TextButton(
      //                     onPressed: () {
      //                       setState(() {});
      //                     },
      //                     child: Text('Reload')),
      //               ],
      //             ),
      //           );
      //         } else if (snapshot.hasError) {
      //           return Center(
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text("Ooopsi: ${snapshot.error.toString()}"),
      //                 TextButton(
      //                     onPressed: () {
      //                       setState(() {});
      //                     },
      //                     child: const Text('Reload')),
      //               ],
      //             ),
      //           );
      //         }
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }),
      ),
    );
  }


}
