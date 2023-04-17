import 'package:shared_preferences/shared_preferences.dart';

class User {
  /*
  "id": "3",
      "name": "caroe",
      "lastname": "dube",
      "email": "caroe@bcc.com",
      "password": "$2y$10$4CDoqKlJw2mCnD97IsMMlemOhYaAs9qro0v5CmiNAxyiXtMCL/Rbu",
      "phone": "12345678",
      "gender": "nale",
      "date_of_birth": "2022-01-01"*/

  final String id;
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final String gender;
  final String dateOfBirth;

  User(
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.gender,
    this.dateOfBirth,
  );

  factory User.fromJson(Map<String, dynamic> userData) {
    return User(
      userData['id'],
      userData['name'],
      userData['lastname'],
      userData['email'],
      userData['password'],
      userData['phone'],
      userData['gender'],
      userData['date_of_birth'],
    );
  }

  static toPrefs(Map<String, dynamic> userData, SharedPreferences prefs) {
    String user = '"pad":"pad"';
    for (String key in userData.keys) {
      user = ', "$user": "${userData[key]}"';
    }
    prefs.setString('user', user);
  }

  static filterByName(String name, List<User> users) {
    List<User> positives = [];
    for (User user in users) {
      String fullName = '${user.name} ${user.lastName}';
      fullName.contains(name) ? positives.add(user) : null;
    }
    return positives;
  }
}
