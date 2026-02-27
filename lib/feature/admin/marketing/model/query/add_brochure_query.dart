import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class AddBrochureQuery {
  AddBrochureQuery({
    this.id,
    this.title,
    this.category,
    this.month,
    this.year,
    this.description,
    this.isFeatured,
    this.mediaFile,
  });

  AddBrochureQuery.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    month = json['month'];
    year = json['year'];
    description = json['description'];
    isFeatured = json['is_featured'];
    mediaFile = json['media_file'];
  }

  num? id;
  String? title;
  String? category;
  String? month;
  String? year;
  String? description;
  int? isFeatured;
  PlatformFile? mediaFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['category'] = category;
    map['month'] = month;
    map['year'] = year;
    map['description'] = description;
    map['is_featured'] = isFeatured;
    map['media_file'] = mediaFile;
    return map;
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      if (id != null) "brochure_id": id,
      "title": title,
      "category": category,
      "month": month,
      "year": year,
      "description": description,
      "is_featured": isFeatured,
      if (mediaFile != null)
        "media_file": MultipartFile.fromFile(
          mediaFile!.path!,
          filename: mediaFile!.path!.split('/').last,
          contentType: DioMediaType.parse("application/pdf"),
        ),
    });
  }
}
