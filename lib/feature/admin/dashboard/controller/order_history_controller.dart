import 'package:flutter/material.dart';
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

  Map<int, String> tempSelectedStatus = {};

  void sortOrder() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: shippingStatusList.map((e) {
            return ListTile(
              title: Text(e.value ?? ""),
              onTap: () {
                Get.back();
                applySortByStatus(e.key ?? "");
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  String getStatusLabel(String key) {
    return shippingStatusList.firstWhereOrNull((e) => e.key == key)?.value ??
        key;
  }

  void applySortByStatus(String status) {
    orderHistoryModelFilterList = orderHistoryModelList
        .where((e) => e.shippingStatus == status)
        .toList();

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

  List<CategoryItem> get filteredShippingStatusList {
    return shippingStatusList
        .where(
          (e) =>
              e.key == "in-process" ||
              e.key == "shipped" ||
              e.key == "delivered",
        )
        .toList();
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
    switch (status.toLowerCase()) {
      case "pending":
      case "approved":
      case "confirmed":
        return const Color(0xFFF2EBD2); // Yellow

      case "in-process":
      case "processing":
        return const Color(0xFFD2E8F2); // Blue

      case "shipped":
        return const Color(0xFFD2E8F2); // Blue (same group)

      case "delivered":
        return const Color(0xFFE5D0EF); // Purple

      case "declined":
        return const Color(0xFFF2D2D2); // Red

      default:
        return const Color(0xFFF2EBD2);
    }
  }
}
