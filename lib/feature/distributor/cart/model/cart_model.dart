class CartModel {
  CartModel({
    this.id,
    this.distributorId,
    this.productId,
    this.qty,
    this.colorCode,
    this.price,
    this.unitsPerBox,
    this.weightPerBox,
    this.totalWeight,
    this.totalCbm,
    this.createdAt,
    this.updatedAt,
  });

  CartModel.fromJson(dynamic json) {
    id = json['id'];
    distributorId = json['distributor_id'];
    productId = json['product_id'];
    qty = json['qty'];
    colorCode = json['color_code'];
    price = json['price'];
    unitsPerBox = json['units_per_box'];
    weightPerBox = json['weight_per_box'];
    totalWeight = json['total_weight'];
    totalCbm = json['total_cbm'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  num? distributorId;
  num? productId;
  num? qty;
  String? colorCode;
  dynamic price;
  num? unitsPerBox;
  String? weightPerBox;
  String? totalWeight;
  String? totalCbm;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['distributor_id'] = distributorId;
    map['product_id'] = productId;
    map['qty'] = qty;
    map['color_code'] = colorCode;
    map['price'] = price;
    map['units_per_box'] = unitsPerBox;
    map['weight_per_box'] = weightPerBox;
    map['total_weight'] = totalWeight;
    map['total_cbm'] = totalCbm;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
