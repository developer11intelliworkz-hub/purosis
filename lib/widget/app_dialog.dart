import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_button.dart';
import 'app_button_outline.dart';

class AppDialogs {
  static void showDeleteDialog({
    required VoidCallback onDelete,
    String title = "Delete",
    String message = "Are you sure you want to delete ?",
    required RxBool isLoading,
  }) {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning, color: Colors.red),
                  SizedBox(width: 8),
                  Text(title),
                ],
              ),

              const SizedBox(height: 16),

              Text(message),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: AppButtonOutline(
                      onPressed: () => Get.back(),
                      text: 'Cancel',
                      color: const Color(0xFF8EBF1F),
                    ),
                  ),

                  const SizedBox(width: 10),

                  SizedBox(
                    width: 100,
                    height: 40,
                    child: Obx(
                      () => AppButton(
                        isLoading: isLoading.value,
                        text: "Delete",
                        color: const Color(0xFF8EBF1F),
                        onPressed: onDelete,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showStatusDialog({
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    required RxBool isLoading,
    String title = "Change Status",
    String? message,
    String confirmText = "Confirm",
  }) {
    Get.dialog(
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info, color: Colors.green),
                  SizedBox(width: 8),
                  Text(title),
                ],
              ),
              const SizedBox(height: 16),
              Text(message ?? ""),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: AppButtonOutline(
                      onPressed: onCancel ?? () => Get.back(),
                      text: 'Cancel',
                      color: const Color(0xFF8EBF1F),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: Obx(
                      () => AppButton(
                        isLoading: isLoading.value,
                        text: confirmText,
                        color: const Color(0xFF8EBF1F),
                        onPressed: onConfirm,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
