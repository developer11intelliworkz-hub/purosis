class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.otp,
    this.otpExpiresAt,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    otp = json['otp'];
    otpExpiresAt = json['otp_expires_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }
  num? id;
  String? name;
  String? email;
  String? phoneNo;
  dynamic otp;
  dynamic otpExpiresAt;
  String? createdAt;
  String? updatedAt;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone_no'] = phoneNo;
    map['otp'] = otp;
    map['otp_expires_at'] = otpExpiresAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['token'] = token;
    return map;
  }
}
