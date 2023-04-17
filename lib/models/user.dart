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

/*

PaginatedDataTable(
                sortColumnIndex: 0,
                sortAscending: sort,
                header: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Text(
                          "Distresses",
                          style: TextStyle(
                            fontSize: defaultSize * 1.8,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: "Search",
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: defaultSize
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: defaultSize,
                              vertical: defaultSize / 2
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: primaryColor),
                              gapPadding: 5
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: bluishClr),
                              gapPadding: 5
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            myData = filterData!
                                .where((element) => element.name!.contains(value))
                                .toList();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                source: RowSource(
                  myData: myData,
                  count: myData.length,
                ),
                rowsPerPage: 8,
                columnSpacing: 20,
                columns: [
                  DataColumn(
                      label: const Text(
                        "Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white
                        ),
                      ),
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          sort = !sort;
                        });

                        onsortColum(columnIndex, ascending);
                      }),
                  DataColumn(
                      label: const Text(
                        "Email",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white
                        ),
                      ),
                  ),
                  const DataColumn(
                    label: Text(
                      "Phone",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      "Location",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        color: Colors.white
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      "Distress Sent",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      "Response Time",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      "Status",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white
                      ),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      "Action",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.white
                      ),
                    ),
                  ),
                ],
              )
 */
