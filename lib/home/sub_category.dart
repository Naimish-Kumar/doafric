// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/home/product_list.dart';
import 'package:doafric/utils/appbarforall.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/image_file.dart';

class Subcategory extends StatelessWidget {
  int category_id;
  String categoryName;
  Subcategory({required this.category_id, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarScreens(text: categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: ApiClient.getSubCategoryApi(category_id: category_id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    Map map = snapshot.data as Map;
                    List data = map['subcategory']['data'];

                    print(category_id);
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.9),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          child: Stack(
                            children: [
                              Container(
                                width: Get.width,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 30),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    // border: Border.all(
                                    //     color: colorPrimary, width: 2),
                                    boxShadow: [
                                      BoxShadow(color: colorGrey)
                                    ]),
                                child: CachedNetworkImage(
                                  imageUrl: data[index]["image"] ?? '',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15.0)),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
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
                                  ),
                                  placeholder: (context, url) => SizedBox(
                                    width: Get.width,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: Get.width,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      image: DecorationImage(
                                          image:
                                              AssetImage(ImageFile.placeholder),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                    width: Get.width,
                                    height: Get.height / 15,
                                    margin:
                                        const EdgeInsets.fromLTRB(40, 5, 40, 5),
                                    decoration: BoxDecoration(
                                      color: colorPrimary,
                                      borderRadius: BorderRadius.circular(15),
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
                                      child: TextView(
                                        text: data[index]["name"] ?? "",
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w500,
                                        font_size: 15,
                                        fontColor: colorWhite,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyText1!,
                                        softWrap: true,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          onTap: () {
                            Get.to(ProductList(
                              category_id: category_id,
                              sub_category_id: data[index]['id'],
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
      ),
    );
  }
}
