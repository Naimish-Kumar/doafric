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
import 'package:doafric/utils/textform.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _fullnameController = TextEditingController();
  final _mobilenoController = TextEditingController();
  final _addressline1Controller = TextEditingController();
  final _addressline2Controller = TextEditingController();
  final _zipController = TextEditingController();
  final _towncityController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  bool isLoading = false;
  ScaffoldMessengerState? scaffoldMessenger;

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
            Navigator.pop(context);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
          child: Column(
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
              Container(
                alignment: Alignment.center,
                child: TextFormScreen(
                  textEditingController: _fullnameController,
                  hinttext: "Full Name",
                  icon: Icons.account_circle_rounded,
                ),
              ),

              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: TextFormScreen(
                                textEditingController: _addressline1Controller,
                                hinttext: "Address Line 1 *",
                                icon: Icons.location_on_outlined,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.center,
                              child: TextFormScreen(
                                textEditingController: _addressline2Controller,
                                hinttext: "Address Line 2(Optional)",
                                icon: Icons.location_pin,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.center,
                              child: TextFormScreen(
                                keyboardType: TextInputType.number,
                                textEditingController: _zipController,
                                hinttext: "Zip Code *",
                                icon: Icons.location_searching,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.center,
                              child: TextFormScreen(
                                textEditingController: _towncityController,
                                hinttext: "City",
                                icon: Icons.location_city,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.center,
                              child: TextFormScreen(
                                textEditingController: _emailController,
                                hinttext: "Email",
                                icon: Icons.email,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.center,
                              child: TextFormScreen(
                                textEditingController: _mobilenoController,
                                hinttext: "Phone",
                                icon: Icons.phone,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.center,
                              child: TextFormScreen(
                                textEditingController: _countryController,
                                hinttext: "Country",
                                icon: Icons.flag_circle,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.center,
                              child: TextFormScreen(
                                textEditingController: _stateController,
                                hinttext: "State",
                                icon: Icons.location_city,
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
                      onTap: () {
                        if (_emailController.text.isEmpty ||
                            _fullnameController.text.isEmpty) {
                          DialogHelper.showFlutterToast(
                              strMsg: "Please Fill all fileds");
                          return;
                        } else {
                          submitaddress(
                              _fullnameController.text,
                              _mobilenoController.text,
                              _addressline1Controller.text,
                              _addressline2Controller.text,
                              _countryController.text,
                              _stateController.text,
                              _zipController.text,
                              _emailController.text.toString());
                          setState(() {
                            isLoading = true;
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(8),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
        Get.off(const AddressList());

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
