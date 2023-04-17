import 'package:asset_tracker/services/web_services.dart';
import 'package:asset_tracker/ui/constants/theme_data.dart';
import 'package:asset_tracker/ui/widgets/custom_form_text_field.dart';
import 'package:asset_tracker/ui/widgets/pry_btn.dart';
import 'package:asset_tracker/ui/widgets/reload_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/asset.dart';
import '../../models/user.dart';
import '../../ui/utilities/size_config.dart';

class CheckInOut extends StatefulWidget {
  const CheckInOut({
    Key? key,
  }) : super(key: key);
  // final List<Asset> assets;

  @override
  State<CheckInOut> createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> {
  bool assetsLoaded = false;
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_outlined)),
        title: Text("Check In/Out"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SearchSheet(
                      type: "user",
                      users: users,
                    );
                  });
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultSize * 2),
          child: FutureBuilder(
            future: WebServices().getUsers(),
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
                users = snapshot.data!['users'];
                if (snapshot.data!['status']) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ...List.generate(users.length, (index) {
                          return UserTile(
                            user: users[index],
                            assets: [],
                            defaultSize: defaultSize,
                          );
                        })
                      ],
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Ooops: ${snapshot.data!['message']}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class SearchSheet extends StatefulWidget {
  const SearchSheet({
    super.key,
    required this.type,
    this.assets = const [],
    this.users = const [],
  });
  final String type;
  final List<User> users;
  final List<Asset> assets;

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  TextEditingController searchController = TextEditingController();
  bool showResult = false;
  List<User> hits = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: MediaQuery.of(context).size.height*0.8,
        child: Column(
          children: [
            Row(
              children: [
                CustomFormTextWidget(
                  hint: "Search ...",
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: searchController,
                ),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        hits = User.filterByName(
                            searchController.text.trim(), widget.users);
                        showResult = true;
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            showResult
                ? SizedBox(
                    child: widget.type == "user"
                        ? Column(
                            children: [
                              ...List.generate(
                                  hits.length,
                                  (index) => UserTile(
                                      user: hits[index],
                                      defaultSize: SizeConfig.defaultSize!,
                                      assets: []))
                            ],
                          )
                        : Column(
                            children: [
                              ...List.generate(
                                widget.assets.length,
                                (index) => ListTile(
                                  title: Text(widget.assets[index].name),
                                  subtitle:
                                      Text(widget.assets[index].serialNumber),
                                  trailing: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        TextEditingController
                                            conditionController =
                                            TextEditingController();
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Asset Condition'),
                                                content: CustomFormTextWidget(
                                                  hint: "Condition",
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  controller: conditionController,
                                                ),
                                                actions: [
                                                  PrimaryButton(
                                                    label: "Save",
                                                    onPressed: () {},
                                                    icon: Icons.arrow_forward,
                                                  ),
                                                ],
                                              );
                                            });
                                      }),
                                ),
                              )
                            ],
                          ))
                : Placeholder(),
          ],
        ),
      ),
    );
  }
}

