import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/admin/profile/controller/banner_controller.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../utils/common_validation.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_drop_down.dart';
import '../../../../widget/app_text.dart';

class AddBannerView extends StatelessWidget {
  const AddBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Add Banner"),
      body: GetBuilder<BannerController>(
        init: BannerController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: controller.validationKey,
              child: Column(
                children: [
                  AppDropDown(
                    label: "Offer For",
                    items: (value, props) => ["Distributor", "Dealer"],
                    showSearchBox: false,
                    onChanged: (value) {
                      controller.selectedOfferFor = value;
                    },
                    validator: CommonValidation.dropdownValidation,
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      controller.pickFile();
                    },
                    child: Container(
                      height: 200,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      alignment: Alignment.center,
                      child: controller.selectedFile != null
                          ? Image.file(
                              controller.selectedFile!,
                              fit: BoxFit.fill,
                            )
                          : Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.upload, color: Colors.grey),
                                  AppText(
                                    text: "Upload Banner",
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                  AppButton(
                    text: "Submit",
                    color: Color(0xFF8EBF1F),
                    isLoading: controller.isBannerAddLoading,
                    onPressed: () {
                      if (controller.validationKey.currentState?.validate() ??
                          false) {
                        controller.addBannerApi();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
