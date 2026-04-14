import 'dart:io';

import 'package:dio/dio.dart';

class AddUserQuery {
  AddUserQuery({
    this.distributorId,
    this.name,
    this.email,
    this.phoneNo,
    this.whatsappNo,
    this.gstNumber,
    this.area,
    this.billingAddress,
    this.shippingAddressLine,
    this.shippingAddressPincode,
    this.companyName,
    this.alternateMobileNo,
    this.landlineNo,
    this.logo,
  });

  AddUserQuery.fromJson(dynamic json) {
    distributorId = json['distributor_id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    whatsappNo = json['whatsapp_no'];
    gstNumber = json['gst_number'];
    area = json['area'];
    billingAddress = json['billing_address'];
    shippingAddressLine = json['shipping_address_line'];
    shippingAddressPincode = json['shipping_address_pincode'];
    companyName = json['company_name'];
    alternateMobileNo = json['alternate_mobile_no'];
    landlineNo = json['landline_no'];
  }

  int? distributorId;
  String? name;
  String? email;
  String? phoneNo;
  String? whatsappNo;
  String? gstNumber;
  String? area;
  String? billingAddress;
  String? shippingAddressLine;
  String? shippingAddressPincode;
  String? companyName;
  String? alternateMobileNo;
  String? landlineNo;
  File? logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distributor_id'] = distributorId;
    map['name'] = name;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['whatsapp_no'] = whatsappNo;
    map['gst_number'] = gstNumber;
    map['area'] = area;
    map['billing_address'] = billingAddress;
    map['shipping_address_line'] = shippingAddressLine;
    map['shipping_address_pincode'] = shippingAddressPincode;
    map['company_name'] = companyName;
    map['alternate_mobile_no'] = alternateMobileNo;
    map['landline_no'] = landlineNo;
    return map;
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      if (distributorId != null) "distributor_id": distributorId,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (phoneNo != null) "phone_no": phoneNo,
      if (whatsappNo != null) "whatsapp_no": whatsappNo,
      if (gstNumber != null) "gst_number": gstNumber,
      if (area != null) "area": area,
      if (billingAddress != null) "billing_address": billingAddress,
      if (shippingAddressLine != null)
        "shipping_address_line": shippingAddressLine,
      if (shippingAddressPincode != null)
        "shipping_address_pincode": shippingAddressPincode,
      if (companyName != null) "company_name": companyName,
      if (alternateMobileNo != null) "alternate_mobile_no": alternateMobileNo,
      if (landlineNo != null) "landline_no": landlineNo,
      if (logo != null)
        'logo': MultipartFile.fromBytes(
          logo!.readAsBytesSync().toList(),
          filename: logo!.path.split('/').last,
        ),
    });
  }
}
