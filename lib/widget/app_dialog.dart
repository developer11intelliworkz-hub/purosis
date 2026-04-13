import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_button.dart';
import 'app_button_outline.dart';

class AppDialogs {
  static void showDeleteDialog({
    required VoidCallback onDelete,
    String title = "Delete Item",
    String message = "Are you sure you want to delete?",
    bool isLoading = false,
  }) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: const [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text("Delete Item"),
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
          SizedBox(
            width: 100,
            child: AppButton(
              isLoading: isLoading,
              text: "Delete",
              color: const Color(0xFF8EBF1F),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
