// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:doafric/apis/api.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/screens/button_continue_cancel.dart';
import 'package:doafric/screens/orderreview.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/nodatafounderror.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _mobilenoController = TextEditingController();
  final TextEditingController _addressline1Controller = TextEditingController();
  final TextEditingController _addressline2Controller = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _towncityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;
  ScaffoldMessengerState? scaffoldMessenger;
  bool countryList = false, stateList = false;
  int _countryIndex = 0,
      countryId = 0,
      stateID = 0,
      _stateIndex = 0,
      backStatus = 1,
      continueStatus = 1,
      connectionStatus = 0;
  List country = [];
  List state = [];
  bool viewOne = true, viewTwo = false, viewThree = false;
  String countryCode = "", stateCode = "";
  int _id = 0, lenght = 0;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _id = int.parse(preferences.getString('id').toString());
      lenght = int.parse(preferences.getString('lenght').toString());
    });
    print("Hello$_id");

    preferences.commit();
  }

  saveAddress(add1, add2, zip, length, id, userid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("address_line_1", add1);
    preferences.setString("address_line_2", add2);
    preferences.setString("zip", zip);
    preferences.setString("lenght", length);

    preferences.commit();
    DialogHelper.showFlutterToast(
        strMsg: "${"add1 " +
            add1 +
            "add2 " +
            add2 +
            "zip " +
            zip +
            "id" +
            id}user_id" +
            userid);
    const OrderReview();
  }

  addressContinue() async {
    if (isLoading) {
      return;
    }
    if (_emailController.text.isEmpty || _fullnameController.text.isEmpty) {
      DialogHelper.showFlutterToast(strMsg: "Please Fill all fileds");
      return;
    }
    submitaddress(
      _fullnameController.text,
      _mobilenoController.text,
      _addressline1Controller.text,
      _addressline2Controller.text,
      countryCode,
      stateID.toString(),
      _zipController.text,
      _emailController.text,
    );
    setState(() {
      isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: appBar(context),
      // (lenght>0)?false:
      body: SingleChildScrollView(
          child: Column(
        children: [
          Visibility(
            visible: viewOne,
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 237, 240, 244)),
                ),
                child: FutureBuilder(
                    future: ApiClient.getCountryApi(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        country.addAll(snapshot.data['country_list']);
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 4, right: 4, top: 15),
                                      alignment: Alignment.center,
                                      height: 45,
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
                                        "Shipping Address",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Amazon',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: TextField(
                                        controller: _fullnameController,
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                          hintText: "Full Name",
                                          hintStyle: TextStyle(
                                              fontSize: 12.0,
                                              fontFamily: 'Amazon',
                                              color:
                                                  Colors.grey.withOpacity(0.6)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              country.isNotEmpty
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 8,
                                                              left: 0,
                                                              right: 0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          InkWell(
                                                            onTap: onCountryTap,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  bottom: BorderSide(
                                                                      color: countryList
                                                                          ? Colors
                                                                              .blue
                                                                          : colorlightGrey,
                                                                      width: countryList
                                                                          ? 2
                                                                          : 1),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0),
                                                              height: 40.0,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                      child:
                                                                          Text(
                                                                    // ignore: unnecessary_null_comparison
                                                                    _countryIndex !=
                                                                            null
                                                                        ? country[_countryIndex]['name'] +
                                                                            (" ( ${country[_countryIndex]['phonecode']})")
                                                                        : "Select value",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            12.0,
                                                                        fontFamily:
                                                                            'Amazon',
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  )),
                                                                  const Icon(
                                                                      Icons
                                                                          .expand_more,
                                                                      size:
                                                                          20.0,
                                                                      color: Color(
                                                                          0XFFbbbbbb)),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          countryList
                                                              ? _buildCountryList()
                                                              : Container(),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : const Text("l"),
                                              state.isNotEmpty
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 8,
                                                              left: 0,
                                                              right: 0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          InkWell(
                                                            onTap: onStateTap,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  bottom: BorderSide(
                                                                      color: stateList
                                                                          ? Colors
                                                                              .blue
                                                                          : colorlightGrey,
                                                                      width: stateList
                                                                          ? 2
                                                                          : 1),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0),
                                                              height: 40.0,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                      child:
                                                                          Text(
                                                                    // ignore: unnecessary_null_comparison
                                                                    _stateIndex !=
                                                                            null
                                                                        ? state[_stateIndex]
                                                                            [
                                                                            'name']
                                                                        : "Select value",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            14.0,
                                                                        fontFamily:
                                                                            'Amazon',
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  )),
                                                                  const Icon(
                                                                    Icons
                                                                        .expand_more,
                                                                    size: 20.0,
                                                                    color: Color(
                                                                        0XFFbbbbbb),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          stateList
                                                              ? buildStateList()
                                                              : Container(),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ))
                                                  : Container(),
                                              Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2),
                                                      color: Colors.white,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: TextField(
                                                      controller:
                                                          _addressline1Controller,
                                                      cursorColor: Colors.grey,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Address Line 1 *",
                                                        hintStyle: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Amazon',
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.6)),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: TextField(
                                                      controller:
                                                          _addressline2Controller,
                                                      cursorColor: Colors.grey,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Address Line 2 (optional)",
                                                        hintStyle: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Amazon',
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.6)),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: TextField(
                                                      controller:
                                                          _zipController,
                                                      cursorColor: Colors.grey,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Zip Code*",
                                                        hintStyle: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Amazon',
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.6)),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: TextField(
                                                      controller:
                                                          _towncityController,
                                                      cursorColor: Colors.grey,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Town/City*",
                                                        hintStyle: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Amazon',
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.6)),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: TextField(
                                                      controller:
                                                          _emailController,
                                                      cursorColor: Colors.grey,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Email*",
                                                        hintStyle: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Amazon',
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.6)),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    child: TextField(
                                                      controller:
                                                          _mobilenoController,
                                                      cursorColor: Colors.grey,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "Phone*",
                                                        hintStyle: TextStyle(
                                                            fontSize: 12.0,
                                                            fontFamily:
                                                                'Amazon',
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.6)),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {},
                                          //   child: Container(
                                          //     alignment: Alignment.center,
                                          //     height: 35,
                                          //     decoration: BoxDecoration(
                                          //       gradient: const LinearGradient(
                                          //           colors: [
                                          //             (Color(0xFF113f60)),
                                          //             (Color(0xFF113f60))
                                          //           ],
                                          //           begin: Alignment.centerLeft,
                                          //           end: Alignment.centerRight),
                                          //       borderRadius:
                                          //           BorderRadius.circular(1),
                                          //       boxShadow: const [
                                          //         BoxShadow(
                                          //           offset: Offset(0, 10),
                                          //           blurRadius: 50,
                                          //           color: Colors.white,
                                          //         )
                                          //       ],
                                          //     ),
                                          //     child: InkWell(
                                          //       child: const Text(
                                          //         "Save & Continue",
                                          //         style: TextStyle(
                                          //           color: Colors.white,
                                          //           fontFamily: 'Amazon',
                                          //         ),
                                          //       ),
                                          //       onTap: () {
                                          //         if (isLoading) {
                                          //           return;
                                          //         }
                                          //         if (_emailController
                                          //                 .text.isEmpty ||
                                          //             _fullnameController
                                          //                 .text.isEmpty) {
                                          //           DialogHelper.showFlutterToast(
                                          //               strMsg:
                                          //                   "Please Fill all fileds");
                                          //           return;
                                          //         }
                                          //         submitaddress(
                                          //           _fullnameController.text,
                                          //           _mobilenoController.text,
                                          //           _addressline1Controller
                                          //               .text,
                                          //           _addressline2Controller
                                          //               .text,
                                          //           countryCode,
                                          //           stateID.toString(),
                                          //           _zipController.text,
                                          //           _emailController.text,
                                          //         );
                                          //         setState(() {
                                          //           isLoading = true;
                                          //         });
                                          //       },
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        );
                      }
                      return Container();
                    })),
          ),
          Visibility(
            visible: viewTwo,
            child: SingleChildScrollView(
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 237, 240, 244)),
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
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 15, right: 15),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      viewOne = false;
                                      viewTwo = true;
                                      viewThree = false;
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 4, right: 4, top: 20),
                                      alignment: Alignment.center,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            colors: [
                                              (Color(0xffe0e0e0)),
                                              (Color(0xffe0e0e0))
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight),
                                        borderRadius:
                                            BorderRadius.circular(1),
                                      ),
                                      child: const Text(
                                        " Add A New Address",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
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
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            saveAddress(
                                                data[index]['address_line_1'],
                                                data[index]['address_line_2'],
                                                data[index]['zip'],
                                                data.length.toString(),
                                                data[index]['id'].toString(),
                                                data[index]['user_id']
                                                    .toString());
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
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .only(top: 10),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        height: 25,
                                                        child: Image.asset(
                                                            'assets/images/map.png'),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 25,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data[index][
                                                              'address_line_1'],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              data[index][
                                                                  'address_line_2'],
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              data[index]
                                                                  ['zip'],
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                      15,
                                                                  color: Colors
                                                                      .grey),
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
                      // return SizedBox(
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
              ),
            ),
          ),
          Visibility(
            visible: viewThree,
            child: SingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 25,
                    child: const Text(
                      "Payment Method",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontFamily: 'Amazon',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 4, right: 4, top: 10),
                    alignment: Alignment.center,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [(Color(0xffe0e0e0)), (Color(0xffe0e0e0))],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Credit Card",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: 'Amazon',
                          fontWeight: FontWeight.w800),
                    ),
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                              'assets/images/googlepay.png',
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              " Google Pay",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Amazon',
                                  fontWeight: FontWeight.w600),
                            )
                          ]),
                    ),
                  ),
                  InkWell(
                    child: Container(
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
                                'assets/images/cashondelivery.png',
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                "Cash On Delivery",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Amazon',
                                    fontWeight: FontWeight.w600),
                              )
                            ]),
                      ),
                    ),
                    onTap: () {
                      setState(() {});
                    },
                  )
                ],
              ),
            )),
          ),

          // Visibility(
          //   visible: viewThree,
          //   child: SingleChildScrollView(
          //     child: SizedBox(
          //       height: Get.height,
          //       width: Get.width,
          //       child: OrderReview(),
          //     ),
          //   ),
          // )
        ],
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: Button(
          text: "Back",
          press: () => backNavigation(),
          press1: () => continueNavigation(),
          text1: "Continue",
        ),
      ),
    );
  }

  backNavigation() {
    setState(() {
      if (backStatus == 1) {
        viewOne = true;
        viewTwo = false;
        viewThree = false;
        Navigator.of(context).pop();
      } else if (backStatus == 2) {
        viewOne = true;
        viewTwo = false;
        viewThree = false;
        backStatus = 1;
      } else if (backStatus == 3) {
        viewOne = false;
        viewTwo = true;
        viewThree = false;
        backStatus = 2;
      }
    });
  }

  continueNavigation() {
    setState(() {
      if (continueStatus == 1) {
        addressContinue();
        viewOne = false;
        viewTwo = true;
        viewThree = false;
        continueStatus = 2;
        backStatus = 2;
      } else if (continueStatus == 2) {
        viewOne = false;
        viewTwo = false;
        viewThree = true;
        continueStatus = 3;
        backStatus = 3;
      } else if (continueStatus == 3) {
        Get.to(const OrderReview());
      }
    });
  }

  onCountryTap() {
    setState(() {
      countryList = !countryList;
    });
  }

  onCountryChanged(int position) {
    setState(() {
      _countryIndex = position;
      countryList = !countryList;
    });
  }

  Widget _buildCountryList() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colorlightGrey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        margin: const EdgeInsets.only(top: 5.0),
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
            itemCount: country.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onCountryChanged(index);
                  setState(() {
                    countryCode = country[index]['phonecode'].toString();
                    countryId = country[index]['id'];
                    var api = ApiClient.getStateApi(id: countryId);
                    api.then((value) {
                      if (value['status'] == 'success') {
                        state = value["state_list"];
                        print("jjjj$state");
                        const CircularProgressIndicator();
                      } else {
                        DialogHelper.showFlutterToast(strMsg: value['msg']);
                      }
                    }, onError: (error) {
                      throw error.toString();
                    });
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: index == _countryIndex
                          ? Colors.grey[100]
                          : Colors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0))),
                  child: Text(
                    country[index]['name'] +
                        (" ( ${country[index]['phonecode']})")
                            .toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Amazon',
                    ),
                  ),
                ),
              );
            }),
      );

  onStateTap() {
    setState(() {
      stateList = !stateList;
    });
  }

  onStateChanged(int position) {
    setState(() {
      _stateIndex = position;
      stateList = !stateList;
    });
  }

  Widget buildStateList() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colorlightGrey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        margin: const EdgeInsets.only(top: 5.0),
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
            itemCount: state.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    stateID = state[index]['id'];
                  });
                  print(state[index]['id']);
                  onStateChanged(index);
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: index == _stateIndex
                            ? Colors.grey[100]
                            : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0))),
                    child: Text(
                      state[index]['name'].toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Amazon',
                      ),
                    )),
              );
            }),
      );

  submitaddress(name, phone, add1, add2, country, state, zip, email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString("id");
    setState(() {
      isLoading = false;
    });
    print("Calling");
    Map data = {
      'user_id': preferences.getString('id'),
      'full_name': name,
      'mobile_no': phone,
      'address_line_1': add1,
      'address_line_2': add2,
      'country': country,
      'state': state,
      'zip': zip,
      'email': email,
    };
    print(data.toString());
    final response = await http.post(Uri.parse(ADDADDRESS),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      if (res['status'] == 'success') {
        Map<String, dynamic> user = res['data'];
        print(" User name $user");
        // SqliteDatabase.writeData(StorageKeys.userId, user['id']);
        savePref(
            user['name'] ?? '',
            user['email'] ?? '',
            user['address_line_1'] ?? '',
            user['add2'] ?? '',
            user['country'] ?? '',
            user['state'] ?? '',
            user['zip'] ?? '',
            user['mobile'] ?? '');
        setState(() {
          viewOne = false;
          viewTwo = false;
          viewThree = true;
        });
        print(user['add2']);
        print(user['address_line_1']);
      } else if (res['status'] == 'error') {
        DialogHelper.showFlutterToast(strMsg: res['errors']);
      }
    } else {
      DialogHelper.showFlutterToast(strMsg: 'Please Try Again');
    }
  }

  savePref(String name, String email, String add1, String add2, String country,
      String state, String zip, String mobile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("full_name", name);
    preferences.setString("email", email);
    preferences.setString("address_line_1", add1);
    preferences.setString("address_line_2", add2);
    preferences.setString("country", country);
    preferences.setString("state", state);
    preferences.setString("zip", zip);
    preferences.setString("mobile_no", mobile);

    preferences.commit();
  }

  appBar(context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120.0),
      child: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: colorBlack,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Review Order",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Amazon',
              letterSpacing: 0.4),
          overflow: TextOverflow.ellipsis,
        ),
        bottom: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(
            color: Colors.white,
            constraints: const BoxConstraints.expand(height: 85),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        viewOne = true;
                        viewTwo = false;
                        viewThree = false;
                        // (lenght>0)? false:viewOne? something2(): something3();
                      });
                    },
                    child: (viewOne)
                        ? Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                                child: Text(
                              "1",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )),
                          )
                        : const Text("Address",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Colors.blueGrey)),
                  ),
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Divider(
                      color: colorPrimary,
                      height: 5,
                      thickness: 1,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        viewOne = false;
                        viewTwo = true;
                        viewThree = false;
                      });
                    },
                    child: (viewTwo)
                        ? Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                                child: Text(
                              "2",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )),
                          )
                        : const Text("Payment",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black)),
                  ),
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Divider(
                      color: Colors.black,
                      height: 5,
                      thickness: 1,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        viewOne = false;
                        viewTwo = false;
                        viewThree = true;
                      });
                    },
                    child: (viewThree)
                        ? Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                                child: Text(
                              "3",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )),
                          )
                        : const Text("Review",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
