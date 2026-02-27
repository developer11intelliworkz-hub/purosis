import 'package:dio/dio.dart';
import 'package:purosis/feature/admin/product/model/image_model.dart';

class AddProductQuery {
  AddProductQuery({
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
    this.imageModelList,
  });

  AddProductQuery.fromJson(dynamic json) {
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
    imageModelList = json['image_model_list'];
  }
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
  List<ImageModel>? imageModelList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    for (int i = 0; i < (imageModelList?.length ?? 0); i++) {
      map["product_img[$i][color_name]"] = imageModelList?[i].colorName;
      map["product_img[$i][color_code]"] = imageModelList?[i].colorCode;
      map["product_img[$i][color_image]"] = imageModelList?[i].colorName;
      await Future.wait(
        imageModelList![i].filePath!.map(
          (file) => MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        ),
      );
    }

    return FormData.fromMap(map);
  }
}
