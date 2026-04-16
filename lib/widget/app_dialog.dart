import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/widget/app_text.dart';

import 'app_button.dart';
import 'app_button_outline.dart';

class AppDialogs {
  static void showDeleteDialog({
    required VoidCallback onDelete,
    String title = "Delete Item",
    String message = "Are you sure you want to delete?",
    required RxBool isLoading,
  }) {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            AppText(text: title),
          ],
        ),
        content: Text(message),
        actions: [
          SizedBox(
            width: 100,
            child: AppButtonOutline(
              onPressed: () => Get.back(),
              text: 'Cancel',
              color: const Color(0xFF8EBF1F),
            ),
          ),

          Obx(
            () => SizedBox(
              width: 100,
              child: AppButton(
                isLoading: isLoading.value,
                text: "Delete",
                color: const Color(0xFF8EBF1F),
                onPressed: onDelete,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static void showStatusDialog({
    required VoidCallback onConfirm,
    required RxBool isLoading,
    String title = "Change Status",
    required String message,
    String confirmText = "Yes",
  }) {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info, color: Colors.blue),
            SizedBox(width: 8),
            AppText(text: title),
          ],
        ),
        content: Text(message),
        actions: [
          SizedBox(
            width: 100,
            child: AppButtonOutline(
              onPressed: () => Get.back(),
              // ✅ Use onCancel if provided
              text: 'Cancel',
              color: const Color(0xFF8EBF1F),
            ),
          ),
          Obx(
            () => SizedBox(
              width: 100,
              child: AppButton(
                isLoading: isLoading.value,
                text: confirmText,
                color: const Color(0xFF8EBF1F),
                onPressed: onConfirm,
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
