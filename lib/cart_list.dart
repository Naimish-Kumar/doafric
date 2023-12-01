import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/checkout/add_address.dart';
import 'package:doafric/checkout/address_list.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/db_helper/sqlite_database.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/screens/addressbook.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:doafric/utils/nodatafounderror.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/string_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  TextEditingController etCoupon = TextEditingController();
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

    preferences.commit();
  }

  RxBool isCoupon = false.obs;

  RxList listData = [].obs;

  double total = 0.0, tax = 0.0, orderTotal = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 1.h, left: 2.h, right: 2.h, bottom: 2.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ignore: unnecessary_null_comparison
                _id != null
                    ? FutureBuilder(
                        future: ApiClient.GetCartList(id: _id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                              width: Get.width,
                              height: Get.height,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData) {
                              Map map = snapshot.data as Map;
                              List data = map['data']['data'];
        
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                listData.addAll(data);
                              });
                              total = 0.0;
                              orderTotal = 0.0;
                              tax = 0.0;
                              for (int i = 0; i < data.length; i++) {
                                total = total +
                                    (double.parse(
                                            data[i]['product']["regular_price"]) *
                                        data[i]['qty']);
                                tax =
                                    tax + double.parse(data[i]['product']['tax']);
                              }
                              // print("printtotal ${total}");
                              orderTotal = total + tax;
                              // print("cart_lis ${data}");
                              return SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Shopping Cart",
                                          style: TextStyle(
                                              fontFamily: 'Amazon',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            AwesomeDialog(
                                              context: context,
        
                                              dialogType: DialogType.info,
                                              btnOkColor: colorPrimary,
                                              borderSide: BorderSide(
                                                  color: colorPrimary,
                                                  width: 0.1.h),
                                              buttonsBorderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(2)),
        
                                              animType: AnimType.topSlide,
                                              showCloseIcon: true,
        
                                              title: 'Warning',
                                              desc: 'Are You Sure to delete ?',
                                              // btnCancelOnPress: () {},
                                              btnOkOnPress: () {
                                                var api = ApiClient.removeallcart(
                                                    user_id: _id);
        
                                                api.then((value) {
                                                  if (value['status'] ==
                                                      'success') {
                                                    DialogHelper.showFlutterToast(
                                                        strMsg: value['msg']);
                                                    setState(() {});
                                                    const CircularProgressIndicator();
                                                  } else {
                                                    DialogHelper.showFlutterToast(
                                                        strMsg: value['msg']);
                                                  }
                                                }, onError: (error) {
                                                  throw error.toString();
                                                });
                                              },
                                            ).show();
                                          },
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.delete,
                                                color: colorGrey,
                                                size: 16,
                                              ),
                                              Text(
                                                "Remove all",
                                                style: TextStyle(
                                                    // decoration:
                                                    //     TextDecoration.underline,
                                                    fontFamily: 'Amazon',
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 0.2, color: colorGrey),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        SqliteDatabase.writeData(
                                            StorageKeys.title,
                                            data[index]['product']['title']);
                                        SqliteDatabase.writeData(
                                            StorageKeys.imageurl,
                                            data[index]['product']['image_url']);
                                        SqliteDatabase.writeData(
                                            StorageKeys.regularprice,
                                            data[index]['product']
                                                ['regular_price']);
                                        SqliteDatabase.writeData(
                                            StorageKeys.saleprice,
                                            data[index]['product']['sale_price']);
        
                                        return InkWell(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                  border:
                                                                      Border.all(
                                                            color: Colors.white70,
                                                          )),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(15),
                                                            child: FittedBox(
                                                              fit: BoxFit.fill,
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: data[index]
                                                                            [
                                                                            'product']
                                                                        [
                                                                        'image_url'] ??
                                                                    '',
                                                                imageBuilder: (context,
                                                                        imageProvider) =>
                                                                    Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        const BorderRadius.all(Radius.circular(15.0)),
                                                                    image: DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                                placeholder: (context,
                                                                        url) =>
                                                                    const SizedBox(
                                                                  height: 100,
                                                                  width: 100,
                                                                  child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  ),
                                                                ),
                                                                errorWidget:
                                                                    (context, url,
                                                                            error) =>
                                                                        Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .all(Radius
                                                                            .circular(
                                                                                15.0)),
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                            ImageFile
                                                                                .placeholder),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                Text(
                                                                  "\$ ${data[index]['product']["regular_price"]}",
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Amazon',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          colorPrimary,
                                                                      fontSize:
                                                                          11),
                                                                ),
                                                                const SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Text(
                                                                  "\$ ${data[index]['product']["sale_price"]}",
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Amazon',
                                                                      color: Colors
                                                                          .grey,
                                                                      fontSize:
                                                                          10,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              data[index]
                                                                      ['product']
                                                                  ['title'],
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Amazon',
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black87),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            const Text(
                                                              "1. Black large",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Amazon',
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              "Qty: ${data[index]['qty']}",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Amazon',
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black87),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.grey,
                                                      ),
                                                      onPressed: () {
                                                        AwesomeDialog(
                                                          context: context,
                                                          //animType: AnimType.SCALE,
                                                          dialogType:
                                                              DialogType.warning,
                                                          animType:
                                                              AnimType.topSlide,
                                                          showCloseIcon: true,
                                                          title: 'Warning',
                                                          desc: 'Are You Sure',
                                                          btnCancelOnPress: () {},
                                                          btnOkOnPress: () {
                                                            var api = ApiClient
                                                                .DeleteAddtoCart(
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
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          StringFile.promoCode,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Amazon',
                                            color: colorBlack,
                                            fontWeight: FontWeight.w500,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .normalTextSizeMobile
                                                : MyFontSize()
                                                    .normalTextSizeTablet,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down_outlined,
                                              color: colorBlack,
                                              size: 15,
                                            ))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Get.width / 2.5,
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: colorBlack, width: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8.0))),
                                          child: TextField(
                                            controller: etCoupon,
                                            onChanged: onTextChanged,
                                            textAlign: TextAlign.start,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    StringFile.enterCouponCode,
                                                contentPadding: EdgeInsets.zero,
                                                hintStyle: TextStyle(
                                                    fontFamily: 'Amazon',
                                                    color: colorlightGrey,
                                                    fontSize: isMobile(context)
                                                        ? MyFontSize()
                                                            .normalTextSizeMobile
                                                        : MyFontSize()
                                                            .normalTextSizeTablet)),
                                          ),
                                        ),
                                        Obx(() => isCoupon.value == false
                                            ? Container(
                                                margin: const EdgeInsets.fromLTRB(
                                                    0.0, 10.0, 0.0, 10.0),
                                                width: Get.width / 2.5,
                                                height: 50,
                                                // decoration: const BoxDecoration(
                                                //     color: colorPrimaryButtonLight,
        
                                                //     borderRadius: BorderRadius.all(
                                                //         Radius.circular(5.0))),
        
                                                decoration: BoxDecoration(
                                                  color: colorPrimaryButtonLight,
                                                  borderRadius:
                                                      BorderRadius.circular(8.0),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Colors.grey,
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: Offset(1,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
        
                                                child: Center(
                                                  child: Text(
                                                    StringFile.apply,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'Amazon',
                                                        color: colorWhite,
                                                        fontSize: isMobile(
                                                                context)
                                                            ? MyFontSize()
                                                                .mediumTextSizeMobile
                                                            : MyFontSize()
                                                                .mediumTextSizeTablet,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )
                                            : InkWell(
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0.0, 10.0, 0.0, 10.0),
                                                  width: Get.width / 2.5,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: colorPrimary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        spreadRadius: 2,
                                                        blurRadius: 2,
                                                        offset: Offset(1,
                                                            2), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      StringFile.apply,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'Amazon',
                                                          color: colorWhite,
                                                          fontSize: isMobile(
                                                                  context)
                                                              ? MyFontSize()
                                                                  .mediumTextSizeMobile
                                                              : MyFontSize()
                                                                  .mediumTextSizeTablet,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  if (etCoupon.text
                                                      .toString()
                                                      .isEmpty) {
                                                    DialogHelper.showFlutterToast(
                                                        strMsg: StringFile
                                                            .pleaseEnterCouponCode);
                                                  }
                                                })),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          StringFile.subtotal,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Amazon',
                                            color: colorBlack,
                                            fontWeight: FontWeight.w400,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .normalTextSizeMobile
                                                : MyFontSize()
                                                    .normalTextSizeTablet,
                                          ),
                                        ),
                                        Text(
                                          StringFile.signDollar +
                                              total.toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Amazon',
                                            color: colorBlack,
                                            fontWeight: FontWeight.w400,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .normalTextSizeMobile
                                                : MyFontSize()
                                                    .normalTextSizeTablet,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          StringFile.estimatedShipping,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: colorBlack,
                                            fontFamily: 'Amazon',
                                            fontWeight: FontWeight.w400,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .normalTextSizeMobile
                                                : MyFontSize()
                                                    .normalTextSizeTablet,
                                          ),
                                        ),
                                        Text(
                                          "${StringFile.signDollar}0",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Amazon',
                                            color: colorBlack,
                                            fontWeight: FontWeight.w400,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .normalTextSizeMobile
                                                : MyFontSize()
                                                    .normalTextSizeTablet,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          StringFile.tax,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Amazon',
                                            color: colorBlack,
                                            fontWeight: FontWeight.w400,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .normalTextSizeMobile
                                                : MyFontSize()
                                                    .normalTextSizeTablet,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          StringFile.signDollar + tax.toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: colorBlack,
                                            fontFamily: 'Amazon',
                                            fontWeight: FontWeight.w400,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .normalTextSizeMobile
                                                : MyFontSize()
                                                    .normalTextSizeTablet,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width: 0.5, color: colorGrey),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          StringFile.orderTotal,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: colorBlack,
                                            fontFamily: 'Amazon',
                                            fontWeight: FontWeight.w400,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .normalTextSizeMobile
                                                : MyFontSize()
                                                    .normalTextSizeTablet,
                                          ),
                                        ),
                                        Text(
                                          StringFile.signDollar +
                                              orderTotal.toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: colorBlack,
                                            fontFamily: 'Amazon',
                                            fontWeight: FontWeight.w400,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .normalTextSizeMobile
                                                : MyFontSize()
                                                    .normalTextSizeTablet,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox.shrink(),
                                  ],
                                ),
                              );
                            }
                          } else if (!snapshot.hasData) {
                            return SizedBox(
                                width: Get.width,
                                height: Get.height,
                                child: NoDataFoundErrorScreens()
                                );
                          }
                          return const SizedBox.shrink();
                        })
                    : SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: NoDataFoundErrorScreens()
                        ),
                SizedBox(
                  height: 5.h,
                ),
                Obx(
                  // ignore: invalid_use_of_protected_member
                  () => listData.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            SqliteDatabase.writeData(
                                StorageKeys.orderTotal, orderTotal);
                            SqliteDatabase.writeData(StorageKeys.total, total);
                            SqliteDatabase.writeData(StorageKeys.tax, tax);
                            // ignore: unnecessary_null_comparison
                            if (_id.toString() == null &&
                                _id.toString().isEmpty) {
                              Get.to(const AddAddress());
                            } else {
                              Get.to(const AddressList());
                            }
        
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: colorPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 20),
                                  blurRadius: 50,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            child: const Text(
                              "Proceed to Checkout",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Amazon',
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTextChanged(String text) {
    if (text.isNotEmpty) {
      isCoupon.value = true;
    } else {
      isCoupon.value = false;
    }
  }
}
