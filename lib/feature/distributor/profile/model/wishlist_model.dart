class WishlistModel {
  int? id;
  int? productId;
  int? distributorId;
  String? createdAt;
  Product? product;

  WishlistModel({
    this.id,
    this.productId,
    this.distributorId,
    this.createdAt,
    this.product,
  });

  WishlistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    distributorId = json['distributor_id'];
    createdAt = json['created_at'];
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['distributor_id'] = distributorId;
    data['created_at'] = createdAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? productName;
  List<ProductColorImage>? productColorsImages;

  Product({this.id, this.productName, this.productColorsImages});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    if (json['product_colors_images'] != null) {
      productColorsImages = [];
      json['product_colors_images'].forEach((v) {
        productColorsImages!.add(ProductColorImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
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
