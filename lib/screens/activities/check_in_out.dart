import 'package:asset_tracker/services/web_services.dart';
import 'package:asset_tracker/ui/constants/theme_data.dart';
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
            onPressed: () {},
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
                            index: index,
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

class UserTile extends StatefulWidget {
  const UserTile(
      {super.key,
      required this.user,
      required this.index,
      required this.defaultSize,
      required this.assets});
  final User user;
  final List<Asset> assets;
  final int index;
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
    "Tablet"
  ];
  var item = "Add";
  List<Asset> loadedAssets = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.user.name,
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
                                                                  Get.back();
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
                                return Column(
                                  children: [
                                    ...Asset.filterByUser(widget.user.id,
                                            snapshot.data!['assets'])
                                        .map((asset) => Column(
                                              children: [
                                                UserAsset(
                                                  defaultSize:
                                                      widget.defaultSize,
                                                  asset: asset,
                                                ),
                                                Divider(
                                                  color: textColor
                                                      .withOpacity(0.1),
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
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: bluishClr,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Save")),
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
                onPressed: () {},
                icon: Icon(
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
