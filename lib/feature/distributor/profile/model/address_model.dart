class AddressModel {
  AddressModel({
    this.id,
    this.distributorId,
    this.dealerName,
    this.contactPersonName,
    this.gstNumber,
    this.address,
    this.state,
    this.city,
    this.pincode,
    this.mobileNo,
    this.emailAddress,
    this.isShipping,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  AddressModel.fromJson(dynamic json) {
    id = json['id'];
    distributorId = json['distributor_id'];
    dealerName = json['dealer_name'];
    contactPersonName = json['contact_person_name'];
    gstNumber = json['gst_number'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    mobileNo = json['mobile_no'];
    emailAddress = json['email_address'];
    isShipping = json['is_shipping'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  num? distributorId;
  String? dealerName;
  String? contactPersonName;
  String? gstNumber;
  String? address;
  String? state;
  String? city;
  String? pincode;
  String? mobileNo;
  String? emailAddress;
  num? isShipping;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['distributor_id'] = distributorId;
    map['dealer_name'] = dealerName;
    map['contact_person_name'] = contactPersonName;
    map['gst_number'] = gstNumber;
    map['address'] = address;
    map['state'] = state;
    map['city'] = city;
    map['pincode'] = pincode;
    map['mobile_no'] = mobileNo;
    map['email_address'] = emailAddress;
    map['is_shipping'] = isShipping;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
