import 'package:dio/dio.dart';

class VerifyOtpQuery {
  VerifyOtpQuery({
    this.userType,
    this.phoneNo,
    this.otp,
    this.latitude,
    this.longitude,
    this.deviceToken,
    this.deviceName,
  });

  VerifyOtpQuery.fromJson(dynamic json) {
    userType = json['user_type'];
    phoneNo = json['phone_no'];
    otp = json['otp'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deviceToken = json['device_token'];
    deviceName = json['device_name'];
  }

  String? userType;
  String? phoneNo;
  String? otp;
  double? latitude;
  double? longitude;
  String? deviceToken;
  String? deviceName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_type'] = userType;
    map['phone_no'] = phoneNo;
    map['otp'] = otp;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['device_token'] = deviceToken;
    map['device_name'] = deviceName;
    return map;
  }

  FormData toFormData() {
    return FormData.fromMap({
      if (userType != null) "user_type": userType,
      if (phoneNo != null) "phone_no": phoneNo,
      if (otp != null) "otp": otp,
      if (latitude != null) "latitude": latitude,
      if (longitude != null) "longitude": longitude,
      if (deviceToken != null) "device_token": deviceToken,
      if (deviceName != null) "device_name": deviceName,
    });
  }
}
