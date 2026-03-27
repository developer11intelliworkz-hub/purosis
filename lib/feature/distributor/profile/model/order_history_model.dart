class OrderHistoryModel {
  Summary? summary;
  List<Order>? orders;

  OrderHistoryModel({this.summary, this.orders});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    summary = json['summary'] != null
        ? Summary.fromJson(json['summary'])
        : null;

    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  int? totalOrders;
  int? pending;
  int? confirm;
  int? failed;

  Summary({this.totalOrders, this.pending, this.confirm, this.failed});

  Summary.fromJson(Map<String, dynamic> json) {
    totalOrders = json['total_orders'];
    pending = json['pending'];
    confirm = json['confirm'];
    failed = json['failed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['total_orders'] = totalOrders;
    data['pending'] = pending;
    data['confirm'] = confirm;
    data['failed'] = failed;
    return data;
  }
}

class Order {
  int? id;
  String? orderNumber;
  String? totalWeight;
  String? shippingStatus;
  int? orderProductsCount;
  String? orderDate;

  Order({
    this.id,
    this.orderNumber,
    this.totalWeight,
    this.shippingStatus,
    this.orderProductsCount,
    this.orderDate,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    totalWeight = json['total_weight'];
    shippingStatus = json['shipping_status'];
    orderProductsCount = json['order_products_count'];
    orderDate = json['order_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['total_weight'] = totalWeight;
    data['shipping_status'] = shippingStatus;
    data['order_products_count'] = orderProductsCount;
    data['order_date'] = orderDate;
    return data;
  }
}
