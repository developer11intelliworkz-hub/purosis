import 'package:dio/dio.dart';

class ActivityLogQuery {
  String? userType;
  int? actorId;

  ActivityLogQuery({this.userType, this.actorId});

  ActivityLogQuery.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    actorId = json['actor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_type'] = userType;
    data['actor_id'] = actorId;
    return data;
  }

  FormData toFormData() {
    final Map<String, dynamic> data = {};

    if (userType != null) {
      data['user_type'] = userType;
    }
    if (actorId != null) {
      data['actor_id'] = actorId;
    }

    return FormData.fromMap(data);
  }
}
