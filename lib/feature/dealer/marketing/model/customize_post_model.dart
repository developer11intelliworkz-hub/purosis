class CustomizePostModel {
  String? imageUrl;
  String? logoUrl;
  String? address;
  String? mail;
  String? call;
  String? whatsapp;

  CustomizePostModel({
    this.imageUrl,
    this.logoUrl,
    this.address,
    this.mail,
    this.call,
    this.whatsapp,
  });

  factory CustomizePostModel.fromJson(Map<String, dynamic> json) {
    return CustomizePostModel(
      imageUrl: json['image_url'],
      logoUrl: json['logo_url'],
      address: json['address'],
      mail: json['mail'],
      call: json['call'],
      whatsapp: json['whatsapp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'logo_url': logoUrl,
      'address': address,
      'mail': mail,
      'call': call,
      'whatsapp': whatsapp,
    };
  }
}
