import 'package:dio/dio.dart';

class UpdateUserStatusQuery {
  int? distributorId;
  int? status;

  UpdateUserStatusQuery({this.distributorId, this.status});

  UpdateUserStatusQuery.fromJson(Map<String, dynamic> json) {
    distributorId = json['distributor_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['distributor_id'] = distributorId;
    data['status'] = status;
    return data;
  }

  FormData toFormData() {
    return FormData.fromMap({
      'distributor_id': distributorId,
      'status': status,
    });
  }
}
