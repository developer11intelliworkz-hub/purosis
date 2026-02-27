class SubCategoryModel {
  SubCategoryModel({this.id, this.categoryId, this.subCategoryName});

  SubCategoryModel.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryName = json['sub_category_name'];
  }

  num? id;
  num? categoryId;
  String? subCategoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['sub_category_name'] = subCategoryName;
    return map;
  }
}
