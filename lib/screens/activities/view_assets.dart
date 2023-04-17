import 'package:asset_tracker/ui/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../models/asset.dart';
import '../../ui/constants/theme_data.dart';

class ViewAssets extends StatefulWidget {
  const ViewAssets({super.key});

  @override
  State<ViewAssets> createState() => _ViewAssetsState();
}

class _ViewAssetsState extends State<ViewAssets> {
  TextEditingController searchController = TextEditingController();
  List<Asset> assets = [];
  late AssetDataSource _assetDataSource;
  @override
  void initState() {
    _assetDataSource = AssetDataSource(assets: assets);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_outlined)),
        title: Text("View Assets"),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     showModalBottomSheet(
          //         context: context,
          //         builder: (context) {
          //           return SearchSheet(
          //             type: "user",
          //             users: users,
          //           );
          //         });
          //   },
          //   icon: Icon(Icons.search),
          // )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Expanded(
            child: SfDataGrid(
              source: _assetDataSource,
              columns: [
                GridColumn(
                  columnName: "name",
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("Name"),
                  ),
                ),
                GridColumn(
                  columnName: "serialNumber",
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("SN"),
                  ),
                ),
                GridColumn(
                  columnName: "type",
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("Type"),
                  ),
                ),
                GridColumn(
                  columnName: "productCondition",
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("Condition"),
                  ),
                ),
                GridColumn(
                  columnName: "inUse",
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("In Use"),
                  ),
                ),
                GridColumn(
                  columnName: "location",
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("Location"),
                  ),
                ),
                GridColumn(
                  columnName: "office",
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("Office"),
                  ),
                ),
                GridColumn(
                  columnName: "phone",
                  label: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text("Phone"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AssetDataSource extends DataGridSource {
  AssetDataSource({required List<Asset> assets}) {
    _assets = assets
        .map<DataGridRow>((asset) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: asset.name),
              DataGridCell<String>(
                  columnName: 'serialNumber', value: asset.serialNumber),
              DataGridCell<String>(columnName: 'type', value: asset.type),
              DataGridCell<String>(
                  columnName: 'productCondition',
                  value: asset.productCondition),
              DataGridCell<String>(columnName: 'inUse', value: asset.inUse),
              DataGridCell<String>(
                  columnName: 'location', value: asset.location),
              DataGridCell<String>(columnName: 'office', value: asset.office),
              DataGridCell<String>(columnName: 'phone', value: asset.phone),
            ]))
        .toList();
  }
  List<DataGridRow> _assets = [];
  String condition = "";

  @override
  List<DataGridRow> get rows => _assets;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      condition = dataGridCell.value.toString();
      return Container(
        alignment: alignment(dataGridCell),
        padding: const EdgeInsets.all(16.0),
        child: cellWidget(dataGridCell),
      );
    }).toList());
  }

  Widget cellWidget(DataGridCell cell) {
    if (cell.columnName == "inUse") {
      return Text(cell.value.toString() == '1' ? "True" : "False");
    } else if (cell.columnName == "productCondition") {
      return GestureDetector(
        onTap: () {
          print('1Bx[32mShit1Bx[0m');
        },
        child: Text(condition),
      );
    }
    return Text(cell.value.toString());
  }

  Alignment alignment(DataGridCell cell) {
    if (cell.columnName == "inUse" ||
        cell.columnName == "office" ||
        cell.columnName == "phone") {
      return Alignment.center;
    }
    return Alignment.centerLeft;
  }
}
