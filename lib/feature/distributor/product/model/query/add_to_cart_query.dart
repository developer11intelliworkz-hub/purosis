import 'package:dio/dio.dart';

class AddToCartQuery {
  int? productId;
  int? qty;
  int? colorId;

  AddToCartQuery({this.productId, this.qty, this.colorId});

  factory AddToCartQuery.fromJson(Map<String, dynamic> json) {
    return AddToCartQuery(
      productId: json['product_id'],
      qty: json['qty'],
      colorId: json['color_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'product_id': productId, 'qty': qty, 'color_id': colorId};
  }

  FormData toFormData() {
    final Map<String, dynamic> map = {
      'product_id': productId,
      'qty': qty,
      'color_id': colorId,
    };

    return FormData.fromMap(map);
  }
}
