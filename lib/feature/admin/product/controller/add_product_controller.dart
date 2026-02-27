import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/product/model/image_model.dart';
import 'package:purosis/feature/admin/product/model/product_model.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/commmon_function.dart';
import '../model/product_categories.dart';
import '../model/query/add_product_query.dart';
import '../model/query/sub_category_query.dart';
import '../model/sub_category_model.dart';

class AddProductController extends GetxController {
  final ApiService apiService = ApiService();
  bool productCategoriesLoading = false;
  bool isAddProductLoading = false;
  ProductCategories? selectedProductCategories;
  SubCategoryModel? selectedSubCategoryModel;
  Map<String, dynamic> selectedFilter = {};
  List<ProductModel> productModelList = [];
  bool isProductLoading = false;
  List<ImageModel> imageModelList = [];
  List<PlatformFile> selectedImages = [];
  Color selectedColor = Color(0xFF000000);
  GlobalKey<FormState> imageValidationKey = GlobalKey();
  GlobalKey<FormState> allFieldValidationKey = GlobalKey();

  TextEditingController colorNameTEC = TextEditingController();
  TextEditingController productNameTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  TextEditingController unitPerBoxTEC = TextEditingController();
  TextEditingController weightPerBoxTEC = TextEditingController();
  TextEditingController lengthTEC = TextEditingController();
  TextEditingController widthTEC = TextEditingController();
  TextEditingController heightTEC = TextEditingController();
  TextEditingController technicalVideoUrlTEC = TextEditingController();

  addImageToList() {
    imageModelList.add(
      ImageModel(
        colorCode: CommonFunction.colorToHex(selectedColor),
        colorName: colorNameTEC.text,
        filePath: selectedImages.map((e) => File(e.path ?? "")).toList(),
      ),
    );
    resetImageDetail();
  }

  resetImageDetail() {
    selectedColor = Color(0xFF000000);
    colorNameTEC.clear();
    selectedImages.clear();
    update();
  }

  void addImages() async {
    final images = await CommonFunction.pickMultipleImages(
      alreadySelected: selectedImages.length,
      maxLimit: 6,
    );
    selectedImages.addAll(images);
    update();
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
    update();
  }

  Future<List<ProductCategories>> productCategoriesApi() async {
    productCategoriesLoading = true;
    update();
    List<ProductCategories> productCategoriesList = [];
    await apiService
        .get(AppUrl.productCategoriesUrl)
        .then((response) {
          if (response["success"] == true) {
            for (final data in response['data']) {
              productCategoriesList.add(ProductCategories.fromJson(data));
            }

            productCategoriesLoading = false;
            update();
          }
        })
        .catchError((value) {
          productCategoriesLoading = false;
          update();
        });
    return productCategoriesList;
  }

  Future<List<SubCategoryModel>> productSubCategoriesApi() async {
    productCategoriesLoading = true;
    update();
    List<SubCategoryModel> productSubCategoriesList = [];
    await apiService
        .get(
          AppUrl.productSubCategoriesUrl,
          queryParameters: SubCategoryQuery(
            categoryId: selectedProductCategories?.id,
          ).toJson(),
        )
        .then((response) {
          if (response["success"] == true) {
            for (final data in response['data']) {
              productSubCategoriesList.add(SubCategoryModel.fromJson(data));
            }

            productCategoriesLoading = false;
            update();
          }
        })
        .catchError((value) {
          productCategoriesLoading = false;
          update();
        });
    return productSubCategoriesList;
  }

  Future<void> addProductApi() async {
    isAddProductLoading = true;
    update();
    AddProductQuery addProductQuery = AddProductQuery(
      productName: productNameTEC.text,
      categoryId: selectedProductCategories?.id,
      subCategoryId: selectedSubCategoryModel?.id,
      description: descriptionTEC.text,
      unitsPerBox: unitPerBoxTEC.text,
      weightPerBox: weightPerBoxTEC.text,
      length: lengthTEC.text,
      width: widthTEC.text,
      height: heightTEC.text,
      technicalVideoUrl: technicalVideoUrlTEC.text,
      imageModelList: imageModelList,
    );
    await apiService
        .postFormData(
          AppUrl.addUpdateProductUrl,
          await addProductQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            Get.back(result: true);
            AppToast.success(response["message"]);
          }
          isAddProductLoading = false;
          update();
        })
        .catchError((value) {
          isAddProductLoading = false;
          update();
        });
  }
}
