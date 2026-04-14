import 'package:dio/dio.dart';
import 'package:purosis/feature/admin/product/model/image_model.dart';

class AddProductQuery {
  AddProductQuery({
    this.productId,
    this.productName,
    this.categoryId,
    this.subCategoryId,
    this.description,
    this.unitsPerBox,
    this.weightPerBox,
    this.length,
    this.width,
    this.height,
    this.technicalVideoUrl,
    this.specifications,
    this.imageModelList,
  });

  AddProductQuery.fromJson(dynamic json) {
    productId = json['product_id'];
    productName = json['product_name'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    description = json['description'];
    unitsPerBox = json['units_per_box'];
    weightPerBox = json['weight_per_box'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    technicalVideoUrl = json['technical_video_url'];
    specifications = json['specifications'];
    imageModelList = json['image_model_list'];
  }
  int? productId;
  String? productName;
  num? categoryId;
  num? subCategoryId;
  String? description;
  String? unitsPerBox;
  String? weightPerBox;
  String? length;
  String? width;
  String? height;
  String? technicalVideoUrl;
  List<String>? specifications;
  List<ImageModel>? imageModelList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['product_name'] = productName;
    map['category_id'] = categoryId;
    map['sub_category_id'] = subCategoryId;
    map['description'] = description;
    map['units_per_box'] = unitsPerBox;
    map['weight_per_box'] = weightPerBox;
    map['length'] = length;
    map['width'] = width;
    map['height'] = height;
    map['technical_video_url'] = technicalVideoUrl;
    map['image_model_list'] = imageModelList;
    return map;
  }

  Future<FormData> toFormData() async {
    final Map<String, dynamic> map = {};

    if (productId != null) map['product_id'] = productId;
    if (productName != null) map['product_name'] = productName;
    if (categoryId != null) map['category_id'] = categoryId;
    if (subCategoryId != null) map['sub_category_id'] = subCategoryId;
    if (description != null) map['description'] = description;
    if (unitsPerBox != null) map['units_per_box'] = unitsPerBox;
    if (weightPerBox != null) map['weight_per_box'] = weightPerBox;
    if (length != null) map['length'] = length;
    if (width != null) map['width'] = width;
    if (height != null) map['height'] = height;
    if (technicalVideoUrl != null) {
      map['technical_video_url'] = technicalVideoUrl;
    }
    if (specifications != null) {
      for (int i = 0; i < specifications!.length; i++) {
        map['specifications[$i]'] = specifications![i];
      }
    }
    for (int i = 0; i < (imageModelList?.length ?? 0); i++) {
      final image = imageModelList![i];

      map["product_img[$i][color_name]"] = image.colorName;
      map["product_img[$i][color_code]"] = image.colorCode;

      if (image.filePath != null && image.filePath!.isNotEmpty) {
        for (int j = 0; j < image.filePath!.length; j++) {
          final file = image.filePath![j];

          map["product_img[$i][color_image][$j]"] =
              await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              );
        }
      }
    }

    return FormData.fromMap(map);
  }
}
