import 'package:dio/dio.dart';

class ApproveDeclineQuery {
  int? orderId;
  String? action;

  ApproveDeclineQuery({this.orderId, this.action});

  ApproveDeclineQuery.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['order_id'] = orderId;
    data['action'] = action;
    return data;
  }

  FormData toFormData() {
    final formData = FormData();
    if (orderId != null) {
      formData.fields.add(MapEntry('order_id', orderId.toString()));
    }
    if (action != null) {
      formData.fields.add(MapEntry('action', action!));
    }
    return formData;
  }
}
