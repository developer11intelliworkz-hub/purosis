import 'dart:ui';

import 'package:get/get.dart' hide FormData;
import 'package:purosis/feature/admin/dashboard/model/order_detail_model.dart';
import 'package:purosis/feature/admin/dashboard/model/query/approve_decline_query.dart';
import 'package:purosis/feature/admin/dashboard/model/query/status_change_query.dart';
import 'package:purosis/utils/app_toast.dart';

import '../../../../consts/app_url.dart';
import '../../../../model/detail_model.dart';
import '../../../../utils/api_service.dart';
import '../../../../utils/common_api.dart';
import '../model/order_history_model.dart';

class OrderHistoryController extends GetxController {
  final ApiService apiService = ApiService();

  bool isLatest = true;
  bool isOrderHistoryLoading = false;
  bool isOrderDetailLoading = false;
  bool isApproveDeclineLoading = false;
  bool isUpdateShippingStatusLoading = false;
  List<OrderHistoryModel> orderHistoryModelList = [];
  List<OrderHistoryModel> orderHistoryModelFilterList = [];
  OrderDetailModel? orderDetailModel;
  List<CategoryItem> shippingStatusList = [];
  int? selectedApproveDeclineIndex;
  String? selectedType;
  int? changeStatusIndex;

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
        .then((response) async {
          orderHistoryModelList.clear();
          if (response["success"] == true) {
            shippingStatusList =
                (await CommonApi().getDetailApi()).shippingStatus ?? [];
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

  Future<void> approveDeclineOrderApi(String actionType, int id) async {
    isApproveDeclineLoading = true;
    selectedApproveDeclineIndex = id;
    selectedType = actionType;
    update();
    ApproveDeclineQuery approveDeclineQuery = ApproveDeclineQuery(
      action: actionType,
      orderId: id,
    );
    await apiService
        .postFormData(
          AppUrl.approveDeclineOrderUrl,
          approveDeclineQuery.toFormData(),
        )
        .then((response) async {
          if (response["success"] == true) {
            selectedApproveDeclineIndex = null;
            selectedType = null;
            orderHistoryModelList[orderHistoryModelList.indexWhere(
                      (e) => e.id == id,
                    )]
                    .shippingStatus =
                actionType;
            orderHistoryModelFilterList[orderHistoryModelFilterList.indexWhere(
                      (e) => e.id == id,
                    )]
                    .shippingStatus =
                actionType;
          } else {
            AppToast.error();
          }
          isApproveDeclineLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isApproveDeclineLoading = false;
          update();
        });
  }

  Future<void> updateShippingStatusApi(String actionType, int id) async {
    isUpdateShippingStatusLoading = true;
    changeStatusIndex = id;
    // update();
    StatusChangeQuery statusChangeQuery = StatusChangeQuery(
      shippingStatus: actionType,
      orderId: id,
    );
    await apiService
        .postFormData(
          AppUrl.updateShippingStatusUrl,
          statusChangeQuery.toFormData(),
        )
        .then((response) async {
          if (response["success"] == true) {
            changeStatusIndex = null;
            orderHistoryModelList[orderHistoryModelList.indexWhere(
                      (e) => e.id == id,
                    )]
                    .shippingStatus =
                actionType;
            orderHistoryModelFilterList[orderHistoryModelFilterList.indexWhere(
                      (e) => e.id == id,
                    )]
                    .shippingStatus =
                actionType;
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isUpdateShippingStatusLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isUpdateShippingStatusLoading = false;
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

  Color getStatusColor(String status) {
    if (status.toLowerCase() == "pending") {
      return Color(0xFFF2EBD2);
    } else if (status.toLowerCase() == "approved") {
      return Color(0xFFF2EBD2);
    } else if (status.toLowerCase() == "confirmed") {
      return Color(0xFFF2EBD2);
    } else if (status.toLowerCase() == "in-process") {
      return Color(0xFFD2E8F2);
    } else if (status.toLowerCase() == "delivered") {
      return Color(0xFFE5D0EF);
    } else if (status.toLowerCase() == "declined") {
      return Color(0xFFF2D2D2);
    } else {
      return Color(0xFFF2EBD2);
    }
  }
}
