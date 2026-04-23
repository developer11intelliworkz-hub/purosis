import 'package:purosis/model/detail_model.dart';

class PostsModel {
  PostsModel({
    this.id,
    this.title,
    this.category,
    this.mediaFile,
    this.month,
    this.year,
    this.description,
    this.isFeatured,
  });

  int? id;
  String? title;
  ProductsModel? category;
  String? mediaFile;
  String? month;
  dynamic year;
  String? description;
  num? isFeatured;

  PostsModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];

    category = json['category'] != null
        ? ProductsModel.fromJson(json['category'])
        : null;

    mediaFile = json['media_file'];
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
    map['month'] = month;
    map['year'] = year;
    map['description'] = description;
    map['is_featured'] = isFeatured;

    return map;
  }
}
