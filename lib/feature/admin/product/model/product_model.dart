class ProductModel {
  int? id;
  String? productName;
  String? productDescription;
  List<String>? specifications;
  List<ProductColorImage>? productColorsImages;

  ProductModel({
    this.id,
    this.productName,
    this.productDescription,
    this.specifications,
    this.productColorsImages,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productDescription = json['product_description'];

    if (json['specifications'] != null) {
      specifications = List<String>.from(json['specifications']);
    }

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
    data['product_description'] = productDescription;
    data['specifications'] = specifications;

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

    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    } else {
      images = [];
    }
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
