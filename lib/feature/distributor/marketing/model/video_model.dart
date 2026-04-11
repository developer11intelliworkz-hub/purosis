class VideoModel {
  VideoModel({
    this.id,
    this.title,
    this.category,
    this.type,
    this.mediaFile,
    this.thumbnailImage,
    this.month,
    this.year,
    this.description,
    this.isFeatured,
  });

  num? id;
  String? title;
  CategoryModel? category;
  String? type;
  String? mediaFile;
  String? thumbnailImage;
  String? month;
  String? year;
  String? description;
  num? isFeatured;

  VideoModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];

    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;

    type = json['type'];
    mediaFile = json['media_file'];
    thumbnailImage = json['thumbnail_image'];
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

    map['type'] = type;
    map['media_file'] = mediaFile;
    map['thumbnail_image'] = thumbnailImage;
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
