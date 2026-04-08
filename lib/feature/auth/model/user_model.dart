class UserModel {
  int? id;
  String? name;
  String? companyName;
  String? email;
  String? phoneNo;
  String? alternateMobileNo;
  String? landlineNo;
  String? whatsappNo;
  String? otp;
  String? otpExpiresAt;
  String? gstNumber;
  String? area;
  String? billingAddress;
  String? shippingAddressLine;
  String? shippingAddressPinCode;
  String? logo;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? token;
  String? role;
  String? profilePhoto;

  UserModel({
    this.id,
    this.name,
    this.companyName,
    this.email,
    this.phoneNo,
    this.alternateMobileNo,
    this.landlineNo,
    this.whatsappNo,
    this.otp,
    this.otpExpiresAt,
    this.gstNumber,
    this.area,
    this.billingAddress,
    this.shippingAddressLine,
    this.shippingAddressPinCode,
    this.logo,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.role,
    this.profilePhoto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      companyName: json['company_name'],
      email: json['email'],
      phoneNo: json['phone_no'],
      alternateMobileNo: json['alternate_mobile_no'],
      landlineNo: json['landline_no'],
      whatsappNo: json['whatsapp_no'],
      otp: json['otp'],
      otpExpiresAt: json['otp_expires_at'],
      gstNumber: json['gst_number'],
      area: json['area'],
      billingAddress: json['billing_address'],
      shippingAddressLine: json['shipping_address_line'],
      shippingAddressPinCode: json['shipping_address_pincode'],
      logo: json['logo'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      token: json['token'],
      role: json['role'],
      profilePhoto: json['profile_photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'company_name': companyName,
      'email': email,
      'phone_no': phoneNo,
      'alternate_mobile_no': alternateMobileNo,
      'landline_no': landlineNo,
      'whatsapp_no': whatsappNo,
      'otp': otp,
      'otp_expires_at': otpExpiresAt,
      'gst_number': gstNumber,
      'area': area,
      'billing_address': billingAddress,
      'shipping_address_line': shippingAddressLine,
      'shipping_address_pincode': shippingAddressPinCode,
      'logo': logo,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'token': token,
      'role': role,
      'profile_photo': profilePhoto,
    };
  }
}
