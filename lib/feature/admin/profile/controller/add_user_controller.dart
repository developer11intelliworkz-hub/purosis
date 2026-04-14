import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../model/added_user_model.dart';
import '../model/query/add_user_query.dart';

class AddUserController extends GetxController {
  ApiService apiService = ApiService();

  TextEditingController companyNameTEC = TextEditingController();
  TextEditingController contactPersonNameTEC = TextEditingController();
  TextEditingController gstNumberTEC = TextEditingController();
  TextEditingController areaTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController phoneNoTEC = TextEditingController();
  TextEditingController alternatePhoneNoTEC = TextEditingController();
  TextEditingController landlinePhoneNoTEC = TextEditingController();
  TextEditingController whatsappNoTEC = TextEditingController();
  TextEditingController billingAddressTEC = TextEditingController();
  TextEditingController pinCodeTEC = TextEditingController();
  TextEditingController shippingAddressTEC = TextEditingController();
  TextEditingController shippingPINCodeTEC = TextEditingController();

  GlobalKey<FormState> validationKey = GlobalKey<FormState>();

  final List<String> typeList = [
    "Same as Billing Address",
    "Add New Shipping Address",
  ];

  String selectedType = "Same as Billing Address";
  File? selectedFile;
  bool isLoading = false;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
      allowMultiple: false,
    );
    if (result != null) {
      selectedFile = File(result.files.first.path ?? "");
      update();
    }
  }

  setEditValue(AddedUserModel userModel) {
    companyNameTEC.text = userModel.companyName ?? "";
    contactPersonNameTEC.text = userModel.name ?? "";
    gstNumberTEC.text = userModel.gstNumber ?? "";
    areaTEC.text = userModel.area ?? "";
    phoneNoTEC.text = userModel.phoneNo ?? "";
    alternatePhoneNoTEC.text = userModel.alternateMobileNo ?? "";
    landlinePhoneNoTEC.text = userModel.landlineNo ?? "";
    emailTEC.text = userModel.email ?? "";
  }

  Future<void> addUserApi() async {
    isLoading = true;
    update();

    AddUserQuery addUserQuery = AddUserQuery(
      companyName: companyNameTEC.text,
      name: contactPersonNameTEC.text,
      gstNumber: gstNumberTEC.text,
      area: areaTEC.text,
      phoneNo: phoneNoTEC.text,
      alternateMobileNo: alternatePhoneNoTEC.text,
      landlineNo: landlinePhoneNoTEC.text,
      email: emailTEC.text,
      // billingAddress: billingAddressTEC.text,
      // shippingAddressLine: selectedType == "Same as Billing Address"
      //     ? billingAddressTEC.text
      //     : shippingAddressTEC.text,
      // shippingAddressPincode: selectedType == "Same as Billing Address"
      //     ? pinCodeTEC.text
      //     : shippingPINCodeTEC.text,
    );

    await apiService
        .postFormData(AppUrl.addUpdateUserUrl, await addUserQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isLoading = false;
          update();
        })
        .catchError((value) {
          isLoading = false;
          update();
        });
  }

  Future<void> editUserApi({required AddedUserModel userModel}) async {
    isLoading = true;
    update();

    AddUserQuery addUserQuery = AddUserQuery(
      distributorId: userModel.id,
      companyName: companyNameTEC.text,
      name: contactPersonNameTEC.text,
      gstNumber: gstNumberTEC.text,
      area: areaTEC.text,
      phoneNo: phoneNoTEC.text,
      alternateMobileNo: alternatePhoneNoTEC.text,
      landlineNo: landlinePhoneNoTEC.text,
      email: emailTEC.text,
      // billingAddress: billingAddressTEC.text,
      // shippingAddressLine: selectedType == "Same as Billing Address"
      //     ? billingAddressTEC.text
      //     : shippingAddressTEC.text,
      // shippingAddressPincode: selectedType == "Same as Billing Address"
      //     ? pinCodeTEC.text
      //     : shippingPINCodeTEC.text,
    );

    await apiService
        .postFormData(AppUrl.addUpdateUserUrl, await addUserQuery.toFormData())
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isLoading = false;
          update();
        })
        .catchError((value) {
          isLoading = false;
          update();
        });
  }
}
