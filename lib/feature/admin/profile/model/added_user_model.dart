class AddedUserModel {
  AddedUserModel({
    this.id,
    this.name,
    this.companyName,
    this.email,
    this.phoneNo,
    this.whatsappNo,
    this.gstNumber,
    this.area,
    this.billingAddress,
    this.shippingAddressLine,
    this.shippingAddressPincode,
    this.isActive,
    this.totalOrders,
    this.assetsDownloaded,
    this.lastActive,
    this.alternateMobileNo,
    this.landlineNo,
    this.logo,
  });

  AddedUserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    whatsappNo = json['whatsapp_no'];
    gstNumber = json['gst_number'];
    area = json['area'];
    billingAddress = json['billing_address'];
    shippingAddressLine = json['shipping_address_line'];
    shippingAddressPincode = json['shipping_address_pincode'];
    isActive = json['is_active'];
    totalOrders = json['total_orders'];
    assetsDownloaded = json['assets_downloaded'];
    lastActive = json['last_active'];
    alternateMobileNo = json['alternate_mobile_no'];
    landlineNo = json['landline_no'];
    logo = json['logo'];
  }

  int? id;
  String? name;
  String? companyName;
  String? email;
  String? phoneNo;
  String? whatsappNo;
  String? gstNumber;
  String? area;
  String? billingAddress;
  String? shippingAddressLine;
  String? shippingAddressPincode;
  int? isActive;
  num? totalOrders;
  num? assetsDownloaded;
  String? lastActive;
  String? alternateMobileNo;
  String? landlineNo;
  String? logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['company_name'] = companyName;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['whatsapp_no'] = whatsappNo;
    map['gst_number'] = gstNumber;
    map['area'] = area;
    map['billing_address'] = billingAddress;
    map['shipping_address_line'] = shippingAddressLine;
    map['shipping_address_pincode'] = shippingAddressPincode;
    map['is_active'] = isActive;
    map['total_orders'] = totalOrders;
    map['assets_downloaded'] = assetsDownloaded;
    map['last_active'] = lastActive;
    map['alternate_mobile_no'] = alternateMobileNo;
    map['landline_no'] = landlineNo;
    map['logo'] = logo;
    return map;
  }
}
