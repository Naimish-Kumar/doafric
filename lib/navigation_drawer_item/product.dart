import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/db_helper/sqlite_database.dart';
import 'package:doafric/navigation_drawer_item/filter_screen.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/product_details.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/custom_search_delegate.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/string_file.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Product extends StatefulWidget {
  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var categoryName = "All Product List";
  String _selectedSort = 'popularity';

  @override
  Widget build(BuildContext context) {
    print("user_id ${SqliteDatabase.readData(StorageKeys.userId)}");
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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: colorGrey,
              //   size: 25,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: const ImageIcon(
              AssetImage(ImageFile.sort),
              color: colorGrey,
              //  size: 25,
            ),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Popularity",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Amazon',
                                    color: colorBlack,
                                    fontWeight: FontWeight.w800),
                              ),
                              Radio<String>(
                                value: 'popularity',
                                groupValue: _selectedSort,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSort = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Price- Low to High",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Amazon',
                                    color: colorBlack,
                                    fontWeight: FontWeight.w800),
                              ),
                              Radio<String>(
                                value: 'lowtohigh',
                                groupValue: _selectedSort,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSort = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Price- High to Low",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Amazon',
                                    color: colorBlack,
                                    fontWeight: FontWeight.w800),
                              ),
                              Radio<String>(
                                value: 'hightolow',
                                groupValue: _selectedSort,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSort = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Newest First",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Amazon',
                                    color: colorBlack,
                                    fontWeight: FontWeight.w800),
                              ),
                              Radio<String>(
                                value: 'newestfirst',
                                groupValue: _selectedSort,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedSort = value!;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            },
          ),
          IconButton(
            icon: const ImageIcon(
              AssetImage(ImageFile.filter),
              color: colorGrey,
              size: 25,
            ),
            onPressed: () {
              Get.to(FilterScreen());
            },
          ),
        ],
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: ApiClient.getAllProductListApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Map map = snapshot.data as Map;
                  List data = map['product_list']['data'];
                  print("product_list ${data}");
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 1.7),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white60,
                                // borderRadius:
                                //     BorderRadius.all(Radius.circular(5.0)),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.0),
                                    topLeft: Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white60,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        1, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              width: Get.width,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 10),
                              child: Card(
                                elevation: 2,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 150,
                                        decoration: BoxDecoration(
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
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(top: 5,left: 5),
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
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 5,top: 5),
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    radius: 15,
                                                    child: IconButton(
                                                      icon: const ImageIcon(
                                                        AssetImage(
                                                            ImageFile.heart),
                                                        color: colorPrimary,
                                                        size: 12,
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
                                                          var api = ApiClient.addSaveProductApi(
                                                              product_id:
                                                                  data[index]
                                                                      ['id'],
                                                              user_id: int.parse(
                                                                  preferences.getString(
                                                                      StorageKeys
                                                                          .userId)!));
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
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            data[index]["title"] ?? '',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: colorBlack),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                "\$ ${data[index]['regular_price']}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: colorPrimary,
                                                    fontSize: 13),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "\$ ${data[index]["sale_price"]}",
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13,
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
