import 'package:get/get.dart';
import 'package:purosis/feature/admin/dashboard/model/dashboard_data_model.dart';
import 'package:purosis/feature/admin/dashboard/view/dashboard_view.dart';
import 'package:purosis/feature/admin/marketing/view/marketing_content.dart';
import 'package:purosis/feature/admin/product/view/product_view.dart';
import 'package:purosis/feature/admin/profile/view/admin_profile_view.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../model/order_history_model.dart';

class DashboardControllerAdmin extends GetxController {
  final ApiService apiService = ApiService();
  List<String> screenNameList = [
    "Dashboard",
    "Products",
    "Marketing Assets",
    "Profile",
  ];
  List screenList = [
    DashboardView(),
    ProductView(),
    MarketingContent(),
    AdminProfileView(),
  ];
  int currentIndex = 0;
  DashboardDataModel? dashboardDataModel;
  List<OrderHistoryModel> orderHistoryModelList = [];

  bool isDashboardLoading = false;
  bool isOrderHistoryLoading = false;

  Future<void> getDashboardApi() async {
    isDashboardLoading = true;
    // update();
    await apiService
        .get(AppUrl.getDashboardData)
        .then((response) {
          if (response["success"] == true) {
            dashboardDataModel = DashboardDataModel.fromJson(response['data']);
          }
          isDashboardLoading = false;
          update();
        })
        .catchError((value) {
          isDashboardLoading = false;
          update();
        });
  }

  Future<void> getHistoryApi() async {
    isOrderHistoryLoading = true;
    // update();
    await apiService
        .get(AppUrl.getOrderHistory)
        .then((response) {
          orderHistoryModelList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              orderHistoryModelList.add(OrderHistoryModel.fromJson(data));
            }
          }
          isOrderHistoryLoading = false;
          update();
        })
        .catchError((value) {
          isOrderHistoryLoading = false;
          update();
        });
  }
}
