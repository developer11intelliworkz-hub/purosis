import 'package:dio/dio.dart';
import 'dart:io';

class UpdateProfileQuery {
  String? companyName;
  String? contactPersonName;
  String? gstNumber;
  String? area;
  String? mobileNo;
  String? alternateMobileNo;
  String? landlineNo;
  String? email;
  File? logo;

  UpdateProfileQuery({
    this.companyName,
    this.contactPersonName,
    this.gstNumber,
    this.area,
    this.mobileNo,
    this.alternateMobileNo,
    this.landlineNo,
    this.email,
    this.logo,
  });

  UpdateProfileQuery.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    contactPersonName = json['contact_person_name'];
    gstNumber = json['gst_number'];
    area = json['area'];
    mobileNo = json['mobile_no'];
    alternateMobileNo = json['alternate_mobile_no'];
    landlineNo = json['landline_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['company_name'] = companyName;
    data['contact_person_name'] = contactPersonName;
    data['gst_number'] = gstNumber;
    data['area'] = area;
    data['mobile_no'] = mobileNo;
    data['alternate_mobile_no'] = alternateMobileNo;
    data['landline_no'] = landlineNo;
    data['email'] = email;
    return data;
  }

  FormData toFormData() {
    return FormData.fromMap({
      'company_name': companyName,
      'contact_person_name': contactPersonName,
      'gst_number': gstNumber,
      'area': area,
      'mobile_no': mobileNo,
      'alternate_mobile_no': alternateMobileNo,
      'landline_no': landlineNo,
      'email': email,

      if (logo != null)
        'logo': MultipartFile.fromBytes(
          logo?.readAsBytesSync().toList() ?? [],
          filename: logo!.path.split('/').last,
        ),
    });
  }
}
