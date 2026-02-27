class ProductModel {
  ProductModel({this.id, this.productName, this.productDescription});

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    productName = json['product_name'];
    productDescription = json['product_description'];
  }

  num? id;
  String? productName;
  String? productDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_name'] = productName;
    map['product_description'] = productDescription;
    return map;
  }
}
