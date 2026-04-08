import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/profile/model/banner_model.dart';
import 'package:purosis/widget/app_image_view.dart';

import '../../../../utils/common_validation.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_drop_down.dart';
import '../../../../widget/app_text.dart';
import '../../../../widget/common_widget.dart';
import '../controller/banner_controller.dart';

class EditBannerView extends StatefulWidget {
  const EditBannerView({super.key});

  @override
  State<EditBannerView> createState() => _EditBannerViewState();
}

class _EditBannerViewState extends State<EditBannerView> {
  final BannerController bannerController = Get.find();
  BannerModel bannerModel = Get.arguments;

  @override
  void initState() {
    bannerController.selectedOfferFor = bannerModel.type?.capitalizeFirst;
    super.initState();
  }

  @override
  void dispose() {
    bannerController.selectedFile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Add Banner"),
      body: GetBuilder<BannerController>(
        init: bannerController,
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
                    selectedItem: controller.selectedOfferFor,
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
                      child:
                          bannerModel.image != null &&
                              controller.selectedFile == null
                          ? AppImageView(imageUrl: bannerModel.image)
                          : controller.selectedFile != null
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
                        controller.editBannerApi(bannerModel.id);
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
