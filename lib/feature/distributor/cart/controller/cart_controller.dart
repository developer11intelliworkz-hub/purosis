import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/cart/model/cart_model.dart';
import 'package:purosis/feature/distributor/cart/model/query/place_order_query.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../model/address_model.dart';

class CartController extends GetxController {
  final ApiService apiService = ApiService();

  List<CartModel> cartModelList = [];
  List<AddressModel> addressModelList = [];
  List<AddressModel> selectedAddressModelList = [];
  GlobalKey<FormState> validationKey = GlobalKey<FormState>();
  TextEditingController remarksTEC = TextEditingController();

  bool isCartLoading = false;
  bool isAddressLoading = false;
  bool isPlaceOrderLoading = false;
  num? selectedDealerInfo;
  num? selectedTransport;
  final List<String> typeList = ["Full Container", "Part Loader"];
  String selectedType = "Full Container";

  Future<void> getCartApi() async {
    isCartLoading = true;
    update();
    await apiService
        .get(AppUrl.getCartUrl)
        .then((response) {
          cartModelList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              cartModelList.add(CartModel.fromJson(data));
            }
          }
          isCartLoading = false;
          update();
        })
        .catchError((value) {
          isCartLoading = false;
          update();
        });
  }

  Future<void> getAddressApi() async {
    isAddressLoading = true;
    // update();
    await apiService
        .get(AppUrl.getAddressUrl)
        .then((response) {
          addressModelList.clear();
          if (response["success"] == true) {
            for (final data in response['data']) {
              addressModelList.add(AddressModel.fromJson(data));
            }
          }
          isAddressLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isAddressLoading = false;
          update();
        });
  }

  getSelectedAddress() {
    selectedAddressModelList = addressModelList
        .where((e) => e.id == selectedDealerInfo || e.id == selectedTransport)
        .toList();
  }

  Future<void> addOrderApi() async {
    isPlaceOrderLoading = true;
    update();
    PlaceOrderQuery placeOrderQuery = PlaceOrderQuery(
      billingAddressId: selectedDealerInfo?.toInt(),
      shippingAddressId: selectedTransport?.toInt(),
      type: selectedType,
      remarks: remarksTEC.text,
      cartIds: cartModelList.map((e) => e.id!.toInt()).toList(),
    );
    await apiService
        .postFormData(AppUrl.placeOrderUrl, await placeOrderQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.offAllNamed(AppRoutes.distributorDashboard);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isPlaceOrderLoading = false;
          update();
        })
        .catchError((value) {
          isPlaceOrderLoading = false;
          update();
        });
  }
}
