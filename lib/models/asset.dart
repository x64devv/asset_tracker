class Asset {
  final String id;
  final String name;
  final String serialNumber;
  final String type;
  String productCondition;
  final String inUse;
  final Map<String, dynamic> user;
  final String location;
  final String office;
  final String phone;

  Asset({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.type,
    required this.productCondition,
    required this.inUse,
    required this.user,
    required this.location,
    required this.office,
    required this.phone,
  });

  factory Asset.fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> theUser = {};
    if(data['user'] != null){
      theUser = data['user'];
    }
    return Asset(
      id: data['id'],
      name: data['name'],
      serialNumber: data['serialNumber'],
      type: data['type'],
      productCondition: data['product_condition'],
      inUse: data['inUse'],
      user: theUser ,
      location: data['location'],
      office: data['office'],
      phone: data['phone'],
    );
  }
  factory Asset.fromScan(Map<String, dynamic> data) {
    return Asset(
      id: '0',
      name: data['name'],
      serialNumber: data['serialNumber'],
      type: data['type'],
      productCondition: '',
      inUse: '0',
      user: {},
      location: data['location'],
      office: data['office'],
      phone: data['contact'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'asset_id': id,
      'name': name,
      'serialNumber': serialNumber,
      'type': type,
      'product_condition': productCondition,
      'inUse': inUse,
      'user': user.toString(),
      'location': location,
      'office': office,
      'phone': phone,
    };
  }

  static List<Asset> filterType(String type, List<Asset> assets) {
    List<Asset> filtered = [];
    for (Asset asset in assets) {
      asset.type.toLowerCase() == type ? filtered.add(asset) : null;
    }
    return filtered;
  }

  static List<Asset> filterByOccupancy(List<Asset> assets, String occupancy) {
    List<Asset> inUse = [];
    List<Asset> idle = [];
    for (Asset asset in assets) {
      asset.inUse == occupancy ? inUse.add(asset) : idle.add(asset);
    }
    return inUse;
  }

  static List<Asset> filterByUser(String id, List<Asset> assets) {
    List<Asset> forUser = [];
    for (Asset asset in assets) {
      asset.user == id ? forUser.add(asset) : null;
    }
    return forUser;
  }
}
