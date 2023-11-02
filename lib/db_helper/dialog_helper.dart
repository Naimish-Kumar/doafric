import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class DialogHelper {
  RxBool isCheck = false.obs;

  static void hideLoading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static Future<void> showFlutterToast({required String strMsg}) async {
    await Fluttertoast.showToast(
      msg: strMsg,
      textColor: const Color.fromARGB(255, 3, 18, 29),
      backgroundColor: const Color.fromARGB(255, 143, 184, 245),
      gravity: ToastGravity.TOP_RIGHT,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
