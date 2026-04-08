import 'dart:io';
import 'package:dio/dio.dart';

class AddBannerQuery {
  int? id;
  String? type;
  File? image;

  AddBannerQuery({this.id, this.type, this.image});

  AddBannerQuery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type};
  }

  FormData toFormData() {
    return FormData.fromMap({
      if (id != null) 'banner_id': id,
      if (type != null) 'type': type,
      if (image != null)
        'image': MultipartFile.fromBytes(
          image!.readAsBytesSync().toList(),
          filename: image!.path.split('/').last,
        ),
    });
  }
}
