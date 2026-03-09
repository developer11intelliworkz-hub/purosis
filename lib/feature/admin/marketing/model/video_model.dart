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

  VideoModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    type = json['type'];
    mediaFile = json['media_file'];
    thumbnailImage = json['thumbnail_image'];
    month = json['month'];
    year = json['year'];
    description = json['description'];
    isFeatured = json['is_featured'];
  }

  num? id;
  String? title;
  String? category;
  String? type;
  String? mediaFile;
  String? thumbnailImage;
  String? month;
  String? year;
  String? description;
  num? isFeatured;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['category'] = category;
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
