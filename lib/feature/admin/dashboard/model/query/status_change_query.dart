import 'package:dio/dio.dart';

class StatusChangeQuery {
  int? orderId;
  String? shippingStatus;

  StatusChangeQuery({this.orderId, this.shippingStatus});

  StatusChangeQuery.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    shippingStatus = json['shipping_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['order_id'] = orderId;
    data['shipping_status'] = shippingStatus;
    return data;
  }

  FormData toFormData() {
    final formData = FormData();
    if (orderId != null) {
      formData.fields.add(MapEntry('order_id', orderId.toString()));
    }
    if (shippingStatus != null) {
      formData.fields.add(MapEntry('shipping_status', shippingStatus!));
    }
    return formData;
  }
}
