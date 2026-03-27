import 'package:get/get.dart' hide FormData;
import 'package:purosis/feature/admin/dashboard/model/order_detail_model.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/api_service.dart';
import '../model/order_history_model.dart';

class OrderHistoryController extends GetxController {
  final ApiService apiService = ApiService();

  bool isLatest = true;
  bool isOrderHistoryLoading = false;
  bool isOrderDetailLoading = false;
  List<OrderHistoryModel> orderHistoryModelList = [];
  List<OrderHistoryModel> orderHistoryModelFilterList = [];
  OrderDetailModel? orderDetailModel;

  sortOrder() {
    isLatest = !isLatest;
    orderHistoryModelFilterList = orderHistoryModelFilterList.reversed.toList();
    update();
  }

  void search(String query) {
    if (query.isNotEmpty && query.length >= 4) {
      final item = orderHistoryModelList
          .where(
            (item) =>
                item.orderNumber?.toLowerCase().contains(query.toLowerCase()) ??
                false,
          )
          .toList();
      if (isLatest) {
        orderHistoryModelFilterList = item;
      } else {
        orderHistoryModelFilterList = item.reversed.toList();
      }
      update();
    }
    if (query.isEmpty) {
      orderHistoryModelFilterList = orderHistoryModelList;
      update();
    }
  }

  Future<void> getHistoryApi() async {
    isOrderHistoryLoading = true;
    update();
    await apiService
        .get(AppUrl.getOrderHistory)
        .then((response) {
          orderHistoryModelList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              orderHistoryModelList.add(OrderHistoryModel.fromJson(data));
              orderHistoryModelFilterList.add(OrderHistoryModel.fromJson(data));
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

  Future<void> getOrderDetailApi(int orderId) async {
    isOrderDetailLoading = true;
    // update();
    await apiService
        .get(AppUrl.getOrderDetail, queryParameters: {"order_id": orderId})
        .then((response) {
          if (response["success"] == true) {
            orderDetailModel = OrderDetailModel.fromJson(response['data']);
          }
          isOrderDetailLoading = false;
          update();
        })
        .catchError((value) {
          isOrderDetailLoading = false;
          update();
        });
  }
}
