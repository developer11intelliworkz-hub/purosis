import 'package:get/get.dart';
import 'package:purosis/feature/admin/stock/model/history_model.dart';
import 'package:purosis/feature/admin/stock/model/item_model.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../model/query/inward_stock_query.dart';

class StockController extends GetxController {
  ApiService apiService = ApiService();
  int selectedList = 1;
  bool isItemLoading = false;
  bool isHistoryLoading = false;
  bool isDeleteLoading = false;
  int? deleteIndex;
  List<ItemModel> itemModelList = [];
  List<HistoryModel> historyModelList = [];

  changeListType(int selectedIndex) {
    selectedList = selectedIndex;
    update();
  }

  Future<void> getItemApi() async {
    isItemLoading = true;
    await apiService
        .get(AppUrl.getStockDetailUrl, queryParameters: {"type": "items"})
        .then((response) {
          itemModelList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              itemModelList.add(ItemModel.fromJson(data));
            }
          }
          isItemLoading = false;
          update();
        })
        .catchError((value) {
          isItemLoading = false;
          update();
        });
  }

  Future<void> getHistoryApi() async {
    isHistoryLoading = true;
    await apiService
        .get(
          AppUrl.getStockDetailUrl,
          queryParameters: {"type": "transactions"},
        )
        .then((response) {
          historyModelList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              historyModelList.add(HistoryModel.fromJson(data));
            }
          }
          isHistoryLoading = false;
          update();
        })
        .catchError((value) {
          isHistoryLoading = false;
          update();
        });
  }

  Future<void> deleteStockApi(int? itemId) async {
    isDeleteLoading = true;
    deleteIndex = itemId;
    update();
    InwardStockQuery inwardStockQuery = InwardStockQuery(itemId: itemId);
    await apiService
        .postFormData(
          AppUrl.deleteStockUrl,
          await inwardStockQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            itemModelList.removeAt(
              itemModelList.indexWhere((e) => e.id == itemId),
            );
          } else {
            AppToast.error();
          }
          isDeleteLoading = false;
          update();
        })
        .catchError((value) {
          isDeleteLoading = false;
          update();
        });
  }
}
