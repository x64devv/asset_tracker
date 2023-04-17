import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as client;

import '../models/asset.dart';
import '../models/user.dart';

class WebServices {
  final _url = Uri.https('caroe.hoolixyz.io', 'app-api.php'); //app api url
  final Red = '[31m';
  final Green = '[32m';
  final Yellow = '[33m';

  String coloredText(String color, String text) {
    return '\x1B$color$text\x1B[0m';
  }

  Map<String, dynamic> _traceError(String msg) {
    return {
      'status': false,
      'message': "Something went wrong, returned $msg",
    };
  }

//this is the the function for signign in an admin into the app
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      var response = await client.post(_url, body: {
        'sign_in': '1',
        'email': email,
        'password': password,
      });

      if (response.statusCode != 200) {
        return _traceError(
            "Something went wrong, returned ${response.statusCode}");
      }

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] != 'success') {
        return _traceError(jsonResponse['message']);
      }

      return {
        'status': true,
        'message': 'success',
        'user': jsonResponse['user'],
      };
    } catch (e, stacktrace) {
      debugPrint(coloredText(Red, stacktrace.toString()));
      return _traceError(e.toString());
    }
  }

//this is a method for fetching all assets for statistics
  Future<Map<String, dynamic>> fetchAllAssets() async {
    try {
      var respone = await client.post(
        _url,
        body: {
          "get_assets": '1',
        },
      );

      if (respone.statusCode != 200) {
        return _traceError("Something happened, returned${respone.statusCode}");
      }

      Map<String, dynamic> jsonResponse = jsonDecode(respone.body);
      if (jsonResponse['status'] != 'success') {
        return _traceError(jsonResponse['message']);
      }

      debugPrint("===================================");
      debugPrint(coloredText(Green, respone.body.toString()));
      debugPrint("===================================");

      var jsonAssets = jsonResponse['assets'];
      return {
        'status': true,
        'message': 'success',
        'assets': mapToAssets(jsonAssets),
      };
    } catch (e, stacktrace) {
      debugPrint(coloredText(Red, stacktrace.toString()));
      return _traceError(e.toString());
    }
  }

// this is a method for adding Asset to the user
  Future<Map<String, dynamic>> addAsset(Map<String, dynamic> assetData) async {
    assetData.addAll({'add_asset': '1'});
    try {
      var response = await client.post(
        _url,
        body: assetData,
      );

      if (response.statusCode != 200) {
        return _traceError(
            "Something happened, returned ${response.statusCode}");
      }

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] != 'success') {
        return _traceError(jsonResponse['message']);
      }

      return {
        'status': true,
        'message': 'Success',
      };
    } catch (e, stacktrace) {
      debugPrint(coloredText(Red, stacktrace.toString()));
      return _traceError(e.toString());
    }
  }

//this is a method for getting all asset users
  Future<Map<String, dynamic>> getUsers() async {
    try {
      var response = await client.post(_url, body: {'get_users': '2'});
      if (response.statusCode != 200) {
        return _traceError(
            "Something happended, returned ${response.statusCode}");
      }

      debugPrint("===================================");
      debugPrint(coloredText(Green, response.body.toString()));
      debugPrint("===================================");

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] != 'success') {
        return _traceError(jsonResponse['message']);
      }

      return {
        'status': true,
        'message': "Success",
        'users': mapToUser(jsonResponse['users']),
      };
    } catch (e, stackTrace) {
      debugPrint(coloredText(Red, stackTrace.toString()));
      return _traceError(e.toString());
    }
  }

//this is a method for adding an asset to a user
  Future<Map<String, dynamic>> addAssetToUser(
      String userId, String assetId) async {
    try {
      var response = await client.post(
        _url,
        body: {
          'add_asset_to_user': 'i',
          'user_id': userId,
          'asset_id': assetId,
        },
      );

      if (response.statusCode != 200) {
        return _traceError(
            "Something happened, returned ${response.statusCode}");
      }

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] != 'success') {
        return _traceError(jsonResponse['message']);
      }

      return {
        'status': true,
        'message': 'success',
      };
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      return _traceError(e.toString());
    }
  }

//this is a method for removing an asset to a user
  Future<Map<String, dynamic>> removeAssetFromUser(
      String userId, String assetId) async {
    try {
      var response = await client.post(
        _url,
        body: {
          'remove_asset_from_user': 'i',
          'user_id': userId,
          'asset_id': assetId,
        },
      );

      if (response.statusCode != 200) {
        return _traceError(
            "Something happened, returned ${response.statusCode}");
      }

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status'] != 'success') {
        return _traceError(jsonResponse['message']);
      }

      return {
        'status': true,
        'message': 'success',
      };
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      return _traceError(e.toString());
    }
  }

//this is a method for mapping asset json data to respective model
  List<Asset> mapToAssets(List data) {
     if (data.isEmpty) {
      return [];
    }
    List<Asset> assets = [];
    for (Map<String, dynamic> item in data) {
      assets.add(Asset.fromJson(item));
    }
    return assets;
  }

//this is a method for a user json data to respective model
  List<User> mapToUser(List data) {
    if (data.isEmpty) {
      return [];
    }
    List<User> users = [];
    for (Map<String, dynamic> item in data) {
      users.add(User.fromJson(item));
    }
    return users;
  }
}
