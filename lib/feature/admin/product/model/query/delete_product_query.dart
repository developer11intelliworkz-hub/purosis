import 'package:dio/dio.dart';

class DeleteProductQuery {
  int? productId;

  DeleteProductQuery({this.productId});

  DeleteProductQuery.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    return {'product_id': productId};
  }

  FormData toFormData() {
    final formData = FormData();
    if (productId != null) {
      formData.fields.add(MapEntry('product_id', productId.toString()));
    }
    return formData;
  }
}
