class NotificationModel {
  int? id;
  int? orderId;
  String? title;
  String? message;
  bool? isRead;
  String? time;

  NotificationModel({
    this.id,
    this.orderId,
    this.title,
    this.message,
    this.isRead,
    this.time,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    title = json['title'];
    message = json['message'];
    isRead = json['is_read'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'title': title,
      'message': message,
      'is_read': isRead,
      'time': time,
    };
  }
}
