import 'package:dio/dio.dart';

class OutwardStockQuery {
  OutwardStockQuery({this.itemId, this.qty, this.distributorId, this.notes});

  OutwardStockQuery.fromJson(dynamic json) {
    itemId = json['item_id'];
    qty = json['qty'];
    qty = json['distributor_id'];
    notes = json['notes'];
  }

  String? itemId;
  String? qty;
  String? distributorId;
  String? notes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_id'] = itemId;
    map['qty'] = qty;
    map['distributor_id'] = distributorId;
    map['notes'] = notes;
    return map;
  }

  Future<FormData> toFormData() async {
    final data = FormData.fromMap({
      if (itemId != null) "item_id": itemId,
      if (qty != null) "qty": qty,
      if (qty != null) "distributor_id": distributorId,
      if (notes != null) "notes": notes,
    });

    return data;
  }
}
