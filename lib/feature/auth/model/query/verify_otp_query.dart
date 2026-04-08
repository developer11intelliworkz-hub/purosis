import 'package:dio/dio.dart';

class VerifyOtpQuery {
  VerifyOtpQuery({
    this.userType,
    this.phoneNo,
    this.otp,
    this.latitude,
    this.longitude,
  });

  VerifyOtpQuery.fromJson(dynamic json) {
    userType = json['user_type'];
    phoneNo = json['phone_no'];
    phoneNo = json['otp'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  String? userType;
  String? phoneNo;
  String? otp;
  double? latitude;
  double? longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_type'] = userType;
    map['phone_no'] = phoneNo;
    map['otp'] = otp;
    map['latitude'] = longitude;
    map['longitude'] = longitude;
    return map;
  }

  FormData toFormData() {
    return FormData.fromMap(toJson());
  }
}
