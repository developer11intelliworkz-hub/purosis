import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/distributor/cart/controller/cart_controller.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

class ReviewView extends StatefulWidget {
  const ReviewView({super.key});

  @override
  State<ReviewView> createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  CartController cartController = Get.find();

  @override
  void initState() {
    cartController.getSelectedAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Order Summary"),
      body: GetBuilder<CartController>(
        init: cartController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Column(
                                  children: controller.cartModelList
                                      .map(
                                        (data) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: AppText(
                                                      text:
                                                          "PuroAqua Water Purifiers",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  AppText(
                                                    text:
                                                        "${data.totalWeight}Kg",
                                                  ),
                                                ],
                                              ),
                                              AppText(
                                                text: "Color: Matt Black",
                                              ),
                                              AppText(
                                                text:
                                                    "${data.qty} box(es) ${(data.unitsPerBox ?? 0) * (data.qty ?? 0)} units",
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                Divider(),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    AppText(
                                      text: "Total",
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF0067B1),
                                    ),
                                    Spacer(),
                                    AppText(
                                      text:
                                          "${controller.cartModelList.fold(0.0, (sum, item) => double.parse((sum + (double.tryParse(item.totalWeight ?? '') ?? 0)).toString()))} kg / ${controller.cartModelList.fold(0.0, (sum, item) => double.parse((sum + (double.tryParse(item.totalCbm ?? '') ?? 0)).toString()))} m",
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: controller.selectedAddressModelList
                              .map(
                                (data) => Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: data.isShipping == 0
                                              ? "Billing Address"
                                              : "Shipping Address",
                                          color: Color(0xFF0067B1),
                                        ),
                                        Divider(),
                                        SizedBox(height: 10),
                                        AppText(
                                          text: data.dealerName ?? "",
                                          fontWeight: FontWeight.w700,
                                        ),
                                        AppText(text: data.dealerName ?? ""),
                                        AppText(
                                          text: "GST: ${data.gstNumber ?? ""}",
                                        ),
                                        AppText(text: data.city ?? ""),
                                        AppText(text: data.state ?? ""),
                                        AppText(text: data.mobileNo ?? ""),
                                        AppText(text: data.emailAddress ?? ""),
                                        AppText(text: data.address ?? ""),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                AppButton(
                  text: "Place Order",
                  color: Color(0xFF8EBF1F),
                  isLoading: controller.isPlaceOrderLoading,
                  onPressed: () {
                    controller.addOrderApi();
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