class UserTile extends StatefulWidget {
  const UserTile(
      {super.key,
      required this.user,
      required this.defaultSize,
      required this.assets});
  final User user;
  final List<Asset> assets;
  final double defaultSize;

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  var items = [
    "Printer",
    "Projector",
    "Laptop",
    "Desktop",
    "VoIp-Phone",
    "Tablet",
  ];
  var item = "Add";
  List<Asset> loadedAssets = [];
  List<Asset> userAssets = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            '${widget.user.name} ${widget.user.lastName}',
            style:
                TextStyle(color: textColor, fontSize: widget.defaultSize * 2),
          ),
          // subtitle: Text(
          //   "Laptop, VoIp Phone"
          // ),
          trailing: IconButton(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Add",
                            style: TextStyle(color: bluishClr),
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: bluishClr,
                            ),
                            onSelected: (String value) {
                              item = value;
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text("Available"),
                                        content: SizedBox(
                                          width: widget.defaultSize *
                                              double.infinity,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                ...Asset.filterByOccupancy(
                                                        Asset.filterType(
                                                            value.toLowerCase(),
                                                            loadedAssets),
                                                        '0')
                                                    .map((asset) => Column(
                                                          children: [
                                                            ListTile(
                                                              title: TextButton(
                                                                onPressed: () {
                                                                  // Get.back();
                                                                  Get.showOverlay(
                                                                    asyncFunction: () => WebServices()
                                                                        .addAssetToUser(
                                                                            widget
                                                                                .user.id,
                                                                            asset
                                                                                .id)
                                                                        .then(
                                                                            (result) {
                                                                      Get.back();
                                                                      Get.back();

                                                                      if (result[
                                                                          'status']) {
                                                                        Get.showSnackbar(
                                                                            const GetSnackBar(
                                                                          duration:
                                                                              Duration(seconds: 3),
                                                                          backgroundColor:
                                                                              Colors.green,
                                                                          title:
                                                                              "Success",
                                                                          message:
                                                                              "Asset assigned to user",
                                                                        ));
                                                                      } else {
                                                                        Get.showSnackbar(
                                                                            const GetSnackBar(
                                                                          duration:
                                                                              Duration(seconds: 3),
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                          title:
                                                                              "Error",
                                                                          message:
                                                                              "Assigning asset failed",
                                                                        ));
                                                                      }
                                                                    }),
                                                                    loadingWidget:
                                                                        const Center(
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        child:
                                                                            CircularProgressIndicator(),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Text(
                                                                  asset
                                                                      .serialNumber,
                                                                  style: const TextStyle(
                                                                      color:
                                                                          textColor),
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(
                                                              color: textColor
                                                                  .withOpacity(
                                                                      0.1),
                                                            ),
                                                          ],
                                                        ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                            },
                            itemBuilder: (BuildContext context) {
                              return items
                                  .map<PopupMenuItem<String>>((String value) {
                                return PopupMenuItem(
                                    child: new Text(value), value: value);
                              }).toList();
                            },
                          )
                        ],
                      ),
                      content: SizedBox(
                        width: widget.defaultSize * double.infinity,
                        child: SingleChildScrollView(
                          child: FutureBuilder(
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
                                loadedAssets = snapshot.data!['assets'];
                                userAssets = Asset.filterByUser(
                                    widget.user.id, snapshot.data!['assets']);
                                return Column(
                                  children: [
                                    ...userAssets.map((asset) => Column(
                                          children: [
                                            UserAsset(
                                              defaultSize: widget.defaultSize,
                                              asset: asset,
                                            ),
                                            Divider(
                                              color: textColor.withOpacity(0.1),
                                            ),
                                          ],
                                        ))
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return ReloadPage(
                                  erroMsg: snapshot.error.toString(),
                                  onTap: () {
                                    setState(() {});
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      ),
                      actions: [
                        // TextButton(
                        //     style: TextButton.styleFrom(
                        //       backgroundColor: bluishClr,
                        //       foregroundColor: Colors.white,
                        //     ),
                        //     onPressed: () {
                        //       Get.back();
                        //     },
                        //     child: Text("Save")),
                      ],
                    )),
            icon: Icon(
              Icons.edit,
              color: bluishClr,
            ),
          ),
        ),
        Divider(
          color: textColor.withOpacity(0.1),
        ),
      ],
    );
  }
}

class UserAsset extends StatelessWidget {
  const UserAsset({
    super.key,
    required this.defaultSize,
    required this.asset,
  });

  final double defaultSize;
  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: defaultSize * double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                asset.name,
                style: TextStyle(fontSize: defaultSize * 1.6),
              ),
              Text(
                asset.serialNumber,
                style: TextStyle(color: textColor.withOpacity(0.7)),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.showOverlay(
                    asyncFunction: () => WebServices()
                        .removeAssetFromUser(asset.user, asset.id)
                        .then((result) {
                      Get.back();
                      if (result['status']) {
                        Get.showSnackbar(const GetSnackBar(
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.green,
                          title: "Success",
                          message: "Asset unassigned to user",
                        ));
                      } else {
                        Get.showSnackbar(const GetSnackBar(
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.red,
                          title: "Success",
                          message: "Asset assigned to user",
                        ));
                      }
                    }),
                    loadingWidget: const Center(
                        child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    )),
                  );
                },
                icon: const Icon(
                  Icons.remove,
                  color: Colors.redAccent,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
