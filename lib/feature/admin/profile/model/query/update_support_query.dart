import 'package:dio/dio.dart';

class UpdateSupportQuery {
  String? email;
  String? phoneNo;
  String? officeTimings;
  String? note;

  UpdateSupportQuery({this.email, this.phoneNo, this.officeTimings, this.note});

  static UpdateSupportQuery fromJson(Map<String, dynamic> json) {
    return UpdateSupportQuery(
      email: json['email'],
      phoneNo: json['phone_no'],
      officeTimings: json['office_timings'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone_no': phoneNo,
      'office_timings': officeTimings,
      'note': note,
    };
  }

  FormData toFormData() {
    return FormData.fromMap({
      'email': email,
      'phone_no': phoneNo,
      'office_timings': officeTimings,
      'note': note,
    });
  }
}
