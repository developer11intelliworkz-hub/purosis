class OrderHistoryModel {
  int? id;
  String? orderNumber;
  String? totalWeight;
  String? status;
  String? shippingStatus;
  int? distributorId;
  int? orderProductsCount;
  String? orderDate;
  List<OrderProduct>? orderProducts;
  Distributor? distributor;

  OrderHistoryModel({
    this.id,
    this.orderNumber,
    this.totalWeight,
    this.status,
    this.shippingStatus,
    this.distributorId,
    this.orderProductsCount,
    this.orderDate,
    this.orderProducts,
    this.distributor,
  });

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    totalWeight = json['total_weight'];
    status = json['status']; // ✅
    shippingStatus = json['shipping_status'];
    distributorId = json['distributor_id']; // ✅
    orderProductsCount = json['order_products_count'];
    orderDate = json['order_date'];

    if (json['order_products'] != null) {
      orderProducts = [];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProduct.fromJson(v));
      });
    }

    distributor = json['distributor'] != null
        ? Distributor.fromJson(json['distributor'])
        : null; // ✅
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['total_weight'] = totalWeight;
    data['status'] = status; // ✅
    data['shipping_status'] = shippingStatus;
    data['distributor_id'] = distributorId; // ✅
    data['order_products_count'] = orderProductsCount;
    data['order_date'] = orderDate;

    if (orderProducts != null) {
      data['order_products'] = orderProducts!.map((v) => v.toJson()).toList();
    }

    if (distributor != null) {
      data['distributor'] = distributor!.toJson(); // ✅
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

class Distributor {
  int? id;
  String? name;
  String? companyName;
  String? email;
  String? phoneNo;
  String? whatsappNo;
  String? gstNumber;
  String? area;
  String? billingAddress;
  String? shippingAddressLine;
  String? shippingAddressPincode;
  String? logo;

  Distributor({
    this.id,
    this.name,
    this.companyName,
    this.email,
    this.phoneNo,
    this.whatsappNo,
    this.gstNumber,
    this.area,
    this.billingAddress,
    this.shippingAddressLine,
    this.shippingAddressPincode,
    this.logo,
  });

  Distributor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    whatsappNo = json['whatsapp_no'];
    gstNumber = json['gst_number'];
    area = json['area'];
    billingAddress = json['billing_address'];
    shippingAddressLine = json['shipping_address_line'];
    shippingAddressPincode = json['shipping_address_pincode'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['company_name'] = companyName;
    data['email'] = email;
    data['phone_no'] = phoneNo;
    data['whatsapp_no'] = whatsappNo;
    data['gst_number'] = gstNumber;
    data['area'] = area;
    data['billing_address'] = billingAddress;
    data['shipping_address_line'] = shippingAddressLine;
    data['shipping_address_pincode'] = shippingAddressPincode;
    data['logo'] = logo;
    return data;
  }
}
