import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/app_toast.dart';
import '../model/query/add_user_query.dart';

class AddUserController extends GetxController {
  ApiService apiService = ApiService();

  TextEditingController companyNameTEC = TextEditingController();
  TextEditingController gstNumberTEC = TextEditingController();
  TextEditingController areaTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController phoneNoTEC = TextEditingController();
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

  bool isLoading = false;

  Future<void> addUserApi() async {
    isLoading = true;
    update();

    AddUserQuery addUserQuery = AddUserQuery(
      name: companyNameTEC.text,
      gstNumber: gstNumberTEC.text,
      area: areaTEC.text,
      email: emailTEC.text,
      phoneNo: phoneNoTEC.text,
      whatsappNo: whatsappNoTEC.text,
      billingAddress: billingAddressTEC.text,
      shippingAddressLine: selectedType == "Same as Billing Address"
          ? billingAddressTEC.text
          : shippingAddressTEC.text,
      shippingAddressPincode: selectedType == "Same as Billing Address"
          ? pinCodeTEC.text
          : shippingPINCodeTEC.text,
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
