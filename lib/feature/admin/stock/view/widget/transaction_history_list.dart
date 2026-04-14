import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/stock/controller/stock_controller.dart';

import '../../../../../widget/app_text.dart';
import '../../../../../widget/common_widget.dart';

class TransactionHistoryList extends StatefulWidget {
  const TransactionHistoryList({super.key});

  @override
  State<TransactionHistoryList> createState() => _TransactionHistoryListState();
}

class _TransactionHistoryListState extends State<TransactionHistoryList> {
  StockController stockController = Get.find();

  @override
  void initState() {
    stockController.getHistoryApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockController>(
      init: stockController,
      builder: (controller) {
        return controller.isHistoryLoading
            ? CommonWidget.commonLoading()
            : controller.historyModelList.isEmpty
            ? CommonWidget.commonEmpty()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Transaction History",
                    color: Color(0xFF0067B1),
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(flex: 2, child: AppText(text: "S.No.")),
                      Expanded(flex: 3, child: AppText(text: "Type")),
                      Expanded(flex: 2, child: AppText(text: "Items")),
                      Expanded(flex: 2, child: AppText(text: "Quantity")),
                      Expanded(flex: 2, child: AppText(text: "Recipient")),
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
                                    (controller
                                                .historyModelList[index]
                                                .serialNo ??
                                            "")
                                        .toUpperCase(),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              flex: 3,
                              child: Wrap(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          (controller
                                                      .historyModelList[index]
                                                      .type ??
                                                  "") ==
                                              "inward"
                                          ? Color(
                                              0xFF8EBF1F,
                                            ) // green for inward
                                          : Color(
                                              0xFF0067B1,
                                            ), // blue for outward
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          (controller
                                                          .historyModelList[index]
                                                          .type ??
                                                      "") ==
                                                  "outward"
                                              ? Icons.arrow_circle_up_outlined
                                              : Icons
                                                    .arrow_circle_down_outlined,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        AppText(
                                          text:
                                              controller
                                                  .historyModelList[index]
                                                  .type ??
                                              "",
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: AppText(
                                text:
                                    controller
                                        .historyModelList[index]
                                        .item
                                        ?.itemName ??
                                    "Unknown",
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: AppText(
                                text:
                                    (controller.historyModelList[index].qty ??
                                            0)
                                        .toString(),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: AppText(
                                text:
                                    controller
                                        .historyModelList[index]
                                        .recipient
                                        ?.name ??
                                    "-",
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: controller.historyModelList.length,
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
