class SubCategoryQuery {
  SubCategoryQuery({this.categoryId});

  SubCategoryQuery.fromJson(dynamic json) {
    categoryId = json['category_id'];
  }

  num? categoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = categoryId;
    return map;
  }
}
