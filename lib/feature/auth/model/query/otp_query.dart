import 'package:dio/dio.dart';

class OtpQuery {
  OtpQuery({this.phoneNo, this.userType});

  OtpQuery.fromJson(dynamic json) {
    phoneNo = json['phone_no'];
    userType = json['user_type'];
  }

  String? phoneNo;
  String? userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_no'] = phoneNo;
    map['user_type'] = userType;
    return map;
  }

  FormData toFormData() {
    return FormData.fromMap(toJson());
  }
}
