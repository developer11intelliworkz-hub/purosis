import 'package:dio/dio.dart';

class AddressDeleteQuery {
  num? addressId;

  AddressDeleteQuery({this.addressId});

  AddressDeleteQuery.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
  }

  Map<String, dynamic> toJson() {
    return {"address_id": addressId};
  }

  FormData toFormData() {
    return FormData.fromMap({"address_id": addressId});
  }
}
