import 'dart:io';
import 'package:dio/dio.dart';

class UpdateProfileQuery {
  String? name;
  String? phoneNo;
  String? email;
  File? profilePhoto;

  UpdateProfileQuery({this.name, this.phoneNo, this.email, this.profilePhoto});

  UpdateProfileQuery.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNo = json['phone_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'phone_no': phoneNo, 'email': email};
  }

  FormData toFormData() {
    return FormData.fromMap({
      if (name != null) 'name': name,
      if (phoneNo != null) 'phone_no': phoneNo,
      if (email != null) 'email': email,
      if (profilePhoto != null)
        'profile_photo': MultipartFile.fromBytes(
          profilePhoto!.readAsBytesSync().toList(),
          filename: profilePhoto!.path.split('/').last,
        ),
    });
  }
}
