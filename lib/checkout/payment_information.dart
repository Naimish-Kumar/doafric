import 'package:doafric/checkout/order_review.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentInformation extends StatefulWidget {
  const PaymentInformation({super.key});

  @override
  State<PaymentInformation> createState() => _PaymentInformationState();
}

class _PaymentInformationState extends State<PaymentInformation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var categoryName = "Payment Information";
    return Scaffold(
      // appBar: PreferredSize(
      //     preferredSize: Size.fromHeight(50),
      //     child: AppBarScreens(
      //       text: categoryName,
      //     )),

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

      backgroundColor: colorWhite,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 90,
              decoration: BoxDecoration(
                color: colorlightGrey,
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(color: colorlightGrey, width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Enter Your Card Information",
                      style: TextStyle(
                          color: Color.fromARGB(255, 30, 18, 18),
                          fontSize: 12,
                          fontFamily: 'Amazon',
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/visa.png',
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/maestro.png',
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/americanexp.png',
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        Image.asset(
                          'assets/images/paypal.png',
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: TextField(
                    //  controller: _fullnameController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: "Name On Card ",
                      hintStyle: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Amazon',
                          color: Colors.grey.withOpacity(0.6)),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextField(
                    //  controller: _fullnameController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: "Card Number",
                      hintStyle: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Amazon',
                          color: Colors.grey.withOpacity(0.6)),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Get.width / 2 - 10,
                      // color: Colors.pink,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "Expires",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.6),
                                  fontSize: 12,
                                  fontFamily: 'Amazon'),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: Get.width / 2 - 90,
                            child: TextField(
                              //  controller: _fullnameController,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: "MMYY",
                                hintStyle: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Amazon',
                                    color: Colors.grey.withOpacity(0.6)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    SizedBox(
                      width: Get.width / 2 - 20,
                      // color: Colors.black45,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "CVV",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.6),
                                  fontSize: 12,
                                  fontFamily: 'Amazon'),
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          SizedBox(
                            width: Get.width / 2 - 100,
                            child: TextField(
                              //  controller: _fullnameController,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: "CVV No",
                                hintStyle: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Amazon',
                                    color: Colors.grey.withOpacity(0.6)),
                              ),
                            ),
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
                      bottom: BorderSide(width: 0.2, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Get.off(const OrderReview());
              },
              child:
                  //  Container(
                  //   alignment: Alignment.center,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //     color: colorPrimary,
                  //     borderRadius: BorderRadius.circular(8),
                  //     boxShadow: const [
                  //       BoxShadow(
                  //         offset: Offset(0, 10),
                  //         blurRadius: 50,
                  //         color: Colors.white,
                  //       )
                  //     ],
                  //   ),
                  //   child: const Text(
                  //     "Save & Continue",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontFamily: 'Amazon',
                  //     ),
                  //   ),
                  // ),

                  Container(
                alignment: Alignment.center,
                height: 40,
                decoration: const BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 20),
                      blurRadius: 50,
                      color: Colors.white,
                    )
                  ],
                ),
                child: const Text(
                  "Save & Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Amazon',
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
