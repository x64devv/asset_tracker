class Unit {
  String? name, serialNumber, type, location, office, contact;

  Unit({
    this.name,
    this.serialNumber,
    this.type,
    this.location,
    this.office,
    this.contact
      });

  Unit.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    serialNumber = json['serialNumber'];
    type = json['type'];
    location = json['location'];
    office = json['office'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['serialNumber'] = this.serialNumber;
    data['type'] = this.type;
    data['location'] = this.location;
    data['office'] = this.office;
    data['contact'] = this.contact;
    return data;
  }
}
