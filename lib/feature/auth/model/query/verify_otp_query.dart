import 'package:dio/dio.dart';

class VerifyOtpQuery {
  VerifyOtpQuery({this.phoneNo, this.otp});

  VerifyOtpQuery.fromJson(dynamic json) {
    phoneNo = json['phone_no'];
    phoneNo = json['otp'];
  }

  String? phoneNo;
  String? otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_no'] = phoneNo;
    map['otp'] = otp;
    return map;
  }

  FormData toFormData() {
    return FormData.fromMap({'phone_no': phoneNo ?? "", 'otp': otp ?? ""});
  }
}
