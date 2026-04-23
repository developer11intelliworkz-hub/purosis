class OrderDetailModel {
  int? id;
  String? orderNumber;
  String? shippingStatus;
  String? createdAt;
  List<OrderProduct>? orderProducts;

  OrderDetailModel({
    this.id,
    this.orderNumber,
    this.shippingStatus,
    this.createdAt,
    this.orderProducts,
  });

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    shippingStatus = json['shipping_status'];
    createdAt = json['created_at'];

    if (json['order_products'] != null) {
      orderProducts = [];
      json['order_products'].forEach((v) {
        orderProducts!.add(OrderProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['shipping_status'] = shippingStatus;
    data['created_at'] = createdAt;

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
  int? qty;
  String? colorCode;
  String? price;
  String? totalWeight;
  String? totalCbm;
  Product? product;

  OrderProduct({
    this.id,
    this.orderId,
    this.productId,
    this.qty,
    this.colorCode,
    this.price,
    this.totalWeight,
    this.totalCbm,
    this.product,
  });

  OrderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    qty = json['qty'];
    colorCode = json['color_code'];
    price = json['price'];
    totalWeight = json['total_weight'];
    totalCbm = json['total_cbm'];
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['color_code'] = colorCode;
    data['price'] = price;
    data['total_weight'] = totalWeight;
    data['total_cbm'] = totalCbm;

    if (product != null) {
      data['product'] = product!.toJson();
    }

    return data;
  }
}

class Product {
  int? id;
  String? productName;
  int? unitsPerBox;
  String? weightPerBox;
  List<ProductColorImage>? productColorsImages;

  Product({
    this.id,
    this.productName,
    this.unitsPerBox,
    this.weightPerBox,
    this.productColorsImages,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    unitsPerBox = json['units_per_box'];
    weightPerBox = json['weight_per_box'];
    if (json['product_colors_images'] != null) {
      productColorsImages = [];
      json['product_colors_images'].forEach((v) {
        productColorsImages!.add(ProductColorImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_name'] = productName;
    data['units_per_box'] = unitsPerBox;
    data['weight_per_box'] = weightPerBox;
    if (productColorsImages != null) {
      data['product_colors_images'] = productColorsImages!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class ProductColorImage {
  int? colorId;
  String? colorName;
  String? colorCode;
  List<String>? images;

  ProductColorImage({
    this.colorId,
    this.colorName,
    this.colorCode,
    this.images,
  });

  ProductColorImage.fromJson(Map<String, dynamic> json) {
    colorId = json['color_id'];
    colorName = json['color_name'];
    colorCode = json['color_code'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['color_id'] = colorId;
    data['color_name'] = colorName;
    data['color_code'] = colorCode;
    data['images'] = images;
    return data;
  }
}
