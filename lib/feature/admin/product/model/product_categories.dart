class ProductCategories {
  ProductCategories({this.id, this.categoryName});

  ProductCategories.fromJson(dynamic json) {
    id = json['id'];
    categoryName = json['category_name'];
  }

  num? id;
  String? categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_name'] = categoryName;
    return map;
  }
}
