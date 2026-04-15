class DashboardDataModel {
  List<BannerModel>? banners;
  int? totalPurchasedOrderCount;
  int? promoItemOrderCount;

  DashboardDataModel({
    this.banners,
    this.totalPurchasedOrderCount,
    this.promoItemOrderCount,
  });

  DashboardDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = [];
      json['banners'].forEach((v) {
        banners!.add(BannerModel.fromJson(v));
      });
    }
    totalPurchasedOrderCount = json['total_purchased_order_count'];
    promoItemOrderCount = json['promo_item_order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    data['total_purchased_order_count'] = totalPurchasedOrderCount;
    data['promo_item_order_count'] = promoItemOrderCount;
    return data;
  }
}

class BannerModel {
  int? id;
  String? type;
  String? image;

  BannerModel({this.id, this.type, this.image});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['image'] = image;
    return data;
  }
}
