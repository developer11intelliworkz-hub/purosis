import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/utils/api_service.dart';
import 'package:purosis/widget/common_widget.dart';

import '../consts/app_url.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});
  // final Map<String,dynamic> ?selectedValue;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final List<String> leftMenu = ["Product Categories", "Sub Categories"];

  List<num> selectedProductCategories = [];
  List<num> selectedProductSubCategories = [];
  int selectedLeftIndex = 0;

  final Map<String, dynamic>? passArguments = Get.arguments;
  Map<String, dynamic>? selectedValue = {};

  @override
  void initState() {
    //create a copy of passed map
    //because we need to modify the map
    //-----------------------------
    selectedValue = {
      "categories": List<num>.from(passArguments?["categories"] ?? []),
      "sub_categories": List<num>.from(passArguments?["sub_categories"] ?? []),
    };
    //---------------------------
    selectedProductCategories = selectedValue?["categories"] ?? <num>[];
    selectedProductSubCategories = selectedValue?["sub_categories"] ?? <num>[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Filters",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedProductCategories.clear();
                        selectedProductSubCategories.clear();
                      });
                    },
                    child: const Text(
                      "Clear All",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 140,
                    color: Colors.grey.shade100,
                    child: ListView.builder(
                      itemCount: leftMenu.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedLeftIndex == index;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedLeftIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 12,
                            ),
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade100,
                            child: Text(
                              leftMenu[index],
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const VerticalDivider(width: 1),
                  Expanded(child: rightView()),
                ],
              ),
            ),

            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 55,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                  Container(width: 1, height: 30, color: Colors.grey.shade300),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Map<String, dynamic> filterData = {};
                        if (selectedProductCategories.isNotEmpty ||
                            selectedProductSubCategories.isNotEmpty) {
                          filterData["categories"] = selectedProductCategories;
                          filterData["sub_categories"] =
                              selectedProductSubCategories;
                        }
                        Navigator.pop(context, filterData);
                      },
                      child: const Text(
                        "Apply",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rightView() {
    if (selectedLeftIndex == 0) {
      return FutureBuilder(
        future: productCategoriesApi(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.data == null) {
            return Center(child: CommonWidget.commonLoading());
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: asyncSnapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              num? item = asyncSnapshot.data?[index].id;
              bool isSelected = selectedProductCategories.contains(item);

              return CheckboxListTile(
                value: isSelected,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedProductCategories.add(item!);
                    } else {
                      selectedProductCategories.remove(item);
                    }
                  });
                },
                title: Text(asyncSnapshot.data?[index].categoryName ?? ""),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              );
            },
          );
        },
      );
    } else if (selectedLeftIndex == 1) {
      return FutureBuilder(
        future: productSubCategoriesApi(selectedProductCategories),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.data == null) {
            return Center(child: CommonWidget.commonLoading());
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: asyncSnapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              num? item = asyncSnapshot.data?[index].id;
              bool isSelected = selectedProductSubCategories.contains(item);

              return CheckboxListTile(
                value: isSelected,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedProductSubCategories.add(item!);
                    } else {
                      selectedProductSubCategories.remove(item);
                    }
                  });
                },
                title: Text(asyncSnapshot.data?[index].subCategoryName ?? ""),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              );
            },
          );
        },
      );
    } else {
      return Container();
    }
  }
}

class ProductCategories {
  ProductCategories({this.id, this.categoryName});

  ProductCategories.fromJson(dynamic json) {
    id = json['id'];
    categoryName = json['category_name'];
  }

  num? id;
  String? categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_name'] = categoryName;
    return map;
  }
}

class SubCategoryModel {
  SubCategoryModel({
    this.id,
    this.categoryId,
    this.subCategoryName,
    this.subCategoryUrl,
    this.shortDescription,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  SubCategoryModel.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    subCategoryName = json['sub_category_name'];
    subCategoryUrl = json['sub_category_url'];
    shortDescription = json['short_description'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  num? categoryId;
  String? subCategoryName;
  String? subCategoryUrl;
  String? shortDescription;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['category_id'] = categoryId;
    map['sub_category_name'] = subCategoryName;
    map['sub_category_url'] = subCategoryUrl;
    map['short_description'] = shortDescription;
    map['deleted_at'] = deletedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

Future<List<ProductCategories>> productCategoriesApi() async {
  List<ProductCategories> productCategoriesList = [];
  await ApiService()
      .get(AppUrl.productCategoriesUrl)
      .then((response) {
        if (response["success"] == true) {
          for (final data in response['data']) {
            productCategoriesList.add(ProductCategories.fromJson(data));
          }
        }
      })
      .catchError((value) {});
  return productCategoriesList;
}

Future<List<SubCategoryModel>> productSubCategoriesApi(List<num> id) async {
  List<SubCategoryModel> productSubCategoriesList = [];
  await ApiService()
      .get(
        AppUrl.productsSubCategoriesUrl,
        queryParameters: {"category_ids": id.join(",")},
      )
      .then((response) {
        if (response["success"] == true) {
          for (final data in response['data']) {
            productSubCategoriesList.add(SubCategoryModel.fromJson(data));
          }
        }
      })
      .catchError((value) {});
  return productSubCategoriesList;
}
