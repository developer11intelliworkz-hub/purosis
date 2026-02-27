import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/model/query/add_brochure_query.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';

import '../../../../consts/app_url.dart';
import '../model/brochures_model.dart';

class AddContentController extends GetxController {
  bool isAddBrochuresLoading = false;
  ApiService apiService = ApiService();
  TextEditingController titleTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  String? selectedYear;
  String? selectedMonth;
  PlatformFile? selectedFile;
  BrochuresModel? selectedBrochure;
  GlobalKey<FormState> validationKey = GlobalKey();

  List<String> yearList = List.generate(
    2040 - 2015 + 1,
    (index) => (2015 + index).toString(),
  );
  List<String> monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  setEditBrochureValue(BrochuresModel value) {
    titleTEC.text = value.title ?? "";
    selectedMonth = value.month;
    selectedYear = value.year;
    descriptionTEC.text = value.description ?? "";
  }

  Future<void> addBrochureApi() async {
    isAddBrochuresLoading = true;
    update();
    AddBrochureQuery addBrochureQuery = AddBrochureQuery(
      title: titleTEC.text,
      category: "brochure1",
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedFile,
    );
    await apiService
        .postFormData(
          AppUrl.addUpdateBrochureUrl,
          await addBrochureQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back();
            AppToast.success(response['message']);
          }
          isAddBrochuresLoading = false;
          update();
        })
        .catchError((value) {
          isAddBrochuresLoading = false;
          update();
        });
  }

  Future<void> updateBrochureApi() async {
    isAddBrochuresLoading = true;
    update();
    AddBrochureQuery addBrochureQuery = AddBrochureQuery(
      id: selectedBrochure?.id,
      title: titleTEC.text,
      category: "brochure1",
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedFile,
    );
    await apiService
        .postFormData(
          AppUrl.addUpdateBrochureUrl,
          await addBrochureQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back();
            AppToast.success(response['message']);
          }
          isAddBrochuresLoading = false;
          update();
        })
        .catchError((value) {
          isAddBrochuresLoading = false;
          update();
        });
  }

  Future<void> addPostApi() async {
    isAddBrochuresLoading = true;
    update();
    AddBrochureQuery addBrochureQuery = AddBrochureQuery(
      id: selectedBrochure?.id,
      title: titleTEC.text,
      category: "brochure1",
      month: selectedMonth,
      year: selectedYear,
      description: descriptionTEC.text,
      isFeatured: 1,
      mediaFile: selectedFile,
    );
    await apiService
        .postFormData(
          AppUrl.addUpdateBrochureUrl,
          await addBrochureQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back();
            AppToast.success(response['message']);
          }
          isAddBrochuresLoading = false;
          update();
        })
        .catchError((value) {
          isAddBrochuresLoading = false;
          update();
        });
  }
}
