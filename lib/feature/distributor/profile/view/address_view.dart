import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/routes/app_routes.dart';
import 'package:purosis/widget/app_dialog.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

import '../controller/address_controller.dart';

class AddressView extends StatefulWidget {
  const AddressView({super.key});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  AddressController addressController = AddressController();

  @override
  void initState() {
    addressController.getAddressApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Dealer Address"),
      body: GetBuilder<AddressController>(
        init: addressController,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.isAddressLoading
                ? CommonWidget.commonLoading()
                : controller.addressModelList.isEmpty
                ? CommonWidget.commonEmpty()
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text:
                                          controller
                                                  .addressModelList[index]
                                                  .isShipping ==
                                              0
                                          ? "Billing Address"
                                          : "Shipping Address",
                                      color: Color(0xFF0067B1),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.edit_outlined,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        Get.toNamed(
                                          AppRoutes.editAddressView,
                                          arguments: controller
                                              .addressModelList[index],
                                        )?.then((value) {
                                          if (value == true) {
                                            controller.getAddressApi();
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: IconButton(
                                      onPressed: () {
                                        AppDialogs.showDeleteDialog(
                                          onDelete: () async {
                                            await controller.deleteAddressApi(
                                              controller
                                                  .addressModelList[index]
                                                  .id,
                                            );
                                          },
                                          isLoading: controller.isDeleteLoading,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(height: 10),
                              AppText(
                                text:
                                    controller
                                        .addressModelList[index]
                                        .dealerName ??
                                    "",
                                fontWeight: FontWeight.w700,
                              ),
                              AppText(
                                text:
                                    controller
                                        .addressModelList[index]
                                        .dealerName ??
                                    "",
                              ),
                              AppText(
                                text:
                                    "GST: ${controller.addressModelList[index].gstNumber ?? ""}",
                              ),
                              AppText(
                                text:
                                    controller.addressModelList[index].city ??
                                    "",
                              ),
                              AppText(
                                text:
                                    controller.addressModelList[index].state ??
                                    "",
                              ),
                              AppText(
                                text:
                                    controller
                                        .addressModelList[index]
                                        .mobileNo ??
                                    "",
                              ),
                              AppText(
                                text:
                                    controller
                                        .addressModelList[index]
                                        .emailAddress ??
                                    "",
                              ),
                              AppText(
                                text:
                                    controller
                                        .addressModelList[index]
                                        .address ??
                                    "",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: controller.addressModelList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 10),
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addAddressView)?.then((value) {
            if (value == true) {
              addressController.getAddressApi();
            }
          });
        },
        backgroundColor: Color(0xFF0061B1),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
