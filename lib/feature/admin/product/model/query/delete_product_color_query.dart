import 'package:dio/dio.dart';

class DeleteProductColorQuery {
  int? colorId;

  DeleteProductColorQuery({this.colorId});

  DeleteProductColorQuery.fromJson(Map<String, dynamic> json) {
    colorId = json['color_id'];
  }

  Map<String, dynamic> toJson() {
    return {'color_id': colorId};
  }

  Future<FormData> toFormData() async {
    final formData = FormData();

    if (colorId != null) {
      formData.fields.add(MapEntry('color_id', colorId.toString()));
    }

    return formData;
  }
}
