import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/db_helper/sqlite_database.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:doafric/utils/nodatafounderror.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/string_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../utils/text_widget.dart';

class OrderReview extends StatefulWidget {
  const OrderReview({super.key});

  @override
  State<OrderReview> createState() => _OrderReviewState();
}

class _OrderReviewState extends State<OrderReview> {
  TextEditingController etCoupon = TextEditingController();
  int _id = 0;
  int totel = 0;
  String? add1, add2, country, state, zip, id;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      _id = int.parse(preferences.getString('id').toString());
      add1 = preferences.getString('address_line_1').toString();
      add2 = preferences.getString('address_line_2').toString();
      country = preferences.getString('country').toString();
      state = preferences.getString('state').toString();
      zip = preferences.getString('zip').toString();
    });
    // print(add1!.toString());
    // print(add1.toString());
    // print(country.toString());
    // print(state.toString());

    preferences.commit();
  }

  RxBool isCoupon = false.obs;

  RxList listData = [].obs;

  double total = 0.0, tax = 0.0, orderTotal = 0.0;

  @override
  Widget build(BuildContext context) {
    var categoryName = "Order CheckOut";
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
          textStyle: Theme.of(context).textTheme.bodyLarge!,
          softWrap: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height,
              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
              child: SizedBox(
                // ignore: unnecessary_null_comparison
                child: _id != null
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
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              Map map = snapshot.data as Map;
                              List data = map['data']['data'];

                              // print("USer Dataddd$user");

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                listData.addAll(data);
                              });
                              total = 0.0;
                              orderTotal = 0.0;
                              tax = 0.0;
                              for (int i = 0; i < data.length; i++) {
                                total = total +
                                    (double.parse(data[i]['product']
                                            ["regular_price"]) *
                                        data[i]['qty']);
                                tax = tax +
                                    double.parse(data[i]['product']['tax']);
                              }
                              // print("printtotal ${total}");
                              orderTotal = total + tax;
                              // print("cart_lis ${data}");
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListView.builder(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // ignore: unused_element

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

                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
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
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                        color: Colors.white70,
                                                      )),
                                                      child: FittedBox(
                                                        fit: BoxFit.fill,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: data[index][
                                                                      'product']
                                                                  [
                                                                  'image_url'] ??
                                                              '',
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            height: 120,
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              // borderRadius:
                                                              //     const BorderRadius.all(Radius.circular(15.0)),
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
                                                            height: 120,
                                                            width: 100,
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(
                                                            height: 120,
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
                                                              "\$ ${data[index]['product']
                                                                          [
                                                                          "regular_price"]}",
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Amazon',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      colorPrimary,
                                                                  fontSize: 11),
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
                                                                  fontSize: 10,
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
                                                          data[index]['product']
                                                              ['title'],
                                                          style:
                                                              const TextStyle(
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
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          "Qty: ${data[index]['qty']}",
                                                          style:
                                                              const TextStyle(
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
                                                                id: data[index]
                                                                    ['id']);

                                                        api.then((value) {
                                                          if (value['status'] ==
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
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 0.5, color: colorPrimary),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                          icon: const Icon(
                                            Icons.location_pin,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {}),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            country.toString() +
                                                state.toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Amazon',
                                                fontWeight: FontWeight.w300,
                                                color: colorBlack),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            add1!,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Amazon',
                                                fontWeight: FontWeight.normal,
                                                color: colorGrey),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            add2.toString() + zip.toString(),
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Amazon',
                                                fontWeight: FontWeight.normal,
                                                color: colorGrey),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
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
                                            width: 0.5, color: colorPrimary),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 0.5, color: colorPrimary),
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
                                            width: 0.5, color: colorPrimary),
                                      ),
                                    ),
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
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 0.5, color: colorPrimary),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        print("button clicked");
                                        newMathod(data);
                                        setState(() {
                                          isLoading = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colorPrimary,
                                        padding: const EdgeInsets.all(20.0),
                                      ),
                                      child: Text(
                                        StringFile.placeorder,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: colorWhite,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .mediumTextSizeMobile
                                                : MyFontSize()
                                                    .mediumTextSizeTablet),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              );
                            }
                          } else if (!snapshot.hasData) {
                            // return SizedBox(
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
                            // );
                            NoDataFoundErrorScreens();
                          }
                          return const SizedBox();
                        })
                    : SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: NoDataFoundErrorScreens(),
                        // child: Center(
                        //   child: Text(
                        //     "No data Found",
                        //     textAlign: TextAlign.center,
                        //     style: TextStyle(
                        //         color: colorBlack,
                        //         fontSize: isMobile(context)
                        //             ? MyFontSize().mediumTextSizeMobile
                        //             : MyFontSize().mediumTextSizeTablet),
                        //   ),
                        // ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Dio dio = Dio();

  Future<void> newMathod(List data) async {
    Map<String, String> dataMap = {};

    dataMap["user_id"] = _id.toString();
    dataMap["order_duration"] = "5";
    dataMap["order_quantity"] = data.length.toString();
    dataMap["order_price"] = total.toString();
    dataMap["payment_type"] = "Paypal";
    dataMap["order_status"] = "pending";
    dataMap["shipping_addess"] = "140";
    dataMap["billing_address"] = "140";
    dataMap["gst_billing"] = "yes";
    dataMap["gst_number"] = "98HGGHHIIHHKH";
    dataMap["company_name"] = "Test";
    dataMap["company_address"] = "Test";
    dataMap["user_type"] = "user";
    dataMap["shiping_fee"] = "200";
    dataMap["tax_fee"] = "160";

    for (int i = 0; i < data.length; i++) {
      double totalPrice = double.parse("${data[i]['product']['sale_price']}") *
          double.parse("${data[i]['qty']}");

      dataMap["order_product[$i]['product_id']"] = "${data[i]['product_id']}";
      dataMap["order_product[$i]['qty']"] = "${data[i]['qty']}";
      dataMap["order_product[$i]['single_price']"] =
          "${data[i]['product']['sale_price']}";
      dataMap["order_product[$i]['total_price']"] = "$totalPrice";
      dataMap["order_product[$i]['variant_id']"] = "${data[i]['variant_id']}";
    }
    print(json.encode(dataMap));

    var response = await dio.post(
        "https://doafric.imperialitforweb.com/api/add_order",
        data: json.encode(dataMap));
    DialogHelper.showFlutterToast(strMsg: 'Order Successfully');

    print(response.data);
  }
}
