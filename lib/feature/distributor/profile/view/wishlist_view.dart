import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:purosis/feature/distributor/profile/controller/profile_controller.dart';
import 'package:purosis/widget/app_dialog.dart';
import 'package:purosis/widget/app_image_view.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_text.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  ProfileController profileController = Get.find();

  @override
  void initState() {
    profileController.getWishlistApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Wishlist"),
      body: GetBuilder<ProfileController>(
        init: profileController,
        builder: (controller) {
          return controller.isWishlistLoading
              ? CommonWidget.commonLoading()
              : controller.wishlistModelList.isEmpty
              ? CommonWidget.commonEmpty()
              : ListView.builder(
                  itemCount: profileController.wishlistModelList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      child: SizedBox(
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Center(
                                      child: SizedBox(
                                        width: 90,
                                        height: 90,
                                        child: AppImageView(
                                          imageUrl:
                                              controller
                                                  .wishlistModelList[index]
                                                  .product
                                                  ?.productColorsImages
                                                  ?.firstOrNull
                                                  ?.images
                                                  ?.firstOrNull ??
                                              "",
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: AppText(
                                        text:
                                            controller
                                                .wishlistModelList[index]
                                                .product
                                                ?.productName ??
                                            "",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                AppDialogs.showStatusDialog(
                                  title: "Remove",
                                  message:
                                      "Do you want to remove this item from your wishlist?",
                                  onConfirm: () async {
                                    await controller.addProductWishlistApi(
                                      controller
                                          .wishlistModelList[index]
                                          .productId
                                          .toString(),
                                      0,
                                    );
                                  },
                                  isLoading: controller.isAddWishlistLoading,
                                );
                              },
                              icon: Icon(Icons.favorite, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
