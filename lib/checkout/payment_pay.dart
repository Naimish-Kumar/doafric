import 'package:doafric/checkout/payment_information.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentPay extends StatefulWidget {
  const PaymentPay({super.key});

  @override
  State<PaymentPay> createState() => _PaymentPayState();
}

class _PaymentPayState extends State<PaymentPay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var categoryName = "Payment Type";
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
      backgroundColor: colorWhite,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        height: 50,
                        width: 50,
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
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    InkWell(
                      child: Container(
                        margin:
                            const EdgeInsets.only(left: 4, right: 4, top: 10),
                        alignment: Alignment.centerLeft,
                        height: 45,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                (Color(0xffe0e0e0)),
                                (Color(0xffe0e0e0))
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/visa.png',
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                " Credit Card",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Amazon',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.off(const PaymentInformation());
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4, right: 4, top: 10),
                      alignment: Alignment.centerLeft,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [(Color(0xffe0e0e0)), (Color(0xffe0e0e0))],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/paypal.png',
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                " Pay Pal",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Amazon',
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
