class CartModel {
  int? id;
  int? distributorId;
  int? productId;
  int? qty;
  String? colorCode;
  dynamic price;
  int? unitsPerBox;
  String? weightPerBox;
  String? totalWeight;
  String? totalCbm;
  String? createdAt;
  String? updatedAt;
  Product? product;

  CartModel({
    this.id,
    this.distributorId,
    this.productId,
    this.qty,
    this.colorCode,
    this.price,
    this.unitsPerBox,
    this.weightPerBox,
    this.totalWeight,
    this.totalCbm,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      distributorId: json['distributor_id'],
      productId: json['product_id'],
      qty: json['qty'],
      colorCode: json['color_code'],
      price: json['price'],
      unitsPerBox: json['units_per_box'],
      weightPerBox: json['weight_per_box'],
      totalWeight: json['total_weight'],
      totalCbm: json['total_cbm'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      product: json['product'] != null
          ? Product.fromJson(json['product'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'distributor_id': distributorId,
      'product_id': productId,
      'qty': qty,
      'color_code': colorCode,
      'price': price,
      'units_per_box': unitsPerBox,
      'weight_per_box': weightPerBox,
      'total_weight': totalWeight,
      'total_cbm': totalCbm,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'product': product?.toJson(),
    };
  }
}

class Product {
  int? id;
  String? productName;
  List<ProductColorImage>? productColorsImages;

  Product({this.id, this.productName, this.productColorsImages});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['product_name'],
      productColorsImages: json['product_colors_images'] != null
          ? List<ProductColorImage>.from(
              json['product_colors_images'].map(
                (x) => ProductColorImage.fromJson(x),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'product_colors_images': productColorsImages
          ?.map((x) => x.toJson())
          .toList(),
    };
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

  factory ProductColorImage.fromJson(Map<String, dynamic> json) {
    return ProductColorImage(
      colorId: json['color_id'],
      colorName: json['color_name'],
      colorCode: json['color_code'],
      images: json['images'] != null ? List<String>.from(json['images']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color_id': colorId,
      'color_name': colorName,
      'color_code': colorCode,
      'images': images,
    };
  }
}
