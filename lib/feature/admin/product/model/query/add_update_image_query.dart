import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class AddUpdateImageQuery {
  int? productId;
  int? colorId;
  String? colorName;
  String? colorCode;
  List<String>? existingImgNames;
  List<PlatformFile>? colorImages;

  AddUpdateImageQuery({
    this.productId,
    this.colorId,
    this.colorName,
    this.colorCode,
    this.existingImgNames,
    this.colorImages,
  });

  factory AddUpdateImageQuery.fromJson(Map<String, dynamic> json) {
    return AddUpdateImageQuery(
      productId: json['product_id'],
      colorId: json['color_id'],
      colorName: json['color_name'],
      colorCode: json['color_code'],
      existingImgNames: json['existing_img_names'] != null
          ? List<String>.from(json['existing_img_names'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'color_id': colorId,
      'color_name': colorName,
      'color_code': colorCode,
      'existing_img_names': existingImgNames,
    };
  }

  Future<FormData> toFormData() async {
    final formData = FormData();

    if (productId != null) {
      formData.fields.add(MapEntry('product_id', productId.toString()));
    }

    if (colorId != null) {
      formData.fields.add(MapEntry('color_id', colorId.toString()));
    }

    if (colorName != null) {
      formData.fields.add(MapEntry('color_name', colorName!));
    }

    if (colorCode != null) {
      formData.fields.add(MapEntry('color_code', colorCode!));
    }

    if (existingImgNames != null) {
      for (int i = 0; i < existingImgNames!.length; i++) {
        formData.fields.add(
          MapEntry('existing_img_names[$i]', existingImgNames![i]),
        );
      }
    }

    if (colorImages != null) {
      for (int i = 0; i < colorImages!.length; i++) {
        final file = colorImages![i];

        if (file.path != null) {
          formData.files.add(
            MapEntry(
              'color_img[$i]',
              await MultipartFile.fromFile(
                file.path!,
                filename: file.path!.split('/').last,
              ),
            ),
          );
        }
      }
    }

    return formData;
  }
}
