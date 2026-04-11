import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class AddLeafletQuery {
  int? leafletId;
  String? title;
  int? category;
  String? month;
  String? year;
  String? description;
  int? isFeatured;
  List<PlatformFile>? mediaFiles;

  AddLeafletQuery({
    this.leafletId,
    this.title,
    this.category,
    this.month,
    this.year,
    this.description,
    this.isFeatured,
    this.mediaFiles,
  });

  AddLeafletQuery.fromJson(Map<String, dynamic> json) {
    leafletId = json['leaflet_id'];
    title = json['title'];
    category = json['category'];
    month = json['month'];
    year = json['year'];
    description = json['description'];
    isFeatured = json['is_featured'];
  }

  Map<String, dynamic> toJson() {
    return {
      'leaflet_id': leafletId,
      'title': title,
      'category': category,
      'month': month,
      'year': year,
      'description': description,
      'is_featured': isFeatured,
    };
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      if (leafletId != null) "leaflet_id": leafletId,
      if (title != null) "title": title,
      if (category != null) "category": category,
      if (month != null) "month": month,
      if (year != null) "year": year,
      if (description != null) "description": description,
      if (isFeatured != null) "is_featured": isFeatured,

      if (mediaFiles != null && mediaFiles!.isNotEmpty)
        "media_file[]": await Future.wait(
          mediaFiles!.map(
            (file) async => MultipartFile.fromFile(
              file.path ?? "",
              filename: file.path?.split('/').last,
              // optional (set based on your file type)
              // contentType: MediaType("image", "jpeg"),
            ),
          ),
        ),
    });
  }
}
