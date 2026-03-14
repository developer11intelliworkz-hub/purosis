class AddedUserModel {
  AddedUserModel({
    this.id,
    this.name,
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
  });

  AddedUserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
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
  }

  num? id;
  String? name;
  String? email;
  String? phoneNo;
  String? whatsappNo;
  String? gstNumber;
  String? area;
  String? billingAddress;
  String? shippingAddressLine;
  String? shippingAddressPincode;
  num? isActive;
  num? totalOrders;
  num? assetsDownloaded;
  num? lastActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
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
    return map;
  }
}
