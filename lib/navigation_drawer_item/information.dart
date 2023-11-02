// ignore_for_file: must_be_immutable

import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/appbarforall.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/image_file.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Information extends StatelessWidget {
  var categoryName = "Information";

  Information({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarScreens(
            text: "Informations",
          )),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: ImageIcon(
                    const AssetImage(ImageFile.mainlogo),
                    size: 12.h,
                    color: colorPrimary,
                  ),
                ),
                // const Center(
                //     child: Text(
                //   "Informations",
                //   style: TextStyle(
                //       fontSize: 18,
                //       fontFamily: 'Amazon',
                //       fontWeight: FontWeight.bold,
                //       color: colorPrimary),
                // )),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          ImageIcon(
                            AssetImage(
                              ImageFile.termsconditions,
                            ),
                            size: 22,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Terms & Conditions ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Amazon',
                                fontWeight: FontWeight.bold,
                                color: colorBlack),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Get.offAndToNamed(Routes.termscondition);
                          },
                          icon: const Icon(Icons.forward))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colorGrey)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.privacy_tip_outlined,
                            size: 22,
                          ),

                          // ImageIcon(
                          //   AssetImage(
                          //     ImageFile.privacy,
                          //   ),
                          //   size: 25,
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Privacy Policy ",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Amazon',
                                fontWeight: FontWeight.bold,
                                color: colorBlack),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Get.offAndToNamed(Routes.privacypolicy);
                          },
                          icon: const Icon(Icons.forward))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colorGrey)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          ImageIcon(
                            AssetImage(
                              ImageFile.mainlogo,
                            ),
                            size: 22,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "About doafric",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Amazon',
                                fontWeight: FontWeight.bold,
                                color: colorBlack),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Get.offAndToNamed(Routes.aboutus);
                          },
                          icon: const Icon(Icons.forward))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
