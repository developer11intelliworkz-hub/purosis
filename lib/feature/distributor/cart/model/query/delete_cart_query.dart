import 'package:dio/dio.dart';

class DeleteCartQuery {
  int? cartId;

  DeleteCartQuery({this.cartId});

  DeleteCartQuery.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cart_id'] = cartId;
    return data;
  }

  FormData toFormData() {
    final formData = FormData();

    if (cartId != null) {
      formData.fields.add(MapEntry('cart_id', cartId.toString()));
    }

    return formData;
  }
}
