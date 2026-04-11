import 'item_model.dart';

class HistoryModel {
  int? id;
  String? serialNo;
  String? type;
  String? itemId;
  int? qty;
  String? recipientId;
  String? notes;
  String? createdAt;
  String? updatedAt;
  ItemModel? item;
  RecipientModel? recipient;

  HistoryModel({
    this.id,
    this.serialNo,
    this.type,
    this.itemId,
    this.qty,
    this.recipientId,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.item,
    this.recipient,
  });

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNo = json['serial_no'];
    type = json['type'];
    itemId = json['item_id'];
    qty = json['qty'];
    recipientId = json['recipient_id'];
    notes = json['notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    item = json['item'] != null ? ItemModel.fromJson(json['item']) : null;
    recipient = json['recipient'] != null
        ? RecipientModel.fromJson(json['recipient'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['serial_no'] = serialNo;
    data['type'] = type;
    data['item_id'] = itemId;
    data['qty'] = qty;
    data['recipient_id'] = recipientId;
    data['notes'] = notes;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    if (item != null) {
      data['item'] = item!.toJson();
    }

    if (recipient != null) {
      data['recipient'] = recipient!.toJson();
    }

    return data;
  }
}

class RecipientModel {
  int? id;
  String? name;
  String? companyName;
  String? email;
  String? phoneNo;
  String? alternateMobileNo;
  String? landlineNo;
  String? whatsappNo;
  String? gstNumber;
  String? area;
  String? billingAddress;
  String? shippingAddressLine;
  String? shippingAddressPincode;
  String? logo;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  RecipientModel({
    this.id,
    this.name,
    this.companyName,
    this.email,
    this.phoneNo,
    this.alternateMobileNo,
    this.landlineNo,
    this.whatsappNo,
    this.gstNumber,
    this.area,
    this.billingAddress,
    this.shippingAddressLine,
    this.shippingAddressPincode,
    this.logo,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  RecipientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    alternateMobileNo = json['alternate_mobile_no'];
    landlineNo = json['landline_no'];
    whatsappNo = json['whatsapp_no'];
    gstNumber = json['gst_number'];
    area = json['area'];
    billingAddress = json['billing_address'];
    shippingAddressLine = json['shipping_address_line'];
    shippingAddressPincode = json['shipping_address_pincode'];
    logo = json['logo'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
      'gst_number': gstNumber,
      'area': area,
      'billing_address': billingAddress,
      'shipping_address_line': shippingAddressLine,
      'shipping_address_pincode': shippingAddressPincode,
      'logo': logo,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
