import 'dart:io';
import 'package:dio/dio.dart';

class UpdateProfileQuery {
  String? name;
  String? gstNumber;
  String? phoneNo;
  String? email;
  File? logo;

  UpdateProfileQuery({
    this.name,
    this.gstNumber,
    this.phoneNo,
    this.email,
    this.logo,
  });

  factory UpdateProfileQuery.fromJson(Map<String, dynamic> json) {
    return UpdateProfileQuery(
      name: json['name'],
      gstNumber: json['gst_number'],
      phoneNo: json['phone_no'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "gst_number": gstNumber,
      "phone_no": phoneNo,
      "email": email,
    };
  }

  FormData toFormData() {
    final map = <String, dynamic>{};

    if (name != null) map['name'] = name;
    if (gstNumber != null) map['gst_number'] = gstNumber;
    if (phoneNo != null) map['phone_no'] = phoneNo;
    if (email != null) map['email'] = email;

    if (logo != null) {
      map['logo'] = MultipartFile.fromBytes(
        logo!.readAsBytesSync().toList(),
        filename: logo!.path.split('/').last,
      );
    }

    return FormData.fromMap(map);
  }
}
