// ignore_for_file: must_be_immutable

import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/db_helper/sqlite_database.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/product_details.dart';
import 'package:doafric/utils/appbarforall.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductList extends StatelessWidget {
  final int category_id;
  final int sub_category_id;
  ProductList({super.key, required this.category_id, required this.sub_category_id});
  var categoryName = "Product List";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarScreens(text: "Product List"),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: ApiClient.getProductListApi(
                category_id: category_id, sub_category_id: sub_category_id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Map map = snapshot.data as Map;
                  List data = map['product_list']['data'];
                  print("product_list ${data}");
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.7),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: Get.width,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                              child: Card(
                                elevation: 2,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          // borderRadius: const BorderRadius.all(
                                          //     Radius.circular(15.0)),
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(5.0),
                                              topLeft: Radius.circular(5.0)),

                                          color: colorWhite,
                                          image: DecorationImage(
                                              image: NetworkImage(data[index]
                                                      ['image_url'] ??
                                                  ''),
                                              fit: BoxFit.fill),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: colorPrimary,
                                                    ),
                                                    child: const Text("4%",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12.0))),
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 15,
                                                  child: IconButton(
                                                    icon: const ImageIcon(
                                                      AssetImage(
                                                          ImageFile.heart),
                                                      color: colorPrimary,
                                                      size: 15,
                                                    ),
                                                    onPressed: () async {
                                                      SharedPreferences
                                                          preferences =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      preferences
                                                          .getInt("value");
                                                      preferences
                                                          .getString("name");
                                                      preferences
                                                          .getString("email");
                                                      preferences
                                                          .getString("mobile");
                                                      preferences
                                                          .getString("id");

                                                      print(
                                                          "user ${preferences.getString("id")}");
                                                      print(
                                                          "user ${preferences.getString("name")}");
                                                      print(
                                                          "user ${preferences.getString("email")}");
                                                      if (preferences.getString(
                                                              "name") ==
                                                          null) {
                                                        SqliteDatabase.writeData(
                                                                "productid",
                                                                data[index]
                                                                    ['id']) ??
                                                            '';

                                                        Get.toNamed(Routes
                                                            .loginSignupScreen);
                                                      } else {
                                                        var api = ApiClient
                                                            .addSaveProductApi(
                                                                product_id:
                                                                    data[index]
                                                                        ['id'],
                                                                user_id: int.parse(
                                                                    preferences
                                                                        .getString(
                                                                            "id")!));
                                                        api.then((value) {
                                                          if (value['status'] ==
                                                              'success') {
                                                            DialogHelper
                                                                .showFlutterToast(
                                                                    strMsg: value[
                                                                        'msg']);
                                                            // Get.back();
                                                          } else {
                                                            DialogHelper
                                                                .showFlutterToast(
                                                                    strMsg: value[
                                                                        'msg']);
                                                          }
                                                        }, onError: (error) {
                                                          throw error
                                                              .toString();
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]["title"] ?? '',
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Amazon',
                                                color: colorBlack),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "\$ ${data[index]['sale_price']}",
                                                style: const TextStyle(
                                                    fontFamily: 'Amazon',
                                                    fontWeight: FontWeight.bold,
                                                    color: colorPrimary,
                                                    fontSize: 11),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "\$ ${data[index]["regular_price"]}",
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontFamily: 'Amazon',
                                                    fontSize: 10,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Get.to(ProductDetails(
                            id: data[index]['id'],
                            varient: data[index]['product_variant'] ?? [],
                          ));
                        },
                      );
                    },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                  );
                }
              }

              return SizedBox(
                width: Get.width,
                height: Get.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
