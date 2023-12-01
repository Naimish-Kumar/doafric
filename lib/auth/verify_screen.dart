import 'dart:convert';
import 'package:doafric/apis/api.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/db_helper/sqlite_database.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/product_details.dart';
import 'package:doafric/screens/product_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class VarifyScreen extends StatefulWidget {
  String email;
  VarifyScreen(this.email, {super.key});
  @override
  _VarifyScreenState createState() => _VarifyScreenState();
}

class _VarifyScreenState extends State<VarifyScreen> {
  late ScaffoldMessengerState scaffoldMessenger;

  bool isLoading = false;
  final TextEditingController _varifyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              const Text(
                'Verification',
                style: TextStyle(
                  fontFamily: 'Amazon',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your verification code number",
                style: TextStyle(
                  fontFamily: 'Amazon',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                ),
                alignment: Alignment.center,
                child: TextFormField(
                    controller: _varifyController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.withOpacity(0.6)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(color: Colors.black12),
                        ))),
              ),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (isLoading) {
                            return;
                          }
                          setState(() {
                            if (_varifyController.text.toString().isEmpty &&
                                widget.email.toString().isEmpty) {
                              scaffoldMessenger.showSnackBar(const SnackBar(
                                  content: Text(
                                      "Please enter your  varification code")));
                            } else {
                              isLoading = true;
                            }
                          });
                          if (_varifyController.text.toString().isEmpty &&
                              widget.email.toString().isEmpty) {
                            scaffoldMessenger.showSnackBar(const SnackBar(
                                content: Text(
                                    "Please enter your  varification code")));
                          } else {
                            emailvarification(_varifyController.text.toString(),
                                widget.email.toString());
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF113f60)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Amazon',
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Didn't receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Amazon',
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                child: const Text(
                  "Resend Again!",
                  style: TextStyle(
                    fontFamily: 'Amazon',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF113f60),
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  emailvarification(_varifyController.text.toString(),
                      widget.email.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  savePref(String name, String email, int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString("token", token);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("id", id.toString());
    preferences.commit();
  }

  emailvarification(String Vcode, String email) async {
    Map data = {
      'email': email,
      'token': Vcode,
    };
    print(email.toString());
    print(Vcode.toString());
    final response = await http.post(Uri.parse(EMAILVARIFICATION),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    print(data.toString());

    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> res = jsonDecode(response.body);
      print(SqliteDatabase.readData("goto") == "ProductSize");
      print(SqliteDatabase.readData("goto") == "ProductDetail");
      if (res['status'] == 'error') {
        DialogHelper.showFlutterToast(strMsg: res['error']);
      } else if (res['status'] == 'success') {
        if (SqliteDatabase.readData("goto") == "ProductSize") {
          savePref(res['data']["name"] ?? '', res['data']["email"] ?? '',
              res['data']["id"] ?? 0);
          Get.off(ProductSize1(
              id: SqliteDatabase.readData("productid"),
              product: SqliteDatabase.readData("product"),
              variant1: SqliteDatabase.readData("variant1"),
              variant2: SqliteDatabase.readData("variant2"),
              variant3: SqliteDatabase.readData("variant3")));
        } else if (SqliteDatabase.readData("goto") == "ProductDetail") {
          savePref(res['data']["name"] ?? '', res['data']["email"] ?? '',
              res['data']["id"] ?? 0);
          Get.off(ProductDetails(
              id: SqliteDatabase.readData("productid")!,
              varient: SqliteDatabase.readData("variant")));
        } else {
          savePref(res['data']["name"] ?? '', res['data']["email"] ?? '',
              res['data']["id"] ?? 0);
          Get.offAllNamed(Routes.dashboard);
        }
        // if (res['status'] == 'success') {
        //   if (SqliteDatabase.readData("goto") == "ProductSize") {
        //     savePref(res['data']["name"] ?? '', res['data']["email"] ?? '',
        //         res['data']["id"] ?? 0);
        //     Get.off(ProductSize1(
        //         id: SqliteDatabase.readData("productid"),
        //         product: SqliteDatabase.readData("product"),
        //         variant1: SqliteDatabase.readData("variant1"),
        //         variant2: SqliteDatabase.readData("variant2"),
        //         variant3: SqliteDatabase.readData("variant3")));
        //   } else if (SqliteDatabase.readData("goto") == "ProductDetail") {
        //     savePref(res['data']["name"] ?? '', res['data']["email"] ?? '',
        //         res['data']["id"] ?? 0);
        //     Get.off(ProductDetails(
        //         id: SqliteDatabase.readData("productid")!,
        //         varient: SqliteDatabase.readData("variant")));
        //   } else {
        //     Get.offAllNamed(Routes.dashboard);
        //   }
        // } else {
        //   DialogHelper.showFlutterToast(strMsg: "Something went wrong");
        //   SharedPreferences preferences = await SharedPreferences.getInstance();
        //   preferences.setString("value", "");
        //   preferences.setString("name", "");
        //   preferences.setString("email", "");
        //   preferences.setString("mobile", "");
        //   preferences.setString("id", "");
        //   DialogHelper.showFlutterToast(strMsg: res['message']);
        // }
      } else {
        DialogHelper.showFlutterToast(strMsg: "Something went wrong");
      }
    }
  }
}
