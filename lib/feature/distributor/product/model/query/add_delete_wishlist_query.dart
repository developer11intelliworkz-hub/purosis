import 'package:dio/dio.dart';

class AddDeleteWishlistQuery {
  String? productId;
  int? addOrDelete;

  AddDeleteWishlistQuery({this.productId, this.addOrDelete});

  AddDeleteWishlistQuery.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    addOrDelete = json['add_or_delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['product_id'] = productId;
    data['add_or_delete'] = addOrDelete;
    return data;
  }

  FormData toFormData() {
    return FormData.fromMap({
      'product_id': productId,
      'add_or_delete': addOrDelete,
    });
  }
}
