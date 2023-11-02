import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/screens/checkout.dart';
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

  savePref(add1, add2, zip, length, id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("address_line_1", add1);
    preferences.setString("address_line_2", add2);
    preferences.setString("zip", zip);
    preferences.setString("lenght", length);
    preferences.setString("id", id);
    preferences.commit();
    DialogHelper.showFlutterToast(
        // ignore: prefer_interpolation_to_compose_strings
        strMsg: "${"add1 " + add1 + "add2 " + add2}zip " + zip);
    OrderReview();
  }

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
                print("address $map");
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 4, right: 4, top: 30),
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "+  Add A New Address",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                  color: Colors.black, fontSize: 18),
                            ),
                          ),
                          onTap: () {
                            Get.off(const CheckoutScreen());
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Select Address",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 30,),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  savePref(
                                      data[index]['address_line_1'],
                                      data[index]['address_line_2'],
                                      data[index]['zip'],
                                      data[index]['id'].toString(),
                                      data.length.toString());
                                },
                                
                                  child: Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [ 
                                            Image.asset('assets/images/map.png',height: 30,),
                                              
                                            const SizedBox(
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
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                 Row(
                                                  children: [
                                                    Text(
                                                      data[index] ['address_line_2']?? " ",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    
                                                    Text(
                                                      data[index]['zip'],
                                                      style: const TextStyle(
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
                                  
                                
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            return NoDataFoundErrorScreens();
            // return SizedBox
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
