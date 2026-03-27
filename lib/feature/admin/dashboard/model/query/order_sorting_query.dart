import 'package:dio/dio.dart';

class OrderSortingQuery {
  String? sortBy; // latest OR oldest

  OrderSortingQuery({this.sortBy});

  OrderSortingQuery.fromJson(Map<String, dynamic> json) {
    sortBy = json['sort_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['sort_by'] = sortBy;
    return data;
  }

  FormData toFormData() {
    final formData = FormData();

    if (sortBy != null) {
      formData.fields.add(MapEntry('sort_by', sortBy!));
    }

    return formData;
  }
}
