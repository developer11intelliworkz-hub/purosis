import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purosis/feature/dealer/marketing/model/customize_post_model.dart';
import 'package:purosis/utils/commmon_function.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/app_button.dart';
import '../../../../widget/app_image_view_thumb.dart';

class CustomizePostPreview extends StatefulWidget {
  const CustomizePostPreview({super.key});

  @override
  State<CustomizePostPreview> createState() => _CustomizePostPreviewState();
}

class _CustomizePostPreviewState extends State<CustomizePostPreview> {
  final CustomizePostModel postModel = Get.arguments;
  final GlobalKey repaintKey = GlobalKey();
  bool isDownloadLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidget.appAppBar(title: "Preview"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            RepaintBoundary(
              key: repaintKey,
              child: SizedBox(
                width: 1080,
                child: Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: AppImageViewThumb(
                          imageUrl: postModel.imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: AppImageViewThumb(
                                imageUrl: postModel.logoUrl,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(text: "Address :"),
                                  AppText(
                                    text: postModel.address ?? "",
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 5),
                                  AppText(text: "Mail Id : ${postModel.mail}"),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AppImage.callIcon,
                                              width: 15,
                                            ),
                                            SizedBox(width: 3),
                                            AppText(text: "${postModel.call}"),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AppImage.whatsAppIcon,
                                              width: 15,
                                            ),
                                            SizedBox(width: 3),
                                            AppText(text: "${postModel.call}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Share",
                    isLoading: false,
                    onPressed: generateAndShare,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: AppButton(
                    text: "Download",
                    isLoading: isDownloadLoading,
                    onPressed: generateCardImage,
                    color: Color(0xFF8EBF1F),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> preloadImages(BuildContext context) async {
    await precacheImage(NetworkImage(postModel.imageUrl ?? ""), context);
    await precacheImage(NetworkImage(postModel.logoUrl ?? ""), context);
  }

  Future<void> generateCardImage() async {
    setState(() {
      isDownloadLoading = true;
    });
    await preloadImages(context);

    await Future.delayed(const Duration(milliseconds: 300));

    await CommonFunction.convertCardToImage(repaintKey);
    setState(() {
      isDownloadLoading = false;
    });
  }

  Future<void> generateAndShare() async {
    try {
      RenderRepaintBoundary boundary =
          repaintKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      final image = await boundary.toImage(pixelRatio: 4);

      final byteData = await image.toByteData(format: ImageByteFormat.png);

      final bytes = byteData!.buffer.asUint8List();

      /// Save temporarily
      final dir = await getTemporaryDirectory();
      final file = File("${dir.path}/post.png");

      await file.writeAsBytes(bytes);

      /// SHARE IMAGE
      await shareImage(file);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> shareImage(File file) async {
    await SharePlus.instance.share(
      ShareParams(
        // text: "Check out this post",
        files: [XFile(file.path)],
      ),
    );
  }
}
