import 'package:cached_network_image/cached_network_image.dart';
import 'package:doafric/apis/api_client.dart';

import 'package:doafric/home/sub_category.dart';
import 'package:doafric/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/image_file.dart';
import '../utils/text_widget.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
        child: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: ApiClient.getCategoryApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    Map map = snapshot.data as Map;
                    List data = map['category']['data'];
                    //   map['category']['data'];
                    //print(data);
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
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(15.0)),
                                    border: Border.all(
                                        color: colorPrimary, width: 2),
                                    boxShadow: const [
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
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(1,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
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
                                    margin: const EdgeInsets.fromLTRB(30, 5, 30, 5),
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
                            Get.to(Subcategory(
                                category_id: data[index]['id'] ?? '',
                                categoryName: data[index]['name'] ?? ''));
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
