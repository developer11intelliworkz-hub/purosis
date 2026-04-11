class OrderDetailModel {
  int? id;
  String? orderNumber;
  String? shippingStatus;
  String? createdAt;
  List<OrderProducts>? orderProducts;

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
      orderProducts = (json['order_products'] as List)
          .map((e) => OrderProducts.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'shipping_status': shippingStatus,
      'created_at': createdAt,
      'order_products': orderProducts?.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderProducts {
  int? id;
  int? orderId;
  int? productId;
  int? qty;
  String? colorCode;
  String? price;
  String? totalWeight;
  String? totalCbm;
  Product? product;

  OrderProducts({
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

  OrderProducts.fromJson(Map<String, dynamic> json) {
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
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'qty': qty,
      'color_code': colorCode,
      'price': price,
      'total_weight': totalWeight,
      'total_cbm': totalCbm,
      'product': product?.toJson(),
    };
  }
}

class Product {
  int? id;
  String? productName;
  int? unitsPerBox;
  String? weightPerBox;
  List<ProductColorsImages>? productColorsImages;

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
      productColorsImages = (json['product_colors_images'] as List)
          .map((e) => ProductColorsImages.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'units_per_box': unitsPerBox,
      'weight_per_box': weightPerBox,
      'product_colors_images': productColorsImages
          ?.map((e) => e.toJson())
          .toList(),
    };
  }
}

class ProductColorsImages {
  String? colorName;
  String? colorCode;
  List<String>? images;

  ProductColorsImages({this.colorName, this.colorCode, this.images});

  // From JSON
  ProductColorsImages.fromJson(Map<String, dynamic> json) {
    colorName = json['color_name'];
    colorCode = json['color_code'];
    images = json['images'] != null ? List<String>.from(json['images']) : [];
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {'color_name': colorName, 'color_code': colorCode, 'images': images};
  }
}
