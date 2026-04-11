import 'package:purosis/model/detail_model.dart';

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

  int? id;
  String? title;
  ProductsModel? category;
  List<String>? mediaFile;
  String? month;
  String? year;
  String? description;
  num? isFeatured;

  LeafletModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];

    category = json['category'] != null
        ? ProductsModel.fromJson(json['category'])
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
