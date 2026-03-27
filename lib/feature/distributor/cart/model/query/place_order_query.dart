import 'package:dio/dio.dart';

class PlaceOrderQuery {
  int? billingAddressId;
  int? shippingAddressId;
  String? type;
  String? remarks;
  List<int>? cartIds;
  int? productId;
  int? qty;
  String? colorCode;

  PlaceOrderQuery({
    this.billingAddressId,
    this.shippingAddressId,
    this.type,
    this.remarks,
    this.cartIds,
    this.productId,
    this.qty,
    this.colorCode,
  });

  factory PlaceOrderQuery.fromJson(Map<String, dynamic> json) {
    return PlaceOrderQuery(
      billingAddressId: json['billing_address_id'],
      shippingAddressId: json['shipping_address_id'],
      type: json['type'],
      remarks: json['remarks'],
      cartIds: json['cart_ids'] != null
          ? List<int>.from(json['cart_ids'])
          : null,
      productId: json['product_id'],
      qty: json['qty'],
      colorCode: json['color_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "billing_address_id": billingAddressId,
      "shipping_address_id": shippingAddressId,
      "type": type,
      "remarks": remarks,
      "cart_ids": cartIds,
      "product_id": productId,
      "qty": qty,
      "color_code": colorCode,
    };
  }

  Future<FormData> toFormData() async {
    final map = <String, dynamic>{};

    map["billing_address_id"] = billingAddressId;
    map["shipping_address_id"] = shippingAddressId;
    map["type"] = type;
    map["remarks"] = remarks;
    if (cartIds != null && cartIds!.isNotEmpty) {
      for (int i = 0; i < cartIds!.length; i++) {
        map["cart_ids[$i]"] = cartIds![i];
      }
    }

    if (productId != null) map["product_id"] = productId;
    if (qty != null) map["qty"] = qty;
    if (colorCode != null) map["color_code"] = colorCode;

    return FormData.fromMap(map);
  }
}
