import 'package:dio/dio.dart';

class VerifyOtpQuery {
  VerifyOtpQuery({this.userType, this.phoneNo, this.otp});

  VerifyOtpQuery.fromJson(dynamic json) {
    userType = json['user_type'];
    phoneNo = json['phone_no'];
    phoneNo = json['otp'];
  }

  String? userType;
  String? phoneNo;
  String? otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_type'] = userType;
    map['phone_no'] = phoneNo;
    map['otp'] = otp;
    return map;
  }

  FormData toFormData() {
    return FormData.fromMap(toJson());
  }
}
