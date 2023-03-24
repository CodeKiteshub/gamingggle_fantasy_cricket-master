import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constance/themes.dart';

class ShowToast {
  static void show({title, message, bool isSuccess = false}) {
    Get.snackbar(title, message,
        backgroundColor: isSuccess
            ? AllCoustomTheme.getThemeData().primaryColor
            : Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }
}
