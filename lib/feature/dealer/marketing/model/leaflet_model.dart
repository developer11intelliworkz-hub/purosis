class LeafletModel {
  LeafletModel({
    this.id,
    this.title,
    this.category,
    this.mediaFile,
    this.month,
    this.year,
    this.description,
    this.isFeatured,
  });

  num? id;
  String? title;
  CategoryModel? category;
  List<String>? mediaFile;
  String? month;
  String? year;
  String? description;
  num? isFeatured;

  LeafletModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];

    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;

    if (json['media_file'] != null) {
      mediaFile = List<String>.from(json['media_file']);
    }

    month = json['month'];
    year = json['year'];
    description = json['description'];
    isFeatured = json['is_featured'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;

    if (category != null) {
      map['category'] = category!.toJson();
    }

    if (mediaFile != null) {
      map['media_file'] = mediaFile;
    }

    map['month'] = month;
    map['year'] = year;
    map['description'] = description;
    map['is_featured'] = isFeatured;

    return map;
  }
}

class CategoryModel {
  num? id;
  String? productName;

  CategoryModel({this.id, this.productName});

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_name'] = productName;
    return map;
  }
}
