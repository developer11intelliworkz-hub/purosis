class ProductDetailModel {
  int? id;
  int? categoryId;
  int? subCategoryId;
  String? productName;
  String? productDescription;
  List<ProductColorImage>? productColorsImages;
  int? unitsPerBox;
  String? weightPerBox;
  String? length;
  String? width;
  String? height;
  String? technicalVideoUrl;
  List<String>? specifications;
  Category? category;
  SubCategory? subCategory;
  bool? isWishlisted;

  ProductDetailModel({
    this.id,
    this.categoryId,
    this.subCategoryId,
    this.productName,
    this.productDescription,
    this.productColorsImages,
    this.unitsPerBox,
    this.weightPerBox,
    this.length,
    this.width,
    this.height,
    this.technicalVideoUrl,
    this.specifications,
    this.category,
    this.subCategory,
    this.isWishlisted,
  });

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    productName = json['product_name'];
    productDescription = json['product_description'];

    if (json['product_colors_images'] != null) {
      productColorsImages = <ProductColorImage>[];
      json['product_colors_images'].forEach((v) {
        productColorsImages!.add(ProductColorImage.fromJson(v));
      });
    }

    unitsPerBox = json['units_per_box'];
    weightPerBox = json['weight_per_box'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    technicalVideoUrl = json['technical_video_url'];

    if (json['specifications'] != null) {
      specifications = List<String>.from(json['specifications']);
    }

    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;

    subCategory = json['sub_category'] != null
        ? SubCategory.fromJson(json['sub_category'])
        : null;

    isWishlisted = json['is_wishlisted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['product_name'] = productName;
    data['product_description'] = productDescription;

    if (productColorsImages != null) {
      data['product_colors_images'] = productColorsImages!
          .map((v) => v.toJson())
          .toList();
    }

    data['units_per_box'] = unitsPerBox;
    data['weight_per_box'] = weightPerBox;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['technical_video_url'] = technicalVideoUrl;
    data['specifications'] = specifications;

    if (category != null) {
      data['category'] = category!.toJson();
    }

    if (subCategory != null) {
      data['sub_category'] = subCategory!.toJson();
    }

    data['is_wishlisted'] = isWishlisted;

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
      images = (json['images'] as List).map((e) => e.toString()).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['color_id'] = colorId;
    data['color_name'] = colorName;
    data['color_code'] = colorCode;
    data['images'] = images;
    return data;
  }
}

class Category {
  int? id;
  String? categoryName;

  Category({this.id, this.categoryName});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['category_name'] = categoryName;
    return data;
  }
}

class SubCategory {
  int? id;
  int? categoryId;
  String? subCategoryName;

  SubCategory({this.id, this.categoryId, this.subCategoryName});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryName = json['sub_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['sub_category_name'] = subCategoryName;
    return data;
  }
}
