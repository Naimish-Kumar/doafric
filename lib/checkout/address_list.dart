import 'package:doafric/apis/api_client.dart';
import 'package:doafric/checkout/add_address.dart';
import 'package:doafric/checkout/payment_pay.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/screens/orderreview.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/nodatafounderror.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressList extends StatefulWidget {
  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
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

  savePref(
    add1,
    add2,
    zip,
    length,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("address_line_1", add1);
    preferences.setString("address_line_2", add2);
    preferences.setString("zip", zip);
    preferences.setString("lenght", length);

    preferences.commit();
    DialogHelper.showFlutterToast(
        strMsg: "add1 " + add1 + "add2 " + add2 + "zip " + zip);
    OrderReview();
  }

  RxBool selected = false.obs;

  @override
  Widget build(BuildContext context) {
    var categoryName = "Address List";

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
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 237, 240, 244)),
        ),
        child: FutureBuilder(
          future: ApiClient.getAddressListApi(id: _id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                width: Get.width,
                height: Get.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                Map map = snapshot.data as Map;
                List data = map['addresses'];
                print("$data");
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 4, right: 4, top: 30),
                              alignment: Alignment.center,
                              height: 85,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [
                                      (Color(0xffe0e0e0)),
                                      (Color(0xffe0e0e0))
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
                                borderRadius: BorderRadius.circular(1),
                              ),
                              child: const Text(
                                "+  Add A New Address",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                            onTap: () {
                              Get.off(AddAddress());
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Select Address",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: data.length,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    savePref(
                                        data[index]['address_line_1'],
                                        data[index]['address_line_2'],
                                        data[index]['zip'],
                                        data.length.toString());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 237, 240, 244)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15,
                                            top: 5,
                                            left: 8,
                                            right: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                height: 25,
                                                child: Image.asset(
                                                    'assets/images/map.png'),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 25,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data[index]['address_line_1'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      data[index]
                                                          ['address_line_2'],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      data[index]['zip'],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => selected.value == false
                                ? Positioned(
                                    child: ElevatedButton(
                                      child: Text(
                                        "Submit",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: colorWhite,
                                            fontSize: isMobile(context)
                                                ? MyFontSize()
                                                    .mediumTextSizeMobile
                                                : MyFontSize()
                                                    .mediumTextSizeTablet),
                                      ),
                                      onPressed: () {
                                        //  Get.toNamed(Routes.checkoutStepper);
                                        Get.off(PaymentPay());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: colorPrimary,
                                        padding: const EdgeInsets.all(20.0),
                                      ),
                                    ),
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            return NoDataFoundErrorScreens();
            // SizedBox(
            //   width: Get.width,
            //   height: Get.height,
            //   child: Center(
            //     child: Text(
            //       "No data Found",
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //           color: colorBlack,
            //           fontSize: isMobile(context)
            //               ? MyFontSize().mediumTextSizeMobile
            //               : MyFontSize().mediumTextSizeTablet),
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
