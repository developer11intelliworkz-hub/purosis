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

  LeafletModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    if (json['media_file'] != null) {
      mediaFile = [];
      json['media_file'].forEach((v) {
        mediaFile?.add(v);
      });
    }
    month = json['month'];
    year = json['year'];
    description = json['description'];
    isFeatured = json['is_featured'];
  }

  num? id;
  String? title;
  String? category;
  List<String>? mediaFile;
  String? month;
  String? year;
  String? description;
  num? isFeatured;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['category'] = category;
    if (mediaFile != null) {
      map['media_file'] = mediaFile?.toList();
    }
    map['month'] = month;
    map['year'] = year;
    map['description'] = description;
    map['is_featured'] = isFeatured;
    return map;
  }
}
