import 'dart:convert';

import 'package:doafric/apis/api.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/checkout/address_list.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddress extends StatefulWidget {
  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
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

  @override
  Widget build(BuildContext context) {
    var categoryName = "Add Address";
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
        child: Container(
          // decoration: BoxDecoration(
          //   border: Border.all(color: const Color.fromARGB(255, 237, 240, 244)),
          // ),
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FutureBuilder(
                    future: ApiClient.getCountryApi(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        country.addAll(snapshot.data['country_list']);
                        return Column(
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Container(
                                  //   margin: const EdgeInsets.only(
                                  //       left: 4, right: 4, top: 15),
                                  //   alignment: Alignment.center,
                                  //   height: 45,
                                  //   decoration: BoxDecoration(
                                  //     gradient: const LinearGradient(
                                  //         colors: [
                                  //           (Color(0xffe0e0e0)),
                                  //           (Color(0xffe0e0e0))
                                  //         ],
                                  //         begin: Alignment.centerLeft,
                                  //         end: Alignment.centerRight),
                                  //     borderRadius:
                                  //         BorderRadius.circular(1),
                                  //   ),
                                  //   child: const Text(
                                  //     "Shipping Address",
                                  //     style: TextStyle(
                                  //         color: Colors.black,
                                  //         fontFamily: 'Amazon',
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: 13),
                                  //   ),
                                  // ),
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

                                  Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
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
                                                                    width:
                                                                        countryList
                                                                            ? 2
                                                                            : 1),
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
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
                                                                    child: Text(
                                                                  // ignore: unnecessary_null_comparison
                                                                  _countryIndex !=
                                                                          null
                                                                      ? country[_countryIndex]
                                                                              [
                                                                              'name'] +
                                                                          (" ( " +
                                                                              country[_countryIndex]['phonecode'].toString() +
                                                                              ")")
                                                                      : "Select value",
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12.0,
                                                                      fontFamily:
                                                                          'Amazon',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                )),
                                                                const Icon(
                                                                    Icons
                                                                        .expand_more,
                                                                    size: 20.0,
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
                                                                    width:
                                                                        stateList
                                                                            ? 2
                                                                            : 1),
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
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
                                                                    child: Text(
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
                                                                          FontWeight
                                                                              .w400),
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
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Address Line 1 *",
                                                      hintStyle: TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily: 'Amazon',
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
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Address Line 2 (optional)",
                                                      hintStyle: TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily: 'Amazon',
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.6)),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: TextField(
                                                    controller: _zipController,
                                                    cursorColor: Colors.grey,
                                                    decoration: InputDecoration(
                                                      hintText: "Zip Code*",
                                                      hintStyle: TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily: 'Amazon',
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
                                                    decoration: InputDecoration(
                                                      hintText: "Town/City*",
                                                      hintStyle: TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily: 'Amazon',
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
                                                    decoration: InputDecoration(
                                                      hintText: "Email*",
                                                      hintStyle: TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily: 'Amazon',
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
                                                    decoration: InputDecoration(
                                                      hintText: "Phone*",
                                                      hintStyle: TextStyle(
                                                          fontSize: 12.0,
                                                          fontFamily: 'Amazon',
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
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              color: colorPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              // boxShadow: const [
                                              //   BoxShadow(
                                              //     offset: Offset(0, 10),
                                              //     blurRadius: 50,
                                              //     color: Colors.white,
                                              //   )
                                              // ],
                                            ),
                                            child: InkWell(
                                              child: const Text(
                                                "Save & Continue",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Amazon',
                                                ),
                                              ),
                                              onTap: () {
                                                if (isLoading) {
                                                  return;
                                                }
                                                if (_emailController
                                                        .text.isEmpty ||
                                                    _fullnameController
                                                        .text.isEmpty) {
                                                  DialogHelper.showFlutterToast(
                                                      strMsg:
                                                          "Please Fill all fileds");
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
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ],
                        );
                      }
                      return Container();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
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
                        print("jjjj" + state.toString());
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
                        (" ( " + country[index]['phonecode'].toString() + ")")
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
        print(" User name ${user}");
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
        Get.off(AddressList());

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
}
