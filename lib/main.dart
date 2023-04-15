import 'dart:ui';

import 'package:asset_tracker/screens/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'ui/utilities/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);
  runApp(const AssetTracker());
}

class AssetTracker extends StatelessWidget {
  const AssetTracker({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      title: 'Asset Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: GetRoutes.auth,
      getPages: GetRoutes.routes,
    );
  }
}

class InitialBinding implements Bindings{
  @override
  void dependencies() {
    // Get.lazyPut(() => AuthenticationController(), fenix: true);
  }
}
