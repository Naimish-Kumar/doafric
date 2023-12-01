import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/nodatafounderror.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apis/api_client.dart';
import 'myorderlistdetails.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
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
    print("Hello$_id");
    preferences.commit();
  }

  @override
  Widget build(BuildContext context) {
    var categoryName = "My Order";
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
        title: Text(
          categoryName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: isMobile(context)
                ? MyFontSize().normalTextSizeMobile
                : MyFontSize().normalTextSizeTablet,
            color: colorPrimary,
          ),
          softWrap: true,
        ),
      ),
      body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: FutureBuilder(
                future: ApiClient.getorderlist(id: _id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map map = snapshot.data as Map;
                    final data = map['data']['data'] as List;
                    print('aaaaaaa $map');
                    data.isEmpty
                        ? NoDataFoundErrorScreens()
                        : SizedBox(
                            width: Get.width,
                            height: Get.height,
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 237, 240, 244)),
                                ),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: data.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              Get.to(MyOrderListDetails(
                                                id: data[index]['id'] ?? '',
                                              ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              237,
                                                              240,
                                                              244)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 15,
                                                          top: 5,
                                                          left: 8,
                                                          right: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // const SizedBox(
                                                      //   width: 25,
                                                      // ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Order Id:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                data[index][
                                                                    'order_number'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Total Order Price:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                data[index][
                                                                    'order_price'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Payment Type:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                data[index][
                                                                    'payment_type'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Payment Status:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                data[index][
                                                                    'payment_status'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Order Date:",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                data[index][
                                                                    'order_at'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        'Amazon',
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      if (data[index][
                                                              'order_status'] ==
                                                          'pending') ...[
                                                        Text(
                                                          data[index]
                                                              ['order_status'],
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'Amazon',
                                                                  color: Colors
                                                                      .amber),
                                                        )
                                                      ] else if (data[index][
                                                              'order_status'] ==
                                                          'cancelled') ...[
                                                        Text(
                                                          data[index]
                                                              ['order_status'],
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'Amazon',
                                                                  color: Colors
                                                                      .red),
                                                        )
                                                      ] else ...[
                                                        Text(
                                                          data[index]
                                                              ['order_status'],
                                                          style:
                                                              const TextStyle(
                                                                  fontFamily:
                                                                      'Amazon',
                                                                  color: Colors
                                                                      .green),
                                                        )
                                                      ]
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  }

                  return NoDataFoundErrorScreens();
                }),
          )),
    );
  }
}
