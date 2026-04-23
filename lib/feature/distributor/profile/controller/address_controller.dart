import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/profile/model/Address_model.dart';
import 'package:purosis/feature/distributor/profile/model/pincode_model.dart';
import 'package:purosis/feature/distributor/profile/model/query/add_address_query.dart';
import 'package:purosis/feature/distributor/profile/model/query/address_delete_query.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';

import '../../../../consts/app_url.dart';

class AddressController extends GetxController {
  ApiService apiService = ApiService();
  TextEditingController dealerNameTEC = TextEditingController();
  TextEditingController contactPersonNameTEC = TextEditingController();
  TextEditingController gstNumberTEC = TextEditingController();
  TextEditingController billingAddressTEC = TextEditingController();
  TextEditingController mobileNumberTEC = TextEditingController();
  TextEditingController emailAddressTEC = TextEditingController();
  TextEditingController shippingAddressTEC = TextEditingController();
  TextEditingController pinCodeTEC = TextEditingController();
  TextEditingController stateTEC = TextEditingController();
  TextEditingController cityTEC = TextEditingController();

  final List<String> typeList = [
    "Same as Billing Address",
    "Add New Shipping Address",
  ];
  String selectedType = "Same as Billing Address";

  bool isPinCodeLoading = false;
  List<PinCodeModel> pinCodeModel = [];
  bool isAddressAddLoading = false;
  bool isUpdateAddressAddLoading = false;
  RxBool isDeleteLoading = false.obs;
  bool isAddressLoading = false;
  List<AddressModel> addressModelList = [];
  GlobalKey<FormState> validationKey = GlobalKey<FormState>();

  //Pending work
  setEditAddress(AddressModel? addressModel) {
    dealerNameTEC.text = addressModel?.dealerName ?? "";
    contactPersonNameTEC.text = addressModel?.contactPersonName ?? "";
    gstNumberTEC.text = addressModel?.gstNumber ?? "";
    billingAddressTEC.text = addressModel?.address ?? "";
    mobileNumberTEC.text = addressModel?.mobileNo ?? "";
    emailAddressTEC.text = addressModel?.emailAddress ?? "";
    pinCodeTEC.text = addressModel?.pincode ?? "";
    stateTEC.text = addressModel?.state ?? "";
    cityTEC.text = addressModel?.city ?? "";
  }

  Future<void> validatePinCodeApi(String pinCode) async {
    isPinCodeLoading = true;
    update();
    await Dio()
        .get("${AppUrl.getPinCodeDetail}$pinCode")
        .then((response) {
          pinCodeModel.clear();

          if (response.data != null && response.data.isNotEmpty) {
            List postOffices = response.data[0]['PostOffice'] ?? [];

            pinCodeModel = postOffices
                .map((e) => PinCodeModel.fromJson(e))
                .toList();
            if (pinCodeModel.isNotEmpty) {
              stateTEC.text = pinCodeModel.first.state ?? "";
              cityTEC.text = pinCodeModel.first.district ?? "";
            }
          }
          isPinCodeLoading = false;
          update();
        })
        .catchError((value) {
          isPinCodeLoading = false;
          update();
        });
  }

  Future<void> getAddressApi() async {
    isAddressLoading = true;
    update();
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

  Future<void> addAddressApi() async {
    isAddressAddLoading = true;
    update();
    AddAddressQuery addAddressQuery = AddAddressQuery(
      dealerName: dealerNameTEC.text,
      contactPersonName: contactPersonNameTEC.text,
      gstNumber: gstNumberTEC.text,
      pinCode: pinCodeTEC.text,
      state: stateTEC.text,
      city: cityTEC.text,
      address: billingAddressTEC.text,
      mobileNo: mobileNumberTEC.text,
      emailAddress: emailAddressTEC.text,
      shippingAddress: shippingAddressTEC.text,
      isShipping: selectedType == "Same as Billing Address" ? 0 : 1,
    );
    await apiService
        .postFormData(AppUrl.addUpdateAddressUrl, addAddressQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isAddressAddLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isAddressAddLoading = false;
          update();
        });
  }

  Future<void> updateAddressApi(AddressModel? addressModel) async {
    isUpdateAddressAddLoading = true;
    update();
    AddAddressQuery addAddressQuery = AddAddressQuery(
      addressId: addressModel?.id,
      dealerName: dealerNameTEC.text,
      contactPersonName: contactPersonNameTEC.text,
      gstNumber: gstNumberTEC.text,
      pinCode: pinCodeTEC.text,
      state: stateTEC.text,
      city: cityTEC.text,
      address: billingAddressTEC.text,
      mobileNo: mobileNumberTEC.text,
      emailAddress: emailAddressTEC.text,
      shippingAddress: shippingAddressTEC.text,
      isShipping: selectedType == "Same as Billing Address" ? 0 : 1,
    );
    await apiService
        .postFormData(AppUrl.addUpdateAddressUrl, addAddressQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isUpdateAddressAddLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isUpdateAddressAddLoading = false;
          update();
        });
  }

  Future<void> deleteAddressApi(num? addressId) async {
    isDeleteLoading.value = true;
    update();
    AddressDeleteQuery addressDeleteQuery = AddressDeleteQuery(
      addressId: addressId,
    );
    await apiService
        .postFormData(AppUrl.deleteAddressUrl, addressDeleteQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            addressModelList.removeWhere((e) => e.id == addressId);
            Get.back();
            AppToast.success(response['message']);
          } else {
            AppToast.error(message: response['message']);
          }
          isDeleteLoading.value = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isDeleteLoading.value = false;
          update();
        });
  }
}
