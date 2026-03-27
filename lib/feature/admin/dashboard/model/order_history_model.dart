class OrderHistoryModel {
  int? id;
  String? orderNumber;
  String? totalWeight;
  String? shippingStatus;
  int? orderProductsCount;
  String? orderDate;
  List<OrderProduct>? orderProducts;

  OrderHistoryModel({
    this.id,
    this.orderNumber,
    this.totalWeight,
    this.shippingStatus,
    this.orderProductsCount,
    this.orderDate,
    this.orderProducts,
  });

  // fromJson
  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    totalWeight = json['total_weight'];
    shippingStatus = json['shipping_status'];
    orderProductsCount = json['order_products_count'];
    orderDate = json['order_date'];

    if (json['order_products'] != null) {
      orderProducts = [];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProduct.fromJson(v));
      });
    }
  }

  // toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['total_weight'] = totalWeight;
    data['shipping_status'] = shippingStatus;
    data['order_products_count'] = orderProductsCount;
    data['order_date'] = orderDate;

    if (orderProducts != null) {
      data['order_products'] = orderProducts!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class OrderProduct {
  int? id;
  int? orderId;
  int? productId;
  Product? product;

  OrderProduct({this.id, this.orderId, this.productId, this.product});

  // fromJson
  OrderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
  }

  // toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? productName;

  Product({this.id, this.productName});

  // fromJson
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
  }

  // toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_name'] = productName;
    return data;
  }
}
