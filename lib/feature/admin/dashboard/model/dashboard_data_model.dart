class DashboardDataModel {
  int? confirmedOrders;
  int? totalOrders;
  int? totalDistributors;
  int? totalDealers;
  int? totalProducts;
  int? marketingAssets;

  DashboardDataModel({
    this.confirmedOrders,
    this.totalOrders,
    this.totalDistributors,
    this.totalDealers,
    this.totalProducts,
    this.marketingAssets,
  });

  DashboardDataModel.fromJson(Map<String, dynamic> json) {
    confirmedOrders = json['confirmed_orders'];
    totalOrders = json['total_orders'];
    totalDistributors = json['total_distributors'];
    totalDealers = json['total_dealers'];
    totalProducts = json['total_products'];
    marketingAssets = json['marketing_assets'];
  }

  Map<String, dynamic> toJson() {
    return {
      'confirmed_orders': confirmedOrders,
      'total_orders': totalOrders,
      'total_distributors': totalDistributors,
      'total_dealers': totalDealers,
      'total_products': totalProducts,
      'marketing_assets': marketingAssets,
    };
  }
}
