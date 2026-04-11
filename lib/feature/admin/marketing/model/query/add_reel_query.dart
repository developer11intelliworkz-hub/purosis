import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class AddReelQuery {
  AddReelQuery({
    this.id,
    this.title,
    this.category,
    this.month,
    this.year,
    this.mediaFile,
    this.thumbnailImage,
    this.description,
    this.isFeatured,
  });

  AddReelQuery.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    month = json['month'];
    year = json['year'];
    mediaFile = json['media_file'];
    thumbnailImage = json['thumbnail_image'];
    description = json['description'];
    isFeatured = json['is_featured'];
  }

  num? id;
  String? title;
  int? category;
  String? month;
  String? year;
  PlatformFile? mediaFile;
  PlatformFile? thumbnailImage;
  String? description;
  int? isFeatured;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['category'] = category;
    map['month'] = month;
    map['year'] = year;
    map['media_file'] = mediaFile;
    map['thumbnail_image'] = thumbnailImage;
    map['description'] = description;
    map['is_featured'] = isFeatured;
    return map;
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      if (id != null) "reel_id": id,
      if (title != null) "title": title,
      if (category != null) "category": category,
      if (month != null) "month": month,
      if (year != null) "year": year,
      if (description != null) "description": description,
      if (isFeatured != null) "is_featured": isFeatured,

      if (mediaFile != null)
        "media_file": MultipartFile.fromBytes(
          mediaFile!.bytes!.toList(),
          filename: mediaFile!.path!.split('/').last,
        ),

      if (thumbnailImage != null)
        "thumbnail_image": MultipartFile.fromBytes(
          thumbnailImage!.bytes!.toList(),
          filename: thumbnailImage!.path!.split('/').last,
        ),
    });
  }
}
