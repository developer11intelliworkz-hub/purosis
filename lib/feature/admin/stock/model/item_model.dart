class ItemModel {
  int? id;
  String? serialNo;
  String? itemName;
  int? qty;
  String? notes;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  ItemModel({
    this.id,
    this.serialNo,
    this.itemName,
    this.qty,
    this.notes,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNo = json['serial_no'];
    itemName = json['item_name'];
    qty = json['qty'];
    notes = json['notes'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['serial_no'] = serialNo;
    data['item_name'] = itemName;
    data['qty'] = qty;
    data['notes'] = notes;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
