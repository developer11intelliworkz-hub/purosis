class DetailModel {
  List<CategoryItem>? brochureCategory;
  List<CategoryItem>? postCategory;
  List<CategoryItem>? reelCategory;
  List<CategoryItem>? videoCategory;
  List<CategoryItem>? videoType;
  List<CategoryItem>? shippingStatus;
  List<ProductsModel>? products;
  List<String>? userTypes;

  DetailModel({
    this.brochureCategory,
    this.postCategory,
    this.reelCategory,
    this.videoCategory,
    this.videoType,
    this.shippingStatus,
    this.products,
    this.userTypes,
  });

  DetailModel.fromJson(Map<String, dynamic> json) {
    // if (json['brochure_category'] != null) {
    //   brochureCategory = [];
    //   json['brochure_category'].forEach((v) {
    //     brochureCategory!.add(CategoryItem.fromJson(v));
    //   });
    // }

    // if (json['post_category'] != null) {
    //   postCategory = [];
    //   json['post_category'].forEach((v) {
    //     postCategory!.add(CategoryItem.fromJson(v));
    //   });
    // }

    // if (json['reel_category'] != null) {
    //   reelCategory = [];
    //   json['reel_category'].forEach((v) {
    //     reelCategory!.add(CategoryItem.fromJson(v));
    //   });
    // }

    // if (json['video_category'] != null) {
    //   videoCategory = [];
    //   json['video_category'].forEach((v) {
    //     videoCategory!.add(CategoryItem.fromJson(v));
    //   });
    // }

    if (json['video_type'] != null) {
      videoType = [];
      json['video_type'].forEach((v) {
        videoType!.add(CategoryItem.fromJson(v));
      });
    }

    if (json['shipping_status'] != null) {
      shippingStatus = [];
      json['shipping_status'].forEach((v) {
        shippingStatus!.add(CategoryItem.fromJson(v));
      });
    }

    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(ProductsModel.fromJson(v));
      });
    }

    if (json['user_types'] != null) {
      userTypes = List<String>.from(json['user_types']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (brochureCategory != null) {
      data['brochure_category'] = brochureCategory!
          .map((v) => v.toJson())
          .toList();
    }

    if (postCategory != null) {
      data['post_category'] = postCategory!.map((v) => v.toJson()).toList();
    }

    if (reelCategory != null) {
      data['reel_category'] = reelCategory!.map((v) => v.toJson()).toList();
    }

    if (videoCategory != null) {
      data['video_category'] = videoCategory!.map((v) => v.toJson()).toList();
    }

    if (videoType != null) {
      data['video_type'] = videoType!.map((v) => v.toJson()).toList();
    }

    if (shippingStatus != null) {
      data['shipping_status'] = shippingStatus!.map((v) => v.toJson()).toList();
    }

    if (shippingStatus != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }

    if (userTypes != null) {
      data['user_types'] = userTypes;
    }

    return data;
  }
}

class CategoryItem {
  String? key;
  String? value;

  CategoryItem({this.key, this.value});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class ProductsModel {
  int? id;
  String? productName;

  ProductsModel({this.id, this.productName});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'product_name': productName};
  }
}
