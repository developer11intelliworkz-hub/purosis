import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/stock/controller/stock_controller.dart';
import 'package:purosis/routes/app_routes.dart';

import '../../../../../widget/app_text.dart';
import '../../../../../widget/common_widget.dart';

class ItemsList extends StatefulWidget {
  const ItemsList({super.key});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final StockController stockController = Get.find();

  @override
  void initState() {
    stockController.getItemApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockController>(
      init: stockController,
      builder: (controller) {
        return controller.isItemLoading
            ? CommonWidget.commonLoading()
            : controller.itemModelList.isEmpty
            ? CommonWidget.commonEmpty()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Promotional Items",
                    color: Color(0xFF0067B1),
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(flex: 2, child: AppText(text: "Serial No.")),
                      Expanded(flex: 2, child: AppText(text: "Name")),
                      Expanded(flex: 2, child: AppText(text: "Description")),
                      Expanded(flex: 1, child: AppText(text: "Stock")),
                      AppText(text: "Actions"),
                    ],
                  ),
                  Divider(color: Color(0xFF8EBF1F)),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: AppText(
                                text:
                                    controller.itemModelList[index].serialNo ??
                                    "",
                              ),
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              flex: 2,
                              child: AppText(
                                text:
                                    controller.itemModelList[index].itemName ??
                                    "",
                              ),
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              flex: 2,
                              child: AppText(
                                text:
                                    controller.itemModelList[index].notes ?? "",
                              ),
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              flex: 1,
                              child: Wrap(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0067B1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: AppText(
                                      text:
                                          (controller
                                                      .itemModelList[index]
                                                      .qty ??
                                                  0)
                                              .toString(),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 2),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: controller.isDeleteLoading
                                      ? null
                                      : () {
                                          controller.deleteStockApi(
                                            controller.itemModelList[index].id,
                                          );
                                        },
                                  child:
                                      controller.isDeleteLoading &&
                                          controller.itemModelList[index].id ==
                                              controller.deleteIndex
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(),
                                        )
                                      : Icon(
                                          Icons.delete_outline,
                                          color: Colors.grey,
                                        ),
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.editStock,
                                      arguments:
                                          controller.itemModelList[index],
                                    )?.then((value) {
                                      if (value == true) {
                                        controller.getItemApi();
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      itemCount: controller.itemModelList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
