import 'package:purosis/model/detail_model.dart';

class ReelsModel {
  ReelsModel({
    this.id,
    this.title,
    this.category,
    this.mediaFile,
    this.thumbnailImage,
    this.month,
    this.year,
    this.description,
    this.isFeatured,
  });

  int? id;
  String? title;
  ProductsModel? category;
  String? mediaFile;
  String? thumbnailImage;
  String? month;
  String? year;
  String? description;
  num? isFeatured;

  ReelsModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];

    category = json['category'] != null
        ? ProductsModel.fromJson(json['category'])
        : null;

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

    map['media_file'] = mediaFile;
    map['thumbnail_image'] = thumbnailImage;
    map['month'] = month;
    map['year'] = year;
    map['description'] = description;
    map['is_featured'] = isFeatured;

    return map;
  }
}
