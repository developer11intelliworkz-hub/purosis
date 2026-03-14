import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../model/query/inward_stock_query.dart';
import '../model/query/outward_stock_query.dart';

class AddStockController extends GetxController {
  ApiService apiService = ApiService();
  bool isDataLoading = false;
  String? selectedItem;
  String? selectedRecipient;

  TextEditingController itemTEC = TextEditingController();
  TextEditingController quantityTEC = TextEditingController();
  TextEditingController notesTEC = TextEditingController();

  GlobalKey<FormState> validationKey = GlobalKey<FormState>();

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

  Future<void> outwardStockApi() async {
    isDataLoading = true;
    update();
    OutwardStockQuery addVideoQuery = OutwardStockQuery(
      itemId: "1",
      qty: quantityTEC.text,
      distributorId: "1",
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
