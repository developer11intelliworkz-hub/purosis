import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:purosis/feature/distributor/profile/model/order_history_model.dart';
import 'package:purosis/feature/distributor/profile/model/query/support_message_query.dart';
import 'package:purosis/feature/distributor/profile/model/query/update_profile_query.dart';
import 'package:purosis/model/detail_model.dart';
import 'package:purosis/utils/api_service.dart';

import '../../../../consts/app_url.dart';
import '../../../../consts/storage_keys.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_toast.dart';
import '../../../../utils/storage_service.dart';
import '../../../admin/profile/model/support_model.dart';
import '../../../auth/model/user_model.dart';
import '../model/order_detail_model.dart';

class ProfileController extends GetxController {
  final storage = Get.find<StorageService>();
  final ApiService apiService = ApiService();
  File? selectedFile;
  TextEditingController companyNameTEC = TextEditingController();
  TextEditingController contactPersonNameTEC = TextEditingController();
  TextEditingController gstNumberTEC = TextEditingController();
  TextEditingController areaTEC = TextEditingController();
  TextEditingController mobileNumberTEC = TextEditingController();
  TextEditingController alternateMobileNumberTEC = TextEditingController();
  TextEditingController landlineNumberTEC = TextEditingController();
  TextEditingController emailAddressTEC = TextEditingController();

  TextEditingController subjectTEC = TextEditingController();
  TextEditingController messageTEC = TextEditingController();

  bool isSaveProfileLoading = false;
  bool isOrderHistoryLoading = false;
  bool isOrderHistoryDetailLoading = false;
  bool isLatest = true;
  bool isSupportLoading = false;
  bool isSendSupportMessageLoading = false;
  GlobalKey<FormState> supportValidationKey = GlobalKey();

  OrderHistoryModel? orderHistoryModel;
  OrderHistoryModel? orderHistoryModelFilter;
  OrderDetailModel? orderDetailModel;
  UserModel? userData;
  SupportModel? supportModel;
  ProductsModel? selectedCategory;

  GlobalKey<FormState> myProfileValidationKey = GlobalKey<FormState>();

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

  sortOrder() {
    isLatest = !isLatest;
    orderHistoryModelFilter?.orders =
        orderHistoryModelFilter?.orders?.reversed.toList() ?? [];
    update();
  }

  void search(String query) {
    if (query.isNotEmpty && query.length >= 4) {
      final item = orderHistoryModel?.orders
          ?.where(
            (item) =>
                item.orderNumber?.toLowerCase().contains(query.toLowerCase()) ??
                false,
          )
          .toList();
      if (isLatest) {
        orderHistoryModelFilter?.orders = item;
      } else {
        orderHistoryModelFilter?.orders = item?.reversed.toList();
      }
      update();
    }
    if (query.isEmpty) {
      orderHistoryModelFilter?.orders?.clear();
      orderHistoryModelFilter?.orders?.addAll(orderHistoryModel?.orders ?? []);
      update();
    }
  }

  getProfileData() {
    UserModel userData = UserModel.fromJson(storage.read(StorageKeys.userData));
    companyNameTEC.text = userData.companyName ?? "";
    contactPersonNameTEC.text = userData.name ?? "";
    gstNumberTEC.text = userData.gstNumber ?? "";
    areaTEC.text = userData.area ?? "";
    mobileNumberTEC.text = userData.phoneNo ?? "";
    alternateMobileNumberTEC.text = userData.alternateMobileNo ?? "";
    landlineNumberTEC.text = userData.landlineNo ?? "";
    emailAddressTEC.text = userData.email ?? "";
  }

  setUserProfile() {
    userData = UserModel.fromJson(storage.read(StorageKeys.userData));
  }

  clearData() {
    selectedFile = null;
  }

  Future<void> updateProfileApi() async {
    isSaveProfileLoading = true;
    update();
    UpdateProfileQuery updateProfileQuery = UpdateProfileQuery(
      companyName: companyNameTEC.text,
      contactPersonName: contactPersonNameTEC.text,
      gstNumber: gstNumberTEC.text,
      area: areaTEC.text,
      mobileNo: mobileNumberTEC.text,
      alternateMobileNo: alternateMobileNumberTEC.text,
      landlineNo: landlineNumberTEC.text,
      email: emailAddressTEC.text,
      logo: selectedFile,
    );

    await apiService
        .postFormData(
          AppUrl.updateProfileDistributorUrl,
          updateProfileQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            final oldData = storage.read(StorageKeys.userData) ?? {};
            final Map<String, dynamic> mergedData = {
              ...oldData,
              ...response["data"],
            };
            final UserModel userModel = UserModel.fromJson(mergedData);
            storage.write(StorageKeys.userData, userModel.toJson());
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isSaveProfileLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isSaveProfileLoading = false;
          update();
        });
  }

  Future<void> getOrderHistoryApi() async {
    isOrderHistoryLoading = true;
    await apiService
        .get(AppUrl.getOrderHistoryUrl)
        .then((response) {
          if (response["success"] == true) {
            orderHistoryModel = OrderHistoryModel.fromJson(response['data']);
            orderHistoryModelFilter = OrderHistoryModel.fromJson(
              response['data'],
            );
          }
          isOrderHistoryLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isOrderHistoryLoading = false;
          update();
        });
  }

  Future<void> getOrderHistoryDetailApi(int? orderId) async {
    isOrderHistoryDetailLoading = true;
    await apiService
        .get(
          AppUrl.getOrderHistoryDetailUrl,
          queryParameters: {"order_id": orderId},
        )
        .then((response) {
          if (response["success"] == true) {
            orderDetailModel = OrderDetailModel.fromJson(response['data']);
          }
          isOrderHistoryDetailLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isOrderHistoryDetailLoading = false;
          update();
        });
  }

  String formatDateTime(String utcDate) {
    DateTime parsedDate = DateTime.parse(utcDate);
    return DateFormat('MMM dd, yyyy - hh:mm a').format(parsedDate);
  }

  logout() async {
    await storage.remove(StorageKeys.userData);
    await storage.clearAuth();
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> getSupportDetailApi() async {
    isSupportLoading = true;
    // update();
    await apiService
        .get(AppUrl.getSupportDetailsUrl)
        .then((response) {
          if (response["success"] == true) {
            supportModel = SupportModel.fromJson(response["data"]);
            isSupportLoading = false;
            update();
          }
        })
        .catchError((value) {
          isSupportLoading = false;
          update();
        });
  }

  resetData() {
    subjectTEC.clear();
    messageTEC.clear();
    selectedCategory = null;
  }

  Future<void> sendSupportMessageApi() async {
    isSendSupportMessageLoading = true;
    update();

    SupportMessageQuery supportMessageQuery = SupportMessageQuery(
      message: messageTEC.text,
      productId: selectedCategory?.id,
      subject: subjectTEC.text,
    );

    await apiService
        .postFormData(
          AppUrl.sendSupportMessageUrl,
          supportMessageQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response['message']);
          } else {
            AppToast.error();
          }
          isSendSupportMessageLoading = false;
          update();
        })
        .catchError((value) {
          AppToast.error();
          isSendSupportMessageLoading = false;
          update();
        });
  }
}
