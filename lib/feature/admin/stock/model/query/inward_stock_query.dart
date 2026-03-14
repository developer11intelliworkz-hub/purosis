import 'package:dio/dio.dart';

class InwardStockQuery {
  InwardStockQuery({this.itemName, this.qty, this.notes});

  InwardStockQuery.fromJson(dynamic json) {
    itemName = json['item_name'];
    qty = json['qty'];
    notes = json['notes'];
  }

  String? itemName;
  String? qty;
  String? notes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_name'] = itemName;
    map['qty'] = qty;
    map['notes'] = notes;
    return map;
  }

  Future<FormData> toFormData() async {
    final data = FormData.fromMap({
      if (itemName != null) "item_name": itemName,
      if (qty != null) "qty": qty,
      if (notes != null) "notes": notes,
    });

    return data;
  }
}
