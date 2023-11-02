import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/db_helper/sqlite_database.dart';
import 'package:doafric/home/categories/sub_category_screen.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/product_details.dart';
import 'package:doafric/utils/circle_image_view.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _id = 0;
  @override
  void initState() 
  {
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

  final buttonCarouselController = CarouselController();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: ApiClient.getHomeApi(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List advertisemetList = [],
                      categoryList = [],
                      brand = [],
                      bestsellingproducts = [],
                      bestsellingbrands = [];
                  advertisemetList.addAll(snapshot.data['advertisement']);
                  categoryList.addAll(snapshot.data['selected_category']);
                  bestsellingbrands.addAll(snapshot.data['offers']);
                  brand.addAll(snapshot.data['brands']['data']);
                  bestsellingproducts
                      .addAll(snapshot.data['best_selling_product']['data']);
                  // Map map = snapshot.data as Map;
                  // List data = map['best_selling_product']['data'];
                  print(brand);
                  print('bestsellingproducts  $bestsellingproducts');

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // const SizedBox(
                      //   height: 10,
                      // ),
                     
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image(
                                  image: AssetImage(
                                    "assets/images/voucher.png",
                                  ),
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.fill),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "10% of on first order",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontFamily: 'Amazon'),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image(
                                  image: AssetImage(
                                    "assets/images/ship.png",
                                  ),
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.fill),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Free Sheeping on 35+",
                                  style: TextStyle(
                                      fontFamily: 'Amazon',
                                      fontSize: 10,
                                      color: Colors.grey))
                            ],
                          ),
                          Column(
                            children: [
                              Image(
                                  image: AssetImage(
                                    "assets/images/calendar.png",
                                  ),
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill),
                              SizedBox(
                                height: 5,
                              ),
                              Text("7 Days to Return",
                                  style: TextStyle(
                                      fontFamily: 'Amazon',
                                      fontSize: 10,
                                      color: Colors.grey))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Text(
                          "SHOP BY CATEGORIES",
                          style: TextStyle(fontSize: 16, fontFamily: 'Amazon',fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: SizedBox(
                          height: Get.height / 6,
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: colorPrimary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50.0)),
                                          border: Border.all(
                                              color: colorBlack, width: 1),
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
                                        child: CircleImageView(
                                          url: categoryList[index]['image'] ??
                                              '',
                                          width: 73,
                                          height: 73,
                                        ),
                                      ),

                                      // Center(
                                      //   child: Text(
                                      //     categoryList[index]['name'] ?? '',
                                      //     style: TextStyle(
                                      //         fontFamily: 'Amazon',
                                      //         fontSize: 12,
                                      //         color: Colors.grey),
                                      //   ),
                                      // ),

                                      const SizedBox(
                                        height: 5,
                                      ),
                                      FittedBox(
                                        child: SizedBox(
                                          width: 70,
                                          child: Center(
                                            child: Text(
                                              categoryList[index]['name'] ?? '',
                                              style: const TextStyle(
                                                  fontFamily: 'Amazon',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color: colorBlack),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Get.to(SubcategoryScreen(
                                      categoryList: categoryList[index]
                                              ['sub_category'] ??
                                          '',
                                      categoryName:
                                          categoryList[index]['name'] ?? ''));
                                },
                              );
                            },
                            shrinkWrap: true,
                            itemCount: categoryList.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                          child: Text(
                        "DEALS & OFFERS",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Amazon',
                          fontWeight: FontWeight.w500
                        ),
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: Get.height / 4.5,
                        width: MediaQuery.of(context).size.width,
                        child: CarouselSlider(
                          items: bestsellingbrands
                              .map((item) => CachedNetworkImage(
                                    imageUrl: item['banner'] ?? '',
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: Get.width,
                                      height: Get.height / 3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    placeholder: (context, url) => const SizedBox(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      height: Get.height / 3,
                                      width: Get.width,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(ImageFile.bannerad
                                                //ImageFile.placeholder
                                                ),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                  ) /*, fit: BoxFit.fill,width: Get.width)*/)
                              .toList(),
                          carouselController: buttonCarouselController,
                          options: CarouselOptions(
                            height: Get.height / 3.5,
                            enlargeCenterPage: false,
                            viewportFraction: 2.0,
                            autoPlay: false,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                          child: Text(
                        "All Brands",
                        style: TextStyle(fontSize: 16, fontFamily: 'Amazon',fontWeight: FontWeight.w500),
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: SizedBox(
                          height: Get.height / 6,
                          child: ListView.builder(
                            
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: colorPrimary,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(50.0)),
                                          border: Border.all(
                                              color: colorBlack, width: 1),
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
                                        child: CircleImageView(
                                          url: brand[index]['image'],
                                          width: 73,
                                          height: 73,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          bestsellingbrands[index]
                                                  ['offer_name'] ??
                                              '',
                                          style: const TextStyle(
                                              fontFamily: 'Amazon',
                                              fontSize: 12,
                                              color: Colors.grey),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Get.to(
                                    SubcategoryScreen(
                                        categoryList: categoryList[index]
                                                ['sub_category'] ??
                                            '',
                                        categoryName:
                                            categoryList[index]['name'] ?? ''),
                                  );
                                },
                              );
                            },
                            shrinkWrap: true,
                            itemCount: brand.length>7?7:brand.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),

                      const Center(
                          child: Text(
                        "Best Selling Product",
                        style: TextStyle(fontSize: 16, fontFamily: 'Amazon',fontWeight: FontWeight.w500),
                      )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: SizedBox(
                          height: Get.height /3.2,
                          child: ListView.builder(
                            shrinkWrap: false,
                            itemCount: brand.length>15?15:brand.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: Get.width / 2.8,
                                      decoration: const BoxDecoration(
                                        color: Colors.white60,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white60,
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: Offset(1,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.fromLTRB(2, 2, 2, 10),
                                      child: Card(
                                        elevation: 2,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  color: colorWhite,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  5.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  5.0)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          bestsellingproducts[
                                                                      index][
                                                                  'image_url'] ??
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets.only(top: 5,left: 5),
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    5.0),
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  colorPrimary,
                                                            ),
                                                            child: const Text("4%",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12.0))),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 5,right: 5),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            radius: 13,
                                                            child: IconButton(
                                                              icon: const ImageIcon(
                                                                AssetImage(
                                                                    ImageFile
                                                                        .heart),
                                                                color:
                                                                    colorPrimary,
                                                                size: 15,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                SharedPreferences
                                                                    preferences =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                        
                                                                preferences
                                                                    .getInt(
                                                                        "value");
                                                                preferences
                                                                    .getString(
                                                                        "name");
                                                                preferences
                                                                    .getString(
                                                                        "email");
                                                                preferences
                                                                    .getString(
                                                                        "mobile");
                                                                preferences
                                                                    .getString(
                                                                        "id");
                                                        
                                                                print(
                                                                    "user ${preferences.getString("id")}");
                                                                if (preferences
                                                                        .getString(
                                                                            "name") ==
                                                                    null) {
                                                                  SqliteDatabase.writeData(
                                                                          "productid",
                                                                          bestsellingproducts[index]
                                                                              [
                                                                              'id']) ??
                                                                      '';
                                                        
                                                                  Get.toNamed(Routes
                                                                      .loginSignupScreen);
                                                                } else {
                                                                  var api = ApiClient.addSaveProductApi(
                                                                      product_id:
                                                                          bestsellingproducts[index]
                                                                              [
                                                                              'id'],
                                                                      user_id:
                                                                          _id);
                                                                  api.then(
                                                                      (value) {
                                                                    if (value[
                                                                            'status'] ==
                                                                        'success') {
                                                                      DialogHelper
                                                                          .showFlutterToast(
                                                                              strMsg:
                                                                                  value['msg']);
                                                                       Get.back();
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
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                            // Padding(
                                            //   padding:
                                            //        EdgeInsets.all(3.0),
                                            //   child: Column(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.start,
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.center,
                                            //     children: [
                                            //       FittedBox(
                                            //         child: SizedBox(
                                            //           width: 80,
                                                      
                                            //           child: Text(
                                            //             bestsellingproducts[
                                            //                         index]
                                            //                     ["title"] ??
                                            //                 '',
                                            //             style: const TextStyle(
                                            //                 fontSize: 13,
                                            //                 fontFamily:
                                            //                     'Amazon',
                                            //                 color: colorBlack),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       SizedBox(
                                            //         height: 2,
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  FittedBox(
                                                    child: SizedBox(
                                                      height: 40,
                                                      width: 80,
                                                      child: Text(
                                                        bestsellingproducts[
                                                                    index]
                                                                ["title"] ??
                                                            '',
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Amazon',
                                                            color: colorBlack,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                  ),
                                                  // const SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.start,
                                                  //   crossAxisAlignment:
                                                  //       CrossAxisAlignment
                                                  //           .start,
                                                  //   children: <Widget>[
                                                      // FittedBox(
                                                      //   child: SizedBox(
                                                      //     width: 80,
                                                      //     child: Text(
                                                      //       "\$ ${bestsellingproducts[index]['sale_price']}",
                                                      //       style: const TextStyle(
                                                      //           fontFamily:
                                                      //               'Amazon',
                                                      //           fontWeight:
                                                      //               FontWeight
                                                      //                   .bold,
                                                      //           color:
                                                      //               colorPrimary,
                                                      //           fontSize: 11),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      // const SizedBox(
                                                      //   width: 20,
                                                      // ),
                                                      // Text(
                                                      //   "\$ ${bestsellingproducts[index]["regular_price"]}",
                                                      //   style: const TextStyle(
                                                      //       color: Colors.grey,
                                                      //       fontSize: 10,
                                                      //       fontFamily:
                                                      //           'Amazon',
                                                      //       decoration:
                                                      //           TextDecoration
                                                      //               .lineThrough),
                                                      // ),
                                                  //   ],
                                                  // ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  // FittedBox(
                                                  //   child: SizedBox(
                                                  //     width: 80,
                                                  //     child: Text(
                                                  //       "\$ ${bestsellingproducts[index]["regular_price"]}",
                                                  //       style: const TextStyle(
                                                  //           color: Colors.grey,
                                                  //           fontSize: 10,
                                                  //           fontFamily:
                                                  //               'Amazon',
                                                  //           decoration:
                                                  //               TextDecoration
                                                  //                   .lineThrough),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),

                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                FittedBox(
                                                  child: SizedBox(
                                                    width: 80,
                                                    child: Text(
                                                      "\$ ${bestsellingproducts[index]['sale_price']}",
                                                      style: const TextStyle(
                                                          fontFamily: 'Amazon',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: colorPrimary,
                                                          fontSize: 11),
                                                    ),
                                                  ),
                                                ),
                                                FittedBox(
                                                  child: SizedBox(
                                                    width: 80,
                                                    child: Text(
                                                      "\$ ${bestsellingproducts[index]["regular_price"]}",
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10,
                                                          fontFamily: 'Amazon',
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Get.to(ProductDetails(
                                    id: bestsellingproducts[index]['id'],
                                    varient: bestsellingproducts[index]
                                            ['product_variant'] ??
                                        [],
                                  ));
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      // GridView.builder(
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     mainAxisSpacing: 10,
                      //     crossAxisSpacing: 10,
                      //     crossAxisCount: 2,
                      //     childAspectRatio: MediaQuery.of(context).size.width /
                      //         (MediaQuery.of(context).size.height / 1.4),
                      //   ),
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return InkWell(
                      //       child: Stack(
                      //         children: <Widget>[
                      //           Container(
                      //             width: Get.width,
                      //             margin:
                      //                 const EdgeInsets.fromLTRB(5, 5, 5, 20),
                      //             child: Card(
                      //               elevation: 2,
                      //               color: Colors.white,
                      //               child: Column(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.start,
                      //                 children: [
                      //                   Container(
                      //                       height: 160,
                      //                       decoration: BoxDecoration(
                      //                         color: colorWhite,
                      //                         image: DecorationImage(
                      //                             image: NetworkImage(
                      //                                 bestsellingproducts[index]
                      //                                         ['image_url'] ??
                      //                                     ''),
                      //                             fit: BoxFit.fill),
                      //                       ),
                      //                       child: Column(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.start,
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.start,
                      //                         children: [
                      //                           Row(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment
                      //                                     .spaceBetween,
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               Container(
                      //                                   padding:
                      //                                       const EdgeInsets
                      //                                           .all(12.0),
                      //                                   decoration:
                      //                                       const BoxDecoration(
                      //                                     shape:
                      //                                         BoxShape.circle,
                      //                                     color: colorPrimary,
                      //                                   ),
                      //                                   child: const Text("4%",
                      //                                       style: TextStyle(
                      //                                           color: Colors
                      //                                               .white,
                      //                                           fontSize:
                      //                                               12.0))),
                      //                               CircleAvatar(
                      //                                 backgroundColor:
                      //                                     Colors.white,
                      //                                 //s radius: 20,
                      //                                 child: IconButton(
                      //                                   icon: const ImageIcon(
                      //                                     AssetImage(
                      //                                         ImageFile.heart),
                      //                                     color: colorPrimary,
                      //                                     size: 15,
                      //                                   ),
                      //                                   onPressed: () async {
                      //                                     SharedPreferences
                      //                                         preferences =
                      //                                         await SharedPreferences
                      //                                             .getInstance();
                      //
                      //                                     preferences
                      //                                         .getInt("value");
                      //                                     preferences.getString(
                      //                                         "name");
                      //                                     preferences.getString(
                      //                                         "email");
                      //                                     preferences.getString(
                      //                                         "mobile");
                      //                                     preferences
                      //                                         .getString("id");
                      //
                      //                                     print(
                      //                                         "user ${preferences.getString("id")}");
                      //                                     if (preferences
                      //                                             .getString(
                      //                                                 "name") ==
                      //                                         null) {
                      //                                       SqliteDatabase.writeData(
                      //                                               "productid",
                      //                                               bestsellingproducts[
                      //                                                       index]
                      //                                                   [
                      //                                                   'id']) ??
                      //                                           '';
                      //
                      //                                       Get.toNamed(Routes
                      //                                           .loginSignupScreen);
                      //                                     } else {
                      //                                       var api = ApiClient
                      //                                           .addSaveProductApi(
                      //                                               product_id:
                      //                                                   bestsellingproducts[index]
                      //                                                       [
                      //                                                       'id'],
                      //                                               user_id:
                      //                                                   _id);
                      //                                       api.then((value) {
                      //                                         if (value[
                      //                                                 'status'] ==
                      //                                             'success') {
                      //                                           DialogHelper.showFlutterToast(
                      //                                               strMsg: value[
                      //                                                   'msg']);
                      //                                           // Get.back();
                      //                                         } else {
                      //                                           DialogHelper.showFlutterToast(
                      //                                               strMsg: value[
                      //                                                   'msg']);
                      //                                         }
                      //                                       }, onError:
                      //                                           (error) {
                      //                                         throw error
                      //                                             .toString();
                      //                                       });
                      //                                     }
                      //                                   },
                      //                                 ),
                      //                               ),
                      //                             ],
                      //                           )
                      //                         ],
                      //                       )),
                      //                   Padding(
                      //                     padding: const EdgeInsets.all(5.0),
                      //                     child: Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.start,
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       children: [
                      //                         Text(
                      //                           bestsellingproducts[index]
                      //                                   ["title"] ??
                      //                               '',
                      //                           style: const TextStyle(
                      //                               fontSize: 13,
                      //                               fontFamily: 'Amazon',
                      //                               color: colorBlack),
                      //                         ),
                      //                         const SizedBox(
                      //                           height: 20,
                      //                         ),
                      //                         Row(
                      //                           mainAxisAlignment:
                      //                               MainAxisAlignment.start,
                      //                           crossAxisAlignment:
                      //                               CrossAxisAlignment.start,
                      //                           children: <Widget>[
                      //                             Text(
                      //                               "\$ ${bestsellingproducts[index]['sale_price']}",
                      //                               style: const TextStyle(
                      //                                   fontFamily: 'Amazon',
                      //                                   fontWeight:
                      //                                       FontWeight.bold,
                      //                                   color: colorPrimary,
                      //                                   fontSize: 11),
                      //                             ),
                      //                             const SizedBox(
                      //                               width: 20,
                      //                             ),
                      //                             Text(
                      //                               "\$ ${bestsellingproducts[index]["regular_price"]}",
                      //                               style: const TextStyle(
                      //                                   color: Colors.grey,
                      //                                   fontSize: 10,
                      //                                   fontFamily: 'Amazon',
                      //                                   decoration:
                      //                                       TextDecoration
                      //                                           .lineThrough),
                      //                             )
                      //                           ],
                      //                         )
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       onTap: () {
                      //         Get.to(ProductDetails(
                      //           id: bestsellingproducts[index]['id'],
                      //           varient: bestsellingproducts[index]
                      //                   ['product_variant'] ??
                      //               [],
                      //         ));
                      //       },
                      //     );
                      //   },
                      //   itemCount: bestsellingproducts.length,
                      //   shrinkWrap: true,
                      //   physics: const BouncingScrollPhysics(),
                      // )
                    ],
                  );
                } else if (snapshot.hasError) {
                  DialogHelper.showFlutterToast(
                      strMsg: snapshot.error.toString());
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
