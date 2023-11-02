import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/db_helper/sqlite_database.dart';
import 'package:doafric/product_details.dart';
import 'package:doafric/utils/appbarforall.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/nodatafounderror.dart';
import 'package:doafric/utils/string_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishList extends StatefulWidget {
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  //var categoryName = "Wish List";
  String id = '';
  int _id = 0;
  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      _id = int.parse(preferences.getString('id').toString());
    });
    print(_id);
    preferences.commit();
  }

  @override
  Widget build(BuildContext context) {
    print("user_id ${SqliteDatabase.readData(StorageKeys.title)}");

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarScreens(text: "Wishlist"),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          // ignore: unnecessary_null_comparison
          child: _id != null
              ? FutureBuilder(
                  future: ApiClient.getShowWishlistApi(id: _id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        print(
                            "user_id ${SqliteDatabase.readData(StorageKeys.userId)}");
                        Map map = snapshot.data as Map;
                        List data = map['data']['data'];
                        print(data.length);
                        print(data);
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 1.9),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: Get.width,
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: Card(
                                      elevation: 2,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: 90,
                                              decoration: BoxDecoration(
                                                color: colorPrimary,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        data[index]['product']
                                                                ['image_url'] ??
                                                            ""),
                                                    fit: BoxFit.fill),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      decoration:
                                                          const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: colorPrimary,
                                                      ),
                                                      child: const Text("%4",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.0))),
                                                  IconButton(
                                                    onPressed: () {
                                                      AwesomeDialog(
                                                        context: context,

                                                        dialogType:
                                                            DialogType.INFO,
                                                        btnOkColor:
                                                            colorPrimary,
                                                        borderSide: BorderSide(
                                                            color: colorPrimary,
                                                            width: 0.1.h),
                                                        buttonsBorderRadius:
                                                            const BorderRadius.all(
                                                                Radius.circular(
                                                                    2)),

                                                        animType:
                                                            AnimType.TOPSLIDE,
                                                        showCloseIcon: true,

                                                        title: 'Warning',
                                                        desc:
                                                            'Are you sure delete from wishlist?',

                                                        // btnCancelOnPress:
                                                        //     () {},
                                                        btnOkOnPress: () {
                                                          var api = ApiClient
                                                              .deleteSaveProductApi(
                                                                  id: data[
                                                                          index]
                                                                      ['id']);

                                                          api.then((value) {
                                                            if (value[
                                                                    'status'] ==
                                                                'success') {
                                                              DialogHelper
                                                                  .showFlutterToast(
                                                                      strMsg: value[
                                                                          'msg']);
                                                              setState(() {});
                                                              const CircularProgressIndicator();
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
                                                        },
                                                      ).show();
                                                    },
                                                    icon: const Icon(
                                                      Icons.favorite_outlined,
                                                      size: 20,
                                                    ),
                                                    color: Colors.red,
                                                  ),
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      data[index]['product']
                                                              ["title"] ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          fontFamily: 'Amazon',
                                                          color: colorBlack),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          AwesomeDialog(
                                                            context: context,

                                                            dialogType:
                                                                DialogType.INFO,
                                                            btnOkColor:
                                                                colorPrimary,
                                                            borderSide: BorderSide(
                                                                color:
                                                                    colorPrimary,
                                                                width: 0.1.h),
                                                            buttonsBorderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            2)),

                                                            animType: AnimType
                                                                .TOPSLIDE,
                                                            showCloseIcon: true,

                                                            title: 'Warning',
                                                            desc:
                                                                'Are you sure delete from wishlist?',

                                                            // btnCancelOnPress:
                                                            //     () {},
                                                            btnOkOnPress: () {
                                                              var api = ApiClient
                                                                  .deleteSaveProductApi(
                                                                      id: data[
                                                                              index]
                                                                          [
                                                                          'id']);

                                                              api.then((value) {
                                                                if (value[
                                                                        'status'] ==
                                                                    'success') {
                                                                  DialogHelper
                                                                      .showFlutterToast(
                                                                          strMsg:
                                                                              value['msg']);
                                                                  setState(
                                                                      () {});
                                                                  const CircularProgressIndicator();
                                                                } else {
                                                                  DialogHelper
                                                                      .showFlutterToast(
                                                                          strMsg:
                                                                              value['msg']);
                                                                }
                                                              }, onError:
                                                                  (error) {
                                                                throw error
                                                                    .toString();
                                                              });
                                                            },
                                                          ).show();
                                                        },
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ))
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      data[index]['product'][
                                                              "regular_price"] ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontFamily: 'Amazon',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: colorPrimary,
                                                          fontSize: 11),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      data[index]['product']
                                                              ["sale_price"] ??
                                                          "",
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontFamily: 'Amazon',
                                                          fontSize: 10,
                                                          decoration:
                                                              TextDecoration
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
                                  id: data[index]['product']['id'] ?? '',
                                  varient: data[index]['product']
                                          ['product_variant'] ??
                                      [],
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
                )
              : SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: NoDataFoundErrorScreens()
                  // child: Center(
                  //   child: Text(
                  //     "No data Found",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontFamily: 'Amazon',
                  //         color: colorBlack,
                  //         fontSize: isMobile(context)
                  //             ? MyFontSize().mediumTextSizeMobile
                  //             : MyFontSize().mediumTextSizeTablet),
                  //   ),
                  // ),
                  ),
        ),
      ),
    );
  }
}
