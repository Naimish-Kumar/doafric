import 'package:doafric/navigation_drawer_item/cancle_order.dart';
import 'package:doafric/navigation_drawer_item/order_feedback.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apis/api_client.dart';

// ignore: must_be_immutable
class MyOrderListDetails extends StatefulWidget {
  int id;

  MyOrderListDetails({super.key, required this.id});
  @override
  State<MyOrderListDetails> createState() => _MyOrderListDetailsState();
}

class _MyOrderListDetailsState extends State<MyOrderListDetails> {
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
    print(widget.id);

    var categoryName = "Order Details";
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
      ),
      body: SingleChildScrollView(
        child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: FutureBuilder(
                future: ApiClient.getOrderDetails(id: widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      //    print('variant ${snapshot.data}');
                      Map map = snapshot.data as Map;
                      final data = map['data'];
                      print("Hellogvgvgv$data");
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.2, color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      "Orders Detail",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Amazon',
                                          color: Colors.black),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15.0)),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 88, 92, 98)),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Get.to(CancelOrder(
                                            id: data['id'],
                                          ));

                                          //Get.toNamed(Routes.cancelorder);
                                          // AwesomeDialog(
                                          //   context: context,
                                          //   //animType: AnimType.SCALE,
                                          //   dialogType: DialogType.WARNING,
                                          //   animType: AnimType.TOPSLIDE,
                                          //   showCloseIcon: true,

                                          //   title: 'Warning',
                                          //   desc: 'Are You Sure',

                                          //   btnCancelOnPress: () {},
                                          //   btnOkOnPress: () {},
                                          // ).show();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Cancle Orders",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Amazon',
                                                // backgroundColor: Colors.grey,
                                                color: Colors.red),
                                          ),
                                        ),
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
                                          width: 0.2, color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Order Id:",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Amazon',
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            data['order_number'],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Amazon',
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Total Order Price:",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Amazon',
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            data['order_price'],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Amazon',
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Payment Type:",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Amazon',
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            data['payment_type'],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Amazon',
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Payment Status:",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontFamily: 'Amazon',
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            data['payment_status'],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Amazon',
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Order Date:",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            data['order_at'],
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Amazon',
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.2, color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Order Feedback",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 3, 66, 73)),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Get.off(OrderFeedback(
                                                  orderid: data['id'],
                                                ));
                                              },
                                              icon: const Icon(Icons.arrow_right))
                                          // GiveStarReviews(
                                          //   starData: [
                                          //     GiveStarData(
                                          //         text: ' ',
                                          //         onChanged: (rate) {}),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.2, color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Shipping Address",
                                        style: TextStyle(
                                            fontFamily: 'Amazon',
                                            color: colorPrimary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 0.2,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        data['shipping_addess_data']
                                                ['full_name'] ??
                                            "",
                                        style: const TextStyle(
                                            fontFamily: 'Amazon',
                                            color: colorPrimary,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Address1",
                                              style: TextStyle(
                                                  fontFamily: 'Amazon',
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data['shipping_addess_data']
                                                      ['address_line_1'] ??
                                                  "",
                                              style: const TextStyle(
                                                  fontFamily: 'Amazon',
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Address2",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['shipping_addess_data']
                                                    ['address_line_2'] ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "State",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['shipping_addess_data']
                                                    ['state'] ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Post Code",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['shipping_addess_data']
                                                    ['zip'] ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Country",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['shipping_addess_data']
                                                    ['country'] ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Phone Number",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['shipping_addess_data']
                                                    ['mobile_no'] ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 0.2, color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Billing Address",
                                        style: TextStyle(
                                            fontFamily: 'Amazon',
                                            color: colorPrimary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 0.2,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        data['billing_address_data']
                                                ['full_name'] ??
                                            "",
                                        style: const TextStyle(
                                            fontFamily: 'Amazon',
                                            color: colorPrimary,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Address1",
                                              style: TextStyle(
                                                  fontFamily: 'Amazon',
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              data['billing_address_data']
                                                      ['address_line_1'] ??
                                                  "",
                                              style: const TextStyle(
                                                  fontFamily: 'Amazon',
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ]),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Address2",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['billing_address_data']
                                                    ['address_line_2'] ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "State",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['billing_address_data']
                                                    ['state'] ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Post Code",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['billing_address_data']
                                                    ['zip'] ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Country",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['billing_address_data']
                                                    ['country'] ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Phone Number",
                                            style: TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['billing_address_data']
                                                    ['mobile_no'] ??
                                                "",
                                            style: const TextStyle(
                                                fontFamily: 'Amazon',
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return Container();
                })),
      ),
    );
  }
}
