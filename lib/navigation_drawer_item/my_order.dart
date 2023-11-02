import 'package:doafric/utils/appbarforall.dart';
import 'package:doafric/utils/nodatafounderror.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrder extends StatefulWidget {
  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarScreens(
            text: "My Order",
          )),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: NoDataFoundErrorScreens(),
          // SizedBox(
          //   width: Get.width,
          //   height: Get.height,
          //   child: Center(
          //     child: Text(
          //       "No data Found",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //           color: colorBlack,
          //           fontSize: isMobile(context)
          //               ? MyFontSize().mediumTextSizeMobile
          //               : MyFontSize().mediumTextSizeTablet),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
