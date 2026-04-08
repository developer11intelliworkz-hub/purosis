class SupportMessageModel {
  int? id;
  int? distributorId;
  String? subject;
  String? productId;
  String? message;
  String? createdAt;
  Distributor? distributor;
  Product? product;

  SupportMessageModel({
    this.id,
    this.distributorId,
    this.subject,
    this.productId,
    this.message,
    this.createdAt,
    this.distributor,
    this.product,
  });

  SupportMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    distributorId = json['distributor_id'];
    subject = json['subject'];
    productId = json['product_id'];
    message = json['message'];
    createdAt = json['created_at'];
    distributor = json['distributor'] != null
        ? Distributor.fromJson(json['distributor'])
        : null;
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['distributor_id'] = distributorId;
    data['subject'] = subject;
    data['product_id'] = productId;
    data['message'] = message;
    data['created_at'] = createdAt;
    if (distributor != null) {
      data['distributor'] = distributor!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Distributor {
  int? id;
  String? name;
  String? companyName;
  String? email;

  Distributor({this.id, this.name, this.companyName, this.email});

  Distributor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    companyName = json['company_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['company_name'] = companyName;
    data['email'] = email;
    return data;
  }
}

class Product {
  int? id;
  String? productName;

  Product({this.id, this.productName});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['product_name'] = productName;
    return data;
  }
}
