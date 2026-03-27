import 'package:dio/dio.dart';

class AddToCartQuery {
  int? productId;
  int? qty;
  String? colorCode;

  AddToCartQuery({this.productId, this.qty, this.colorCode});

  factory AddToCartQuery.fromJson(Map<String, dynamic> json) {
    return AddToCartQuery(
      productId: json['product_id'],
      qty: json['qty'],
      colorCode: json['color_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'product_id': productId, 'qty': qty, 'color_code': colorCode};
  }

  FormData toFormData() {
    final Map<String, dynamic> map = {
      'product_id': productId,
      'qty': qty,
      'color_code': colorCode,
    };

    return FormData.fromMap(map);
  }
}
