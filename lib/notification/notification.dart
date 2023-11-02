import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Notification extends StatelessWidget {
  var categoryName = "Notification";

  Notification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorWhite,
        centerTitle: true,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: colorBlack,
            size: 25,
          ),
          onTap: () {
            Get.offAndToNamed(Routes.dashboard);
          },
        ),
        title: TextView(
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
          font_size: isMobile(context)
              ? MyFontSize().normalTextSizeMobile
              : MyFontSize().normalTextSizeTablet,
          fontColor: colorPrimary,
          text: categoryName,
          textStyle: Theme.of(context).textTheme.bodyText1!,
          softWrap: true,
        ),
      ),
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
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: ImageIcon(
                    AssetImage(ImageFile.mainlogo),
                    size: 70,
                    color: colorPrimary,
                  ),
                ),
                const Center(
                    child: Text(
                  "Informations",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Amazon',
                      fontWeight: FontWeight.bold,
                      color: colorPrimary),
                )),
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
                            size: 25,
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
                      border: Border.all(color: Colors.black)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          ImageIcon(
                            AssetImage(
                              ImageFile.privacy,
                            ),
                            size: 25,
                          ),
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
                      border: Border.all(color: Colors.black)),
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
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "About Duafric",
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Amazon',
                                fontWeight: FontWeight.bold,
                                color: colorBlack),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.forward))
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
