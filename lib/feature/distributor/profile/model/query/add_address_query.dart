import 'package:dio/dio.dart';

class AddAddressQuery {
  int? addressId;
  String? dealerName;
  String? contactPersonName;
  String? gstNumber;
  String? pinCode;
  String? address;
  String? state;
  String? city;
  String? mobileNo;
  String? emailAddress;
  String? shippingAddress;
  int? isShipping;

  AddAddressQuery({
    this.addressId,
    this.dealerName,
    this.contactPersonName,
    this.gstNumber,
    this.pinCode,
    this.address,
    this.state,
    this.city,
    this.mobileNo,
    this.emailAddress,
    this.shippingAddress,
    this.isShipping,
  });

  AddAddressQuery.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    dealerName = json['dealer_name'];
    contactPersonName = json['contact_person_name'];
    gstNumber = json['gst_number'];
    pinCode = json['pincode'];
    address = json['address'];
    state = json['state'];
    city = json['city'];
    mobileNo = json['mobile_no'];
    emailAddress = json['email_address'];
    shippingAddress = json['shipping_address'];
    isShipping = json['is_shipping'];
  }

  Map<String, dynamic> toJson() {
    return {
      'address_id': addressId,
      'dealer_name': dealerName,
      'contact_person_name': contactPersonName,
      'gst_number': gstNumber,
      'pincode': pinCode,
      'address': address,
      'state': state,
      'city': city,
      'mobile_no': mobileNo,
      'email_address': emailAddress,
      'shipping_address': shippingAddress,
      'is_shipping': isShipping,
    };
  }

  FormData toFormData() {
    return FormData.fromMap({
      'address_id': addressId,
      'dealer_name': dealerName,
      'contact_person_name': contactPersonName,
      'gst_number': gstNumber,
      'pincode': pinCode,
      'address': address,
      'state': state,
      'city': city,
      'mobile_no': mobileNo,
      'email_address': emailAddress,
      'shipping_address': shippingAddress,
      'is_shipping': isShipping,
    });
  }
}
