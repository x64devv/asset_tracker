import 'package:asset_tracker/screens/activities/check_in_out.dart';
import 'package:asset_tracker/screens/activities/view_assets.dart';
import 'package:asset_tracker/screens/auth/auth.dart';
import 'package:asset_tracker/screens/dashboard/dashboard.dart';
import 'package:asset_tracker/screens/scanner/scanner.dart';
import 'package:get/get.dart';

import '../../screens/activities/stats.dart';

class GetRoutes{
  static const String auth = '/auth';
  static const String dashboard = '/dashboard';
  static const String scanner = '/scanner';
  static const String stats = '/stats';
  static const String check_in_out = '/check_in_out';
  static const String view_assets = '/view_assets';

  static List<GetPage> routes = [
    GetPage(
        name: auth,
        page: () => Authentication()
    ),
    GetPage(
        name: dashboard,
        page: () => Dashboard()
    ),
    GetPage(
        name: scanner,
        page: () => Scanner()
    ),
    GetPage(
        name: view_assets,
        page: () => ViewAssets()
    ),
    // GetPage(
    //     name: stats,
    //     page: () => AssetsSats(assets: [],)
    // ),
    // GetPage(
    //     name: check_in_out,
    //     page: () => CheckInOut(assets: [],)
    // ),
  ];
}