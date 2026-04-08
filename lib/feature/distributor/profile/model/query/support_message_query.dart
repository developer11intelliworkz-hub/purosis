import 'package:dio/dio.dart';

class SupportMessageQuery {
  String? subject;
  int? productId;
  String? message;

  SupportMessageQuery({this.subject, this.productId, this.message});

  SupportMessageQuery.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    productId = json['product_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['subject'] = subject;
    data['product_id'] = productId;
    data['message'] = message;
    return data;
  }

  FormData toFormData() {
    return FormData.fromMap({
      'subject': subject,
      'product_id': productId,
      'message': message,
    });
  }
}
