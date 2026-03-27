class PinCodeModel {
  PinCodeModel({
    this.name,
    this.description,
    this.branchType,
    this.deliveryStatus,
    this.circle,
    this.district,
    this.division,
    this.region,
    this.block,
    this.state,
    this.country,
    this.pincode,
  });

  PinCodeModel.fromJson(dynamic json) {
    name = json['Name'];
    description = json['Description'];
    branchType = json['BranchType'];
    deliveryStatus = json['DeliveryStatus'];
    circle = json['Circle'];
    district = json['District'];
    division = json['Division'];
    region = json['Region'];
    block = json['Block'];
    state = json['State'];
    country = json['Country'];
    pincode = json['Pincode'];
  }

  String? name;
  dynamic description;
  String? branchType;
  String? deliveryStatus;
  String? circle;
  String? district;
  String? division;
  String? region;
  String? block;
  String? state;
  String? country;
  String? pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = name;
    map['Description'] = description;
    map['BranchType'] = branchType;
    map['DeliveryStatus'] = deliveryStatus;
    map['Circle'] = circle;
    map['District'] = district;
    map['Division'] = division;
    map['Region'] = region;
    map['Block'] = block;
    map['State'] = state;
    map['Country'] = country;
    map['Pincode'] = pincode;
    return map;
  }
}
