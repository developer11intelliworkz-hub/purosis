import 'package:dio/dio.dart';

class DeleteBannerQuery {
  int? bannerId;

  DeleteBannerQuery({this.bannerId});

  DeleteBannerQuery.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['banner_id'] = bannerId;
    return data;
  }

  FormData toFormData() {
    return FormData.fromMap({'banner_id': bannerId});
  }
}
