import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/stock/controller/stock_controller.dart';
import 'package:purosis/feature/admin/stock/view/widget/items_list.dart';
import 'package:purosis/feature/admin/stock/view/widget/transaction_history_list.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

class PromotionalStock extends StatefulWidget {
  const PromotionalStock({super.key});

  @override
  State<PromotionalStock> createState() => _PromotionalStockState();
}

class _PromotionalStockState extends State<PromotionalStock> {
  final StockController stockController = StockController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0067B1),
        shape: CircleBorder(),
        onPressed: () {
          Get.toNamed(AppRoutes.inwardPromotionalStock)?.then((value) {
            if (value == true) {
              stockController.getItemApi();
            }
          });
        },
        child: Icon(Icons.add, color: Colors.white, size: 28),
      ),
      appBar: CommonWidget.appAppBar(title: "Promotional Stock"),
      body: GetBuilder<StockController>(
        init: stockController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Manage promotional items and stock",
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF888888),
                  fontSize: 14,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.inwardPromotionalStock)?.then((
                            value,
                          ) {
                            if (value == true) {
                              controller.selectedList = 1;

                              controller.getItemApi();
                            }
                          });
                        },
                        child: AppButton(
                          prefixIcon: Image(
                            image: AssetImage("assets/icon/inward.png"),
                          ),
                          text: "Inward",
                          color: Color(0xFF8EBF1F),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.outwardPromotionalStock)?.then((
                            value,
                          ) {
                            if (value == true) {
                              controller.selectedList = 2;
                              controller.getHistoryApi();
                            }
                          });
                        },
                        child: AppButton(
                          prefixIcon: Image(
                            image: AssetImage("assets/icon/outward.png"),
                          ),
                          text: "Outward",
                          color: Color(0xFF0067B1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          controller.changeListType(1);
                        },
                        child: Container(
                          height: 40,
                          width: 93,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: controller.selectedList == 1
                                ? Border.all(color: Colors.grey, width: 2)
                                : null,
                            borderRadius: BorderRadius.circular(50),
                            color: controller.selectedList == 1
                                ? Colors.grey
                                : Colors.white,
                          ),
                          child: AppText(
                            text: "Items",
                            fontWeight: FontWeight.w600,
                            color: controller.selectedList == 1
                                ? Colors.white
                                : Color(0xFF888888),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          controller.changeListType(2);
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: controller.selectedList == 2
                                ? Colors.grey
                                : Colors.white,
                          ),
                          child: AppText(
                            text: "Transactions History",
                            fontWeight: FontWeight.w600,
                            color: controller.selectedList == 2
                                ? Colors.white
                                : Color(0xFF888888),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: controller.selectedList == 1
                      ? ItemsList()
                      : TransactionHistoryList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
