class BannerModel {
  int? id;
  String? type;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  BannerModel({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
