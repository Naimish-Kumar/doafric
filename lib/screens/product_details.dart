import 'package:cached_network_image/cached_network_image.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/screens/product_size.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:givestarreviews/givestarreviews.dart';

// ignore: must_be_immutable
class ProductDetails extends StatelessWidget {
  int id;
  List varient;
  ProductDetails({super.key, required this.id, required this.varient});
  var categoryName = "Product Details";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: varient.isNotEmpty
                  ? ApiClient.getProductDetailsApi(
                      id: id,
                      variant_1: varient[0]['variant_name'] ?? '',
                      variant_2: varient[0]['variant_name_2'] ?? '',
                      variant_3: varient[0]['variant_name_3'] ?? '')
                  : ApiClient.getProductDetailsApi(
                      id: id, variant_1: '', variant_2: '', variant_3: ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    print('variant ${snapshot.data}');
                    Map map = snapshot.data as Map;
                    final data = map['product'];
                    List data1 = map['variant_1'];
                    List data2 = map['variant_2'];
                    List data3 = map['variant_3'];

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
                                  const EdgeInsets.only(left: 25, right: 25),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            // Get.offAndToNamed(
                                            //     Routes.productlist);
                                          },
                                          icon:
                                              const Icon(Icons.arrow_back_ios)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.home_max_outlined))
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 300,
                                    width:
                                        MediaQuery.of(context).size.width - 1,
                                    child: CachedNetworkImage(
                                      imageUrl: data["image_url"] ?? '',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15.0)),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill),
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
                                              image: AssetImage(
                                                  ImageFile.placeholder),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            color: Colors.red,
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "SALE",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontFamily: 'DMSans'),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            color: const Color(0xFf6ecfff),
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "FEATURES",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontFamily: 'DMSans'),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Container(
                                            color: const Color.fromARGB(
                                                255, 54, 244, 92),
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                "NEW",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontFamily: 'DMSans'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.favorite_outlined))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Category:${data['category_name']}",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                        fontFamily: 'DMSans'),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    data['title'],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "\$${data['regular_price']}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: colorPrimary,
                                              fontFamily: 'DMSans'),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("\$${data['sale_price']}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black45,
                                                  decoration: TextDecoration
                                                      .lineThrough))),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        color: colorPrimary,
                                        child: const Text(
                                          "78%",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: colorWhite,
                                              fontFamily: 'DMSans'),
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
                                            width: 0.2, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Product Details",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: 'DMSans'),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon:
                                              const Icon(Icons.arrow_drop_down))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ID",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: 'DMSans'),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      //Text(data['id']),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Tags:",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: 'DMSans'),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        data['tags'],
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    data['description'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                        fontFamily: 'DMSans'),
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
                                  map['product_variants'] != null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Select Color, Size & Quality",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'DMSans'),
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              onPressed: () {
                                                {
                                                  Get.to(ProductSize1(
                                                    id: data['id'] ?? '',
                                                    product: data,
                                                    variant1: data1,
                                                    variant2: data2,
                                                    variant3: data3,
                                                  ));
                                                }
                                              },
                                            )
                                          ],
                                        )
                                      : const SizedBox.shrink(),
                                  map['product_variants'] != null
                                      ? Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 0.2,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "All Review: ${data['product_review_count']}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: 'DMSans'),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.arrow_right))
                                    ],
                                  ),
                                  GiveStarReviews(
                                    starData: [
                                      GiveStarData(
                                          text: ' 4.9', onChanged: (rate) {}),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/cat1.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            "All Review (\$100)",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'DMSans'),
                                          ),
                                          const Text(
                                            "sept 21, 2022",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey,
                                                fontFamily: 'DMSans'),
                                          ),

                                          const SizedBox(
                                            height: 5,
                                          ),
                                          GiveStarReviews(
                                            starData: [
                                              GiveStarData(
                                                  onChanged: (rate) {},
                                                  text: ''),
                                            ],
                                          ),
                                          //  Text("All Review (\$100)"),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 2, right: 2, top: 30),
                                    alignment: Alignment.center,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      // ignore: prefer_const_constructors
                                      gradient: LinearGradient(
                                          colors: const [
                                            (Color(0xFF113f60)),
                                            (Color(0xFF113f60))
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight),
                                      borderRadius: BorderRadius.circular(1),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0, 20),
                                          blurRadius: 50,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                    child: const Text(
                                      "Add To Bag",
                                      style:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
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
