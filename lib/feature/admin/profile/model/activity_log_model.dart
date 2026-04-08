class ActivityLogModel {
  ActivityLogModel({
    this.id,
    this.eventType,
    this.actorType,
    this.actorId,
    this.orderId,
    this.ipAddress,
    this.userAgent,
    this.country,
    this.state,
    this.city,
    this.postalCode,
    this.address,
    this.latitude,
    this.longitude,
    this.eventAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  ActivityLogModel.fromJson(dynamic json) {
    id = json['id'];
    eventType = json['event_type'];
    actorType = json['actor_type'];
    actorId = json['actor_id'];
    orderId = json['order_id'];
    ipAddress = json['ip_address'];
    userAgent = json['user_agent'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    postalCode = json['postal_code'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    eventAt = json['event_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  num? id;
  String? eventType;
  String? actorType;
  num? actorId;
  dynamic orderId;
  String? ipAddress;
  String? userAgent;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic postalCode;
  dynamic address;
  String? latitude;
  String? longitude;
  String? eventAt;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['event_type'] = eventType;
    map['actor_type'] = actorType;
    map['actor_id'] = actorId;
    map['order_id'] = orderId;
    map['ip_address'] = ipAddress;
    map['user_agent'] = userAgent;
    map['country'] = country;
    map['state'] = state;
    map['city'] = city;
    map['postal_code'] = postalCode;
    map['address'] = address;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['event_at'] = eventAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }
}
