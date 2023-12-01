import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doafric/controller/dashoard_controller1.dart';
import 'package:doafric/main.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDrawer extends StatelessWidget {
  final _dashoardController1 = Get.put(DashoardController1());

   CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15))
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          DrawerHeader(
            padding: EdgeInsets.zero,
            child: Container(
              padding: const EdgeInsets.all(28),
              color: colorPrimary,
              child: const ImageIcon(
                AssetImage(ImageFile.goldenlogo),
                color: golden,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.2, color: colorPrimary),
              ),
            ),
          ),
          ListTile(
            selectedColor: colorWhite,
            selectedTileColor: colorWhite,
            leading: SizedBox(
              height: 20,
              width: 20,
              child: ImageIcon(
                AssetImage(
                  _dashoardController1.imagesList[0],
                ),
                color: colorPrimary,
              ),
            ),
            title: Text(
              _dashoardController1.app_title[0],
              style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Amazon',
                  fontWeight: FontWeight.bold,
                  color: colorPrimary),
            ),
            onTap: () {
              _dashoardController1.tabIndex.value = 0;
              Get.back();
            },
          ),
          ListTile(
            selectedColor: colorWhite,
            selectedTileColor: colorWhite,
            leading: SizedBox(
              height: 20,
              width: 20,
              child: ImageIcon(
                AssetImage(_dashoardController1.imagesList[1]),
                color: colorPrimary,
              ),
            ),
            title: Text(_dashoardController1.app_title[1],
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Amazon',
                    fontWeight: FontWeight.bold,
                    color: colorPrimary)),
            onTap: () {
              _dashoardController1.tabIndex.value = 1;
              Get.back();
            },
          ),
          //products
          // if (MyApp.userid != null)
          ListTile(
            selectedColor: colorWhite,
            selectedTileColor: colorWhite,
            leading: SizedBox(
              height: 20,
              width: 20,
              child: ImageIcon(
                AssetImage(_dashoardController1.imagesList[2]),
                color: colorPrimary,
              ),
            ),
            title: Text(_dashoardController1.app_title[2],
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Amazon',
                    fontWeight: FontWeight.bold,
                    color: colorPrimary)),
            onTap: () {
              Get.toNamed(Routes.productScreen);
            },
          ),

// my cart
          //if (MyApp.userid != null)
          ListTile(
            selectedColor: colorWhite,
            selectedTileColor: colorWhite,
            leading: SizedBox(
              height: 20,
              width: 20,
              child: ImageIcon(
                AssetImage(_dashoardController1.imagesList[3]),
                color: colorPrimary,
              ),
            ),
            title: Text(_dashoardController1.app_title[3],
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Amazon',
                    fontWeight: FontWeight.bold,
                    color: colorPrimary)),
            onTap: () {
              _dashoardController1.tabIndex.value = 2;
              Get.back();
            },
          ),

          //my orders
          // if (MyApp.userid != null)
          ListTile(
            selectedColor: colorWhite,
            selectedTileColor: colorWhite,
            leading: SizedBox(
              height: 20,
              width: 20,
              child: ImageIcon(
                AssetImage(_dashoardController1.imagesList[4]),
                color: colorPrimary,
              ),
            ),
            title: Text(_dashoardController1.app_title[4],
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Amazon',
                    fontWeight: FontWeight.bold,
                    color: colorPrimary)),
            onTap: () {
              Get.toNamed(Routes.myorder);
            },
          ),

          //information
          ListTile(
            selectedColor: colorWhite,
            selectedTileColor: colorWhite,
            leading: SizedBox(
              height: 20,
              width: 20,
              child: ImageIcon(
                AssetImage(_dashoardController1.imagesList[5]),
                color: colorPrimary,
              ),
            ),
            title: Text(_dashoardController1.app_title[5],
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Amazon',
                    fontWeight: FontWeight.bold,
                    color: colorPrimary)),
            onTap: () {
              Get.toNamed(Routes.information);
            },
          ),
          //account
          // if (MyApp.userid != null)
          ListTile(
            selectedColor: colorWhite,
            selectedTileColor: colorWhite,
            leading: SizedBox(
              height: 20,
              width: 20,
              child: ImageIcon(
                AssetImage(_dashoardController1.imagesList[6]),
                color: colorPrimary,
              ),
            ),
            title: Text(_dashoardController1.app_title[6],
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Amazon',
                    fontWeight: FontWeight.bold,
                    color: colorPrimary)),
            onTap: () {
              _dashoardController1.tabIndex.value = 3;
              Get.back();
            },
          ),
          ListTile(
            selectedColor: colorWhite,
            selectedTileColor: colorWhite,
            leading: SizedBox(
              height: 20,
              width: 20,
              child: ImageIcon(
                AssetImage(
                  _dashoardController1.imagesList[7],
                ),
                color: colorPrimary,
              ),
            ),
            title: Text(_dashoardController1.app_title[7],
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Amazon',
                    fontWeight: FontWeight.bold,
                    color: colorPrimary)),
            onTap: () {
              Get.toNamed(Routes.helpSupport);
            },
          ),
          //logout

          ListTile(
            selectedColor: colorWhite,
            selectedTileColor: colorWhite,
            leading: SizedBox(
              height: 20,
              width: 20,
              child: ImageIcon(
                AssetImage(_dashoardController1.imagesList[8]),
                color: colorPrimary,
              ),
            ),
            title: Text(MyApp.userid == null ? 'Login' : 'Logout',
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Amazon',
                    fontWeight: FontWeight.bold,
                    color: colorPrimary)),
            onTap: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.INFO,
                btnOkColor: colorPrimary,
                borderSide: BorderSide(color: colorPrimary, width: 0.1.h),
                buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
                headerAnimationLoop: false,
                animType: AnimType.bottomSlide,
                title: 'Logout',
                desc: 'Are you sure you want to logout of doafric?',
                showCloseIcon: true,
                // btnCancelOnPress: () {
                //   Navigator.pop(context);
                // },
                btnOkOnPress: () {
                  if (MyApp.userid == null) {
                    Navigator.pushNamed(context, Routes.loginSignupScreen);
                  } else {
                    MyApp.logout();
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil(Routes.loginSignupScreen,
                            (Route<dynamic> route) => false);
                  }
                },
              ).show();
            
            },
          ),

          // ListTile(
          //   selectedColor: colorWhite,
          //   selectedTileColor: colorWhite,
          //   leading: SizedBox(
          //     height: 20,
          //     width: 20,
          //     child: ImageIcon(
          //       AssetImage(_dashoardController1.imagesList[8]),
          //       color: colorPrimary,
          //     ),
          //   ),
          //   title: Text(_dashoardController1.app_title[8],
          //       style: const TextStyle(
          //           fontSize: 13,
          //           fontFamily: 'Amazon',
          //           fontWeight: FontWeight.bold,
          //           color: colorPrimary)),
          //   onTap: () {
          //     Get.back();
          //   },
          // ),
        ],
      ),
    );
  }
}
