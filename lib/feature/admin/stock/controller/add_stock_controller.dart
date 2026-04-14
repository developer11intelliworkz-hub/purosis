import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../../profile/model/added_user_model.dart';
import '../model/item_model.dart';
import '../model/query/inward_stock_query.dart';
import '../model/query/outward_stock_query.dart';

class AddStockController extends GetxController {
  ApiService apiService = ApiService();
  bool isDataLoading = false;
  ItemModel? selectedItem;
  AddedUserModel? selectedRecipient;

  TextEditingController itemTEC = TextEditingController();
  TextEditingController quantityTEC = TextEditingController();
  TextEditingController notesTEC = TextEditingController();

  GlobalKey<FormState> validationKey = GlobalKey<FormState>();

  setEditStock(ItemModel item) {
    selectedItem = item;
    itemTEC.text = item.itemName ?? "";
    quantityTEC.text = (item.qty ?? "").toString();
    notesTEC.text = item.notes ?? "";
    update();
  }

  Future<List<ItemModel>> getItemApi() async {
    List<ItemModel> itemModelList = [];
    await apiService
        .get(AppUrl.getStockDetailUrl, queryParameters: {"type": "items"})
        .then((response) {
          if (response["success"] == true) {
            for (final data in response['data']) {
              itemModelList.add(ItemModel.fromJson(data));
            }
          }
          return itemModelList;
        })
        .catchError((value) {
          return itemModelList;
        });
    return itemModelList;
  }

  Future<List<AddedUserModel>> getUserApi() async {
    List<AddedUserModel> addUserModelList = [];
    await apiService
        .get(AppUrl.getUserUrl)
        .then((response) {
          if (response["success"] == true) {
            for (final data in response["data"]) {
              addUserModelList.add(AddedUserModel.fromJson(data));
            }
          }
        })
        .catchError((value) {});
    return addUserModelList;
  }

  Future<void> inwardStockApi() async {
    isDataLoading = true;
    update();
    InwardStockQuery inwardStockQuery = InwardStockQuery(
      itemName: itemTEC.text,
      qty: quantityTEC.text,
      notes: notesTEC.text,
    );
    await apiService
        .postFormData(
          AppUrl.inwardStockUrl,
          await inwardStockQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);

            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> updateStockApi() async {
    isDataLoading = true;
    update();
    InwardStockQuery inwardStockQuery = InwardStockQuery(
      itemId: selectedItem?.id,
      itemName: itemTEC.text,
      qty: quantityTEC.text,
      notes: notesTEC.text,
    );
    await apiService
        .postFormData(
          AppUrl.updateStockUrl,
          await inwardStockQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }

  Future<void> outwardStockApi() async {
    isDataLoading = true;
    update();
    OutwardStockQuery addVideoQuery = OutwardStockQuery(
      itemId: selectedItem?.id,
      qty: quantityTEC.text,
      distributorId: selectedRecipient?.id,
      notes: notesTEC.text,
    );
    await apiService
        .postFormData(AppUrl.outwardStockUrl, await addVideoQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDataLoading = false;
          update();
        })
        .catchError((value) {
          isDataLoading = false;
          update();
        });
  }
}
