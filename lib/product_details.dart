import 'package:cached_network_image/cached_network_image.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/sqlite_database.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/circle_image_view.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:doafric/utils/string_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db_helper/dialog_helper.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  int id;
  List varient;
  ProductDetails({super.key, required this.id, required this.varient});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var categoryName = "Product Details";

  RxInt quantity = 1.obs;

  final RxString _selectedIndex = ''.obs;
  final RxString _selectedVariantTwo = ''.obs;
  _onSelected(RxString variable, String index) {
    variable.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: widget.varient.isNotEmpty
                  ? ApiClient.getProductDetailsApi(
                      id: widget.id,
                      variant_1: widget.varient[0]['variant_name'] ?? '',
                      variant_2: widget.varient[0]['variant_name_2'] ?? '',
                      variant_3: widget.varient[0]['variant_name_3'] ?? '')
                  : ApiClient.getProductDetailsApi(
                      id: widget.id,
                      variant_1: '',
                      variant_2: '',
                      variant_3: ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    print('variant ${snapshot.data}');
                    Map map = snapshot.data as Map;
                    final data = map['product'];
                    List data4 = map['related_products'];
                    List data1 = map['variant_1'];
                    List data2 = map['variant_2'];

                    return SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 237, 240, 244)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                    alignment:
                                        Alignment.topLeft, // and bottomLeft
                                    child: SafeArea(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Get.back();

                                                // Get.offAndToNamed(
                                                //     Routes.productlist);
                                              },
                                              icon: const Icon(
                                                  Icons.arrow_back_ios)),
                                          IconButton(
                                              onPressed: () {
                                                Get.toNamed(
                                                    Routes.cartListScreen);
                                              },
                                              icon: const Icon(
                                                  Icons.add_shopping_cart))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Stack(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 250,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                1,
                                            child: CachedNetworkImage(
                                              imageUrl: data["image_url"] ?? '',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              15.0)),
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  SizedBox(
                                                width: Get.width,
                                                child: const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Container(
                                                width: Get.width,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15.0)),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          ImageFile
                                                              .placeholder),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, right: 15.0),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                //s radius: 20,
                                                child: IconButton(
                                                  icon: const ImageIcon(
                                                    AssetImage(ImageFile.heart),
                                                    color: colorPrimary,
                                                    size: 15,
                                                  ),
                                                  onPressed: () async {
                                                    SharedPreferences
                                                        preferences =
                                                        await SharedPreferences
                                                            .getInstance();

                                                    preferences.getInt("value");
                                                    preferences
                                                        .getString("name");
                                                    preferences
                                                        .getString("email");
                                                    preferences
                                                        .getString("mobile");
                                                    preferences.getString("id");
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
                                                              data['id']) ??
                                                          '';

                                                      Get.toNamed(Routes
                                                          .loginSignupScreen);
                                                    } else {
                                                      var api = ApiClient
                                                          .addSaveProductApi(
                                                              product_id:
                                                                  data['id'],
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
                                                        throw error.toString();
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    data['title'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Amazon',
                                        fontWeight: FontWeight.bold,
                                        color: colorLogoOrangeLight),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [
                                      if (data['avg_rating'] == null) ...[
                                        Container(),
                                      ] else ...[
                                        Row(
                                          children: List.generate(
                                            data['avg_rating'].round() ?? '',
                                            (index) => const Icon(
                                              Icons.star,
                                              size: 15,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                      ],
                                      const SizedBox(width: 6.0),
                                      Text(
                                         " (${data['product_review_count']} Reviews)",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Amazon',
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 6.0),
                                      const Text(
                                        " 9 sold",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                            fontFamily: 'Amazon'),
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
                                            width: 0.2, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "Colors:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 108, 6, 108),
                                        fontFamily: 'Amazon'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  data1.isNotEmpty
                                      ? Obx(() => Wrap(
                                            direction: Axis.horizontal,
                                            children: data1
                                                .map((i) => GestureDetector(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .fromLTRB(
                                                            5, 10, 5, 0),
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 5, 10, 5),
                                                        decoration: BoxDecoration(
                                                            color: _selectedIndex !=
                                                                        0 &&
                                                                    _selectedIndex ==
                                                                        i
                                                                ? colorPrimary
                                                                : colorWhite,
                                                            border: Border.all(
                                                                color:
                                                                    colorPrimary,
                                                                width: 1),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        5.0))),
                                                        child: Text(
                                                          i,
                                                          style: TextStyle(
                                                              color: _selectedIndex !=
                                                                          0 &&
                                                                      _selectedIndex ==
                                                                          i
                                                                  ? colorWhite
                                                                  : colorBlack),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        _onSelected(
                                                            _selectedIndex, i);
                                                      },
                                                    ))
                                                .toList(),
                                          ))
                                      : const SizedBox.shrink(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 0.2, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "\$${data['regular_price'].toString()}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Amazon',
                                              color: Colors.black45,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.lineThrough)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "\$${data['sale_price'].toString()}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Amazon',
                                          color: colorBlack,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      const Text(
                                        "78% off",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Amazon',
                                          fontWeight: FontWeight.w500,
                                          color: colorPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    " (${data['stock_qty']} in Stock)",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: checkbox,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Amazon'),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 0.2, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Size",
                                        style: TextStyle(
                                            fontFamily: 'Amazon',
                                            fontSize: 15,
                                            color: colorPrimary),
                                      ),
                                      Text(
                                        "Size Guide",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Amazon',
                                            color: colorPrimary,
                                            decorationColor: Colors.blue,
                                            decorationThickness: 2),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 15,
                                    height: 9,
                                  ),
                                  data2.isNotEmpty
                                      ? Obx(() => Wrap(
                                            direction: Axis.horizontal,
                                            children: data2
                                                .map((i) => GestureDetector(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .fromLTRB(
                                                            5, 10, 5, 0),
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                10, 5, 10, 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: _selectedVariantTwo !=
                                                                      0 &&
                                                                  _selectedVariantTwo ==
                                                                      i
                                                              ? colorPrimary
                                                              : colorWhite,
                                                          border: Border.all(
                                                              color:
                                                                  colorPrimary,
                                                              width: 1),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                                5.0),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          i,
                                                          style: TextStyle(
                                                              color: _selectedVariantTwo !=
                                                                          0 &&
                                                                      _selectedVariantTwo ==
                                                                          i
                                                                  ? colorWhite
                                                                  : colorBlack),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        _onSelected(
                                                            _selectedVariantTwo,
                                                            i);
                                                      },
                                                    ))
                                                .toList(),
                                          ))
                                      : const SizedBox.shrink(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 0.2, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ExpansionTile(
                                    tilePadding: const EdgeInsets.all(0),
                                    leading: const Text(
                                      "Product Discriptions:",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Amazon'),
                                    ),
                                    title: const Text(""),
                                    children: <Widget>[
                                      const Divider(
                                        thickness: 1.0,
                                        height: 1.0,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 4.0,
                                          ),
                                          child: Html(
                                            data: data['description'],
                                            // defaultTextStyle: const TextStyle(
                                            //     fontSize: 13,
                                            //     color: Colors.black45,
                                            //     fontFamily: 'Amazon'),
                                            // padding: const EdgeInsets.all(8.0),
                                            // onLinkTap: (url) {},
                                          ),
                                          // child: Text(
                                          //   data['description'],
                                          //   style: const TextStyle(
                                          //       fontSize: 13,
                                          //       color: Colors.black45,
                                          //       fontFamily: 'DMSans'),
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 2, right: 2, top: 2),
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: colorWhite,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                              border: Border.all(
                                                  width: 1, color: colorBlack)),
                                          child: Obx(() => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        if (quantity.value >=
                                                            1) {
                                                          quantity.value--;
                                                          if (quantity.value ==
                                                              0) {
                                                            // Get.back();
                                                          }
                                                        }
                                                      },
                                                      child: const Text(
                                                        "-",
                                                        style: TextStyle(
                                                            fontSize: 35,
                                                            color: colorBlack),
                                                      )),
                                                  Text(
                                                    quantity.value.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: colorBlack),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        quantity.value++;
                                                      },
                                                      child: const Text(
                                                        "+",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: colorBlack),
                                                      )),
                                                ],
                                              ))),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: InkWell(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 2, right: 2, top: 10),
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  (Color(0xFF113f60)),
                                                  (Color(0xFF113f60))
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(0, 20),
                                                blurRadius: 50,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                          child: const Text(
                                            "Add To Bag",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Amazon'),
                                          ),
                                        ),
                                        onTap: () async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();

                                          preferences.getInt("value");
                                          preferences.getString("name");
                                          preferences.getString("email");
                                          preferences.getString("mobile");
                                          preferences.getString("id");

                                          print(
                                              "user ${preferences.getString("id")}");
                                          print(
                                              "user ${preferences.getString("name")}");
                                          print(
                                              "user ${preferences.getString("email")}");

                                          if (preferences.getString("name") ==
                                              null) {
                                            SqliteDatabase.writeData(
                                                "goto", "ProductDetail");
                                            SqliteDatabase.writeData(
                                                "productid", widget.id);
                                            SqliteDatabase.writeData(
                                                "variant", widget.varient);
                                            Get.toNamed(
                                                Routes.loginSignupScreen);
                                          } else {
                                            var api = ApiClient.AddtoCart(
                                                productid: widget.id,
                                                userid: int.parse(preferences
                                                    .getString("id")!),
                                                qty: quantity.value.toString());
                                            api.then((value) {
                                              if (value['status'] ==
                                                  'success') {
                                                DialogHelper.showFlutterToast(
                                                    strMsg: value['msg']);
                                                //  Get.back();
                                              } else {
                                                DialogHelper.showFlutterToast(
                                                    strMsg: value['msg']);
                                              }
                                            }, onError: (error) {
                                              throw error.toString();
                                            });
                                          }
                                        },
                                      ))
                                    ],
                                  ),
                                  InkWell(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 2, right: 2, top: 10),
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              (Color(0xFF113f60)),
                                              (Color(0xFF113f60))
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 20),
                                            blurRadius: 50,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                      child: const Text(
                                        "Buy Now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Amazon'),
                                      ),
                                    ),
                                    onTap: () async {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();

                                      preferences.getInt("value");
                                      preferences.getString("name");
                                      preferences.getString("email");
                                      preferences.getString("mobile");
                                      preferences.getString("id");

                                      print(
                                          "user ${preferences.getString("name")}, ${widget.id}, ${preferences.getString("id")}");

                                      if (preferences.getString("name") ==
                                              null &&
                                          preferences.getString("name") == "") {
                                        SqliteDatabase.writeData(
                                            "goto", "ProductDetail");
                                        SqliteDatabase.writeData(
                                            "productid", widget.id);
                                        SqliteDatabase.writeData(
                                            "variant", widget.varient);
                                        Get.toNamed(Routes.loginSignupScreen);
                                      } else {
                                        var api = ApiClient.AddtoCart(
                                            productid: widget.id,
                                            userid: int.parse(
                                                preferences.getString(
                                                    StorageKeys.userId)!),
                                            qty: quantity.value.toString());
                                        api.then((value) {
                                          if (value['status'] == 'success') {
                                            DialogHelper.showFlutterToast(
                                                strMsg: value['msg']);
                                            // Get.back();
                                          } else {
                                            DialogHelper.showFlutterToast(
                                                strMsg: value['msg']);
                                          }
                                        }, onError: (error) {
                                          throw error.toString();
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Product Details:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Amazon'),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Brand:",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Amazon'),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${data['brand']}",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Amazon'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Model No:",
                                            style: TextStyle(
                                              fontFamily: 'Amazon',
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${data['model_no']}",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Amazon'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Category:",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Amazon'),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "${data['category_name']}",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Amazon'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Tags:",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Amazon'),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            data['tags'],
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Amazon'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            "Sold By:",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Amazon'),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "doafric",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Amazon'),
                                          ),
                                        ],
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
                                            width: 0.2, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "All Review: ${data['product_review_count']}",
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'Amazon'),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.arrow_right))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  (data['product_reviews'].isNotEmpty)
                                      ? SizedBox(
                                          height: Get.height / 3,
                                          child: ListView.builder(
                                              itemCount: data['product_reviews']
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
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
                                                        children: [
                                                          CircleImageView(
                                                            url: data['product_reviews']
                                                                            [
                                                                            index]
                                                                        ['user']
                                                                    [
                                                                    'profile_image'] ??
                                                                "",
                                                            width: 60,
                                                            height: 60,
                                                          ),
                                                          // SizedBox(
                                                          //   height: 60,
                                                          //   width: 60,
                                                          //   child: ClipOval(
                                                          //     child:
                                                          //         Image.asset(
                                                          //       data['product_reviews'][index]
                                                          //                   [
                                                          //                   'user']
                                                          //               [
                                                          //               'profile_image'] ??
                                                          //           "",
                                                          //       fit:
                                                          //           BoxFit.fill,
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  data['product_reviews'][index]
                                                                              [
                                                                              'user']
                                                                          [
                                                                          'name'] ??
                                                                      "",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black,
                                                                      fontFamily:
                                                                          'Amazon'),
                                                                ),
                                                                const Text(
                                                                  "sept 21, 2022",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      color: Colors
                                                                          .grey,
                                                                      fontFamily:
                                                                          'Amazon'),
                                                                ),

                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                if (data['product_reviews']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'rating'] ==
                                                                    null) ...[
                                                                  Container(),
                                                                ] else ...[
                                                                  Row(
                                                                    children: List
                                                                        .generate(
                                                                      data['product_reviews'][index]['rating']
                                                                              .round() ??
                                                                          '',
                                                                      (index) =>
                                                                          const Icon(
                                                                        Icons
                                                                            .star,
                                                                        size:
                                                                            13,
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                                //  Text("All Review ()"),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Text(
                                                        data['product_reviews']
                                                                    [index]
                                                                ['review'] ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey,
                                                            fontFamily:
                                                                'Amazon'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        )
                                      : const SizedBox.shrink(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 0.2, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height / 4.2,
                                    width: MediaQuery.of(context).size.width,
                                    //color: const Color.fromARGB(255, 187, 221, 100),
                                    child: const Image(
                                      image: AssetImage(
                                        "assets/images/ban4.png",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 0.2, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Center(
                                    child: Text(
                                      "YOU MIGHT ALSO LIKE",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontFamily: 'Amazon'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 0.2, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              1.4),
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        child: Stack(
                                          children: <Widget>[
                                            Container(
                                              width: Get.width,
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 5, 5, 5),
                                              child: Card(
                                                elevation: 2,
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        height: 180,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .white60,
                                                              spreadRadius: 1,
                                                              blurRadius: 1,
                                                              offset: Offset(1,
                                                                  1), // changes position of shadow
                                                            ),
                                                          ],
                                                          color: colorWhite,
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  data4[index][
                                                                          'image_url'] ??
                                                                      ''),
                                                              fit: BoxFit.fill),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        top: 5,
                                                                        left:
                                                                            5),
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5.0),
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color:
                                                                          colorPrimary,
                                                                    ),
                                                                    child: const Text(
                                                                        "4%",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 12.0))),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              2,
                                                                          top:
                                                                              2),
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    radius: 13,
                                                                    child:
                                                                        IconButton(
                                                                      icon:
                                                                          const ImageIcon(
                                                                        AssetImage(
                                                                            ImageFile.heart),
                                                                        color:
                                                                            colorPrimary,
                                                                        size:
                                                                            13,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        SharedPreferences
                                                                            preferences =
                                                                            await SharedPreferences.getInstance();

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
                                                                        if (preferences.getString("name") ==
                                                                            null) {
                                                                          SqliteDatabase.writeData("productid", data4[index]['id']) ??
                                                                              '';

                                                                          Get.toNamed(
                                                                              Routes.loginSignupScreen);
                                                                        } else {
                                                                          var api = ApiClient.addSaveProductApi(
                                                                              product_id: data4[index]['id'],
                                                                              user_id: data4[index]["user_id"]);
                                                                          api.then(
                                                                              (value) {
                                                                            if (value['status'] ==
                                                                                'success') {
                                                                              DialogHelper.showFlutterToast(strMsg: value['msg']);
                                                                              // Get.back();
                                                                            } else {
                                                                              DialogHelper.showFlutterToast(strMsg: value['msg']);
                                                                            }
                                                                          }, onError: (error) {
                                                                            throw error.toString();
                                                                          });
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            data4[index]
                                                                    ["title"] ??
                                                                '',
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'Amazon',
                                                                color:
                                                                    colorBlack),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                "\$ ${data4[index]['regular_price']}",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color:
                                                                        colorPrimary,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                              const SizedBox(
                                                                width: 20,
                                                              ),
                                                              Text(
                                                                "\$ ${data4[index]["sale_price"]}",
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
                                          setState(() {
                                            Get.to(ProductDetails(
                                              id: widget.id,
                                              varient: widget.varient,
                                            ));
                                          });
                                        },
                                      );
                                    },
                                    itemCount: data4.length,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                  )
                                ],
                              ),
                            ),
                          )),
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
              })),
    );
  }
}
