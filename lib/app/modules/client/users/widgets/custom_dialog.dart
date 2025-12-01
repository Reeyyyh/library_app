import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void confirm({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    String confirmText = "Ya",
    String cancelText = "Tidak",
    Color confirmColor = Colors.red,
  }) {
    Get.defaultDialog(
      title: "",
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(fontSize: 0),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      radius: 12,
      content: Column(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: confirmColor,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: confirmColor.withOpacity(0.85),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Cancel Button
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: Text(
                    cancelText,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Confirm Button
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: confirmColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    onConfirm();
                  },
                  child: Text(
                    confirmText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
// merge