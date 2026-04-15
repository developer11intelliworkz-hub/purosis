// To parse this JSON data, do
//
//     final adminNotificationModel = adminNotificationModelFromMap(jsonString);

import 'dart:convert';

AdminNotificationModel adminNotificationModelFromMap(String str) =>
    AdminNotificationModel.fromMap(json.decode(str));

String adminNotificationModelToMap(AdminNotificationModel data) =>
    json.encode(data.toMap());

class AdminNotificationModel {
  bool? success;
  String? message;
  List<NotificationDatum>? data;

  AdminNotificationModel({this.success, this.message, this.data});

  factory AdminNotificationModel.fromMap(Map<String, dynamic> json) =>
      AdminNotificationModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<NotificationDatum>.from(
                json["data"]!.map((x) => NotificationDatum.fromMap(x)),
              ),
      );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class NotificationDatum {
  int? id;
  NotificationDistributor? distributor;
  int? orderId;
  String? title;
  String? message;
  bool? isRead;
  String? time;

  NotificationDatum({
    this.id,
    this.distributor,
    this.orderId,
    this.title,
    this.message,
    this.isRead,
    this.time,
  });

  factory NotificationDatum.fromMap(Map<String, dynamic> json) =>
      NotificationDatum(
        id: json["id"],
        distributor: json["distributor"] == null
            ? null
            : NotificationDistributor.fromMap(json["distributor"]),
        orderId: json["order_id"],
        title: json["title"],
        message: json["message"],
        isRead: json["is_read"],
        time: json["time"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "distributor": distributor?.toMap(),
    "order_id": orderId,
    "title": title,
    "message": message,
    "is_read": isRead,
    "time": time,
  };
}

class NotificationDistributor {
  int? id;
  String? name;
  String? companyName;
  String? email;

  NotificationDistributor({this.id, this.name, this.companyName, this.email});

  factory NotificationDistributor.fromMap(Map<String, dynamic> json) =>
      NotificationDistributor(
        id: json["id"],
        name: json["name"],
        companyName: json["company_name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "company_name": companyName,
    "email": email,
  };
}
