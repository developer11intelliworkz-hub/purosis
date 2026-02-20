import 'package:dio/dio.dart';

class OtpQuery {
  OtpQuery({this.phoneNo});

  OtpQuery.fromJson(dynamic json) {
    phoneNo = json['phone_no'];
  }

  String? phoneNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_no'] = phoneNo;
    return map;
  }

  FormData toFormData() {
    return FormData.fromMap({
      'phone_no': phoneNo ?? "",
    });
  }
}
