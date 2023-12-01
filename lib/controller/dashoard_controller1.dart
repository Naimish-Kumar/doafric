// ignore_for_file: non_constant_identifier_names

import 'package:doafric/cart_list.dart';
import 'package:doafric/home/accout_screen.dart';
import 'package:doafric/home/category_screen.dart';
import 'package:doafric/home_screen.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:doafric/utils/string_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashoardController1 extends GetxController {
  RxInt tabIndex = 0.obs;
  List<Widget> wigetOptions = [];

  @override
  onInit() {
    super.onInit();
    wigetOptions = [
      const HomeScreen(),
       Categories(),
      const CartList(),
      const AccountScreen(),
    ];
  }

  onTap(int index) {
    tabIndex.value = index;
  }

  List<String> app_title = [
    StringFile.home,
    StringFile.categories,
    StringFile.product,
    StringFile.mycart,
    StringFile.myorder,
    StringFile.information,
    StringFile.account,
    StringFile.helpsupport,
    StringFile.logout,
  ];

  List<String> imagesList = [
    ImageFile.home,
    ImageFile.category,
    ImageFile.product,
    ImageFile.cart,
    ImageFile.myorder,
    ImageFile.information,
    ImageFile.account,
    ImageFile.support,
    ImageFile.logout,
  ];
}
