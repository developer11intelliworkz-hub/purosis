import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/cart/model/cart_model.dart';
import 'package:purosis/feature/distributor/cart/model/query/place_order_query.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../../../../utils/common_permission.dart';
import '../model/address_model.dart';
import '../model/query/delete_cart_query.dart';
import '../model/query/update_cart_query.dart';

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
  bool isUpdateCartLoading = false;
  bool isDeleteCartLoading = false;
  num? selectedDealerInfo;
  num? selectedTransport;
  final List<String> typeList = ["Full Container", "Part Loader"];
  String selectedType = "Full Container";
  int? updateCartIndex;
  int? deleteCartIndex;
  Position? position;

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
    selectedAddressModelList.clear();
    selectedAddressModelList.add(
      addressModelList.firstWhere((e) => e.id == selectedDealerInfo),
    );
    selectedAddressModelList.add(
      addressModelList.firstWhere((e) => e.id == selectedTransport),
    );
  }

  Future<void> addOrderApi() async {
    isPlaceOrderLoading = true;
    update();
    final permissionCheck = await CommonPermission.checkLocationPermission();
    if (permissionCheck == true) {
      position = await CommonPermission.getCurrentLocation();
    }
    if (position != null) {
      PlaceOrderQuery placeOrderQuery = PlaceOrderQuery(
        billingAddressId: selectedDealerInfo?.toInt(),
        shippingAddressId: selectedTransport?.toInt(),
        type: selectedType,
        remarks: remarksTEC.text,
        cartIds: cartModelList.map((e) => e.id!.toInt()).toList(),
        latitude: position?.latitude,
        longitude: position?.longitude,
      );
      await apiService
          .postFormData(
            AppUrl.placeOrderUrl,
            await placeOrderQuery.toFormData(),
          )
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
    } else {
      isPlaceOrderLoading = true;
      update();
      AppToast.error(message: "Location is need for Place Order");
    }
  }

  Future<void> updateCartApi(CartModel cart, int index) async {
    isUpdateCartLoading = true;
    updateCartIndex = index;
    update();
    UpdateCartQuery updateCartQuery = UpdateCartQuery(
      productId: cart.productId?.toInt(),
      colorCode: cart.colorCode,
      qty: cart.qty?.toInt(),
    );
    await apiService
        .postFormData(AppUrl.addToCartUrl, updateCartQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
          } else {
            AppToast.error();
          }
          isUpdateCartLoading = false;
          update();
        })
        .catchError((value) {
          isUpdateCartLoading = false;
          update();
        });
  }

  Future<void> deleteCartApi(int? id, int index) async {
    isDeleteCartLoading = true;
    deleteCartIndex = index;
    update();
    DeleteCartQuery deleteCartQuery = DeleteCartQuery(cartId: id);
    await apiService
        .postFormData(AppUrl.deleteCartUrl, deleteCartQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            cartModelList.removeWhere((e) => e.id == id);
            AppToast.success(response["message"]);
          } else {
            AppToast.error();
          }
          isDeleteCartLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isDeleteCartLoading = false;
          update();
        });
  }
}
