// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/utils/circle_image_view.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db_helper/sqlite_database.dart';
import '../page_routes/routes.dart';

class ProductSize1 extends StatelessWidget {
  int id;
  // ignore: prefer_typing_uninitialized_variables
  final product;
  List variant1;
  List variant2;
  List variant3;

  ProductSize1(
      {super.key, required this.id,
      required this.product,
      required this.variant1,
      required this.variant2,
      required this.variant3});

  RxInt quantity = 1.obs;

  final RxString _selectedIndex = ''.obs;
  final RxString _selectedVariantTwo = ''.obs;
  _onSelected(RxString variable, String index) {
    variable.value = index;
  }

  @override
  Widget build(BuildContext context) {
    variant1.isNotEmpty
        ? _selectedIndex.value = variant1[0]
        : _selectedIndex.value = '';
    variant2.isNotEmpty
        ? _selectedVariantTwo.value = variant2[0]
        : _selectedVariantTwo.value = '';
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 237, 240, 244)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft, // and bottomLeft
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.home_max_outlined))
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: MediaQuery.of(context).size.width - 5,
                  //child: Image.network( img, ),
                  child: CachedNetworkImage(
                    imageUrl: product['image_url'] ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        // borderRadius:
                        //     const BorderRadius.all(Radius.circular(15.0)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => SizedBox(
                      width: Get.width,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        image: DecorationImage(
                            image: AssetImage(ImageFile.placeholder),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              height: 40,
                              // width: MediaQuery.of(context).size.width - 5,
                              //  child: Image.network( img, ),
                              child: CircleImageView(
                                url: product['image_url'] ?? '',
                                width: 80,
                                height: 80,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("\$${product['sale_price']}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: colorPrimary,
                                        decoration:
                                            TextDecoration.lineThrough)),
                                const Row(
                                  children: [
                                    Text(
                                      "Selected: ",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                    Text(
                                      "1, Black, Large",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.cancel,
                      color: colorlightGrey,
                      size: 20,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Color",
                  style: TextStyle(fontSize: 15),
                ),
                variant1.isNotEmpty
                    ? Obx(() => Wrap(
                          direction: Axis.horizontal,
                          children: variant1
                              .map((i) => GestureDetector(
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          5, 10, 5, 0),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      decoration: BoxDecoration(
                                          color: _selectedIndex != 0 &&
                                                  _selectedIndex == i
                                              ? colorPrimary
                                              : colorWhite,
                                          border: Border.all(
                                              color: colorPrimary, width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: Text(
                                        i,
                                        style: TextStyle(
                                            color: _selectedIndex != 0 &&
                                                    _selectedIndex == i
                                                ? colorWhite
                                                : colorBlack),
                                      ),
                                    ),
                                    onTap: () {
                                      _onSelected(_selectedIndex, i);
                                    },
                                  ))
                              .toList(),
                        ))
                    : const SizedBox.shrink(),
                const SizedBox(
                  width: 8,
                  height: 9,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Size",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Size Guide",
                      style: TextStyle(
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          decorationThickness: 2),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 15,
                  height: 9,
                ),
                variant2.isNotEmpty
                    ? Obx(() => Wrap(
                          direction: Axis.horizontal,
                          children: variant2
                              .map((i) => GestureDetector(
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          5, 10, 5, 0),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      decoration: BoxDecoration(
                                          color: _selectedVariantTwo != 0 &&
                                                  _selectedVariantTwo == i
                                              ? colorPrimary
                                              : colorWhite,
                                          border: Border.all(
                                              color: colorPrimary, width: 1),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: Text(
                                        i,
                                        style: TextStyle(
                                            color: _selectedVariantTwo != 0 &&
                                                    _selectedVariantTwo == i
                                                ? colorWhite
                                                : colorBlack),
                                      ),
                                    ),
                                    onTap: () {
                                      _onSelected(_selectedVariantTwo, i);
                                    },
                                  ))
                              .toList(),
                        ))
                    : const SizedBox.shrink(),
                const SizedBox(
                  width: 15,
                  height: 12,
                ),
                const Text(
                  "Quality",
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  width: 18,
                  height: 9,
                ),
                Container(
                  width: Get.width / 2.8,
                  height: 50,
                  decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(width: 1, color: colorBlack)),
                  child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                              onPressed: () {
                                if (quantity.value >= 1) {
                                  quantity.value--;
                                  if (quantity.value == 0) {
                                    Get.back();
                                  }
                                }
                              },
                              child: const Text(
                                "-",
                                style: TextStyle(color: colorBlack),
                              )),
                          Text(
                            quantity.value.toString(),
                            style: const TextStyle(color: colorBlack),
                          ),
                          TextButton(
                              onPressed: () {
                                quantity.value++;
                              },
                              child: const Text(
                                "+",
                                style: TextStyle(color: colorBlack),
                              )),
                        ],
                      )),
                ),
                InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(left: 4, right: 4, top: 30),
                    alignment: Alignment.center,
                    height: 35,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [(Color(0xFF113f60)), (Color(0xFF113f60))],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 50,
                          color: Colors.white,
                        )
                      ],
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    if (preferences.getString("name") == null) {
                      SqliteDatabase.writeData("goto", "ProductSize");

                      SqliteDatabase.writeData("productid", id);
                      SqliteDatabase.writeData("product", product);
                      SqliteDatabase.writeData("variant1", variant1);
                      SqliteDatabase.writeData("variant2", variant2);
                      SqliteDatabase.writeData("variant3", variant3);
                      Get.toNamed(Routes.loginSignupScreen);
                    } else {
                      print("user_id ${preferences.getString('id')}");
                      var api = ApiClient.AddtoCart(
                          productid: id,
                          userid: int.parse(preferences.getString('id')!),
                          qty: quantity.value.toString());
                      api.then((value) {
                        if (value['status'] == 'success') {
                          DialogHelper.showFlutterToast(strMsg: value['msg']);
                          Get.back();
                        } else {
                          DialogHelper.showFlutterToast(strMsg: value['msg']);
                        }
                      }, onError: (error) {
                        throw error.toString();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
