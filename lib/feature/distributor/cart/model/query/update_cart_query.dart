import 'package:dio/dio.dart';

class UpdateCartQuery {
  int? productId;
  int? qty;
  String? colorCode;

  UpdateCartQuery({this.productId, this.qty, this.colorCode});

  factory UpdateCartQuery.fromJson(Map<String, dynamic> json) {
    return UpdateCartQuery(
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
