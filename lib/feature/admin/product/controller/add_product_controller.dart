import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/product/model/image_item.dart';
import 'package:purosis/feature/admin/product/model/image_model.dart';
import 'package:purosis/feature/admin/product/model/product_detail_model.dart';
import 'package:purosis/feature/admin/product/model/product_model.dart'
    hide ProductColorImage;
import 'package:purosis/feature/admin/product/model/query/add_update_image_query.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/utils/app_toast.dart';

import '../../../../consts/app_url.dart';
import '../../../../utils/commmon_function.dart';
import '../model/product_categories.dart';
import '../model/query/add_product_query.dart';
import '../model/query/delete_product_color_query.dart';
import '../model/query/sub_category_query.dart';
import '../model/sub_category_model.dart';

class AddProductController extends GetxController {
  final ApiService apiService = ApiService();
  bool productCategoriesLoading = false;
  bool isAddProductLoading = false;
  bool isAddImageLoading = false;
  RxBool isDeleteLoading = false.obs;
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
  List<String> listOfSpecification = [];

  List<ProductColorImage> imageEditList = [];
  List<ImageItem> imageItemList = [];
  ProductDetailModel? selectedProductDetailModel;

  TextEditingController colorNameTEC = TextEditingController();
  TextEditingController productNameTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  TextEditingController unitPerBoxTEC = TextEditingController();
  TextEditingController weightPerBoxTEC = TextEditingController();
  TextEditingController lengthTEC = TextEditingController();
  TextEditingController widthTEC = TextEditingController();
  TextEditingController heightTEC = TextEditingController();
  TextEditingController technicalVideoUrlTEC = TextEditingController();

  setEditValue(ProductDetailModel? productDetail) {
    selectedProductDetailModel = productDetail;
    productNameTEC.text = productDetail?.productName ?? "";
    selectedProductCategories = productDetail?.category;
    selectedSubCategoryModel = productDetail?.subCategory;
    descriptionTEC.text = productDetail?.productDescription ?? "";
    unitPerBoxTEC.text = (productDetail?.unitsPerBox ?? "").toString();
    weightPerBoxTEC.text = productDetail?.weightPerBox ?? "";
    lengthTEC.text = productDetail?.length ?? "";
    widthTEC.text = productDetail?.width ?? "";
    heightTEC.text = productDetail?.height ?? "";
    technicalVideoUrlTEC.text = productDetail?.technicalVideoUrl ?? "";
    listOfSpecification = productDetail?.specifications ?? [];
    imageEditList = productDetail?.productColorsImages ?? [];
    update();
  }

  setImageEdit(ProductColorImage? productColorImage) {
    imageItemList =
        productColorImage?.images?.map((e) => ImageItem(url: e)).toList() ?? [];
    selectedColor = CommonFunction.hexToColor(
      productColorImage?.colorCode ?? '',
    );
    colorNameTEC.text = productColorImage?.colorName ?? "";
    // update();
  }

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

  void addImagesEdit() async {
    final images = await CommonFunction.pickMultipleImages(
      alreadySelected: selectedImages.length,
      maxLimit: 6,
    );
    final imageList = images.map((e) => ImageItem(file: e));
    imageItemList.addAll(imageList);
    update();
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
    update();
  }

  void removeImageEdit(int index) {
    imageItemList.removeAt(index);
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
      specifications: listOfSpecification,
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
          } else {
            AppToast.error(message: response["message"]);
          }
          isAddProductLoading = false;
          update();
        })
        .catchError((value) {
          isAddProductLoading = false;
          update();
        });
  }

  Future<void> updateProductApi() async {
    isAddProductLoading = true;
    update();
    AddProductQuery addProductQuery = AddProductQuery(
      productId: selectedProductDetailModel?.id,
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
      specifications: listOfSpecification,
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
          } else {
            AppToast.error(message: response["message"]);
          }
          isAddProductLoading = false;
          update();
        })
        .catchError((value) {
          isAddProductLoading = false;
          update();
        });
  }

  Future<void> addImageApi() async {
    isAddImageLoading = true;
    update();
    AddUpdateImageQuery addUpdateImageQuery = AddUpdateImageQuery(
      productId: selectedProductDetailModel?.id,
      colorCode: CommonFunction.colorToHex(selectedColor),
      colorImages: selectedImages,
      colorName: colorNameTEC.text,
    );
    await apiService
        .postFormData(
          AppUrl.updateProductColorImageUrl,
          await addUpdateImageQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            ProductColorImage productColorImage = ProductColorImage.fromJson(
              response["data"],
            );
            selectedProductDetailModel?.productColorsImages?.add(
              productColorImage,
            );
            Get.back(result: selectedProductDetailModel);
            AppToast.success(response["message"]);
          } else {
            AppToast.error(message: response["message"]);
          }
          isAddImageLoading = false;
          update();
        })
        .catchError((value) {
          isAddImageLoading = false;
          update();
        });
  }

  Future<void> updateImageApi(ProductColorImage? productColorImage) async {
    isAddImageLoading = true;
    update();
    AddUpdateImageQuery addUpdateImageQuery = AddUpdateImageQuery(
      productId: selectedProductDetailModel?.id,
      existingImgNames: imageItemList
          .map((e) => e.url?.split("/").last)
          .whereType<String>()
          .toList(),
      colorId: productColorImage?.colorId,
      colorCode: CommonFunction.colorToHex(selectedColor),
      colorImages: imageItemList
          .map((e) => e.file)
          .whereType<PlatformFile>()
          .toList(),
      colorName: colorNameTEC.text,
    );
    await apiService
        .postFormData(
          AppUrl.updateProductColorImageUrl,
          await addUpdateImageQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            ProductColorImage productColorImage = ProductColorImage.fromJson(
              response["data"],
            );
            selectedProductDetailModel
                    ?.productColorsImages?[selectedProductDetailModel
                        ?.productColorsImages
                        ?.indexWhere(
                          (e) => e.colorId == productColorImage.colorId,
                        ) ??
                    -1] =
                productColorImage;
            Get.back(result: selectedProductDetailModel);
            AppToast.success(response["message"]);
          } else {
            AppToast.error(message: response["message"]);
          }
          isAddImageLoading = false;
          update();
        })
        .catchError((value) {
          isAddImageLoading = false;
          update();
        });
  }

  Future<void> deleteImageApi(int? colorId) async {
    isDeleteLoading.value = true;
    update();
    DeleteProductColorQuery deleteProductColorQuery = DeleteProductColorQuery(
      colorId: colorId,
    );
    await apiService
        .postFormData(
          AppUrl.deleteProductColorUrl,
          await deleteProductColorQuery.toFormData(),
        )
        .then((response) {
          if (response["success"] == true) {
            imageEditList.removeWhere((e) => e.colorId == colorId);
            Get.back();
            // AppToast.success(response["message"]);
          } else {
            AppToast.error(message: response["message"]);
          }
          isDeleteLoading.value = false;
          update();
        })
        .catchError((value) {
          isDeleteLoading.value = false;
          update();
        });
  }
}
