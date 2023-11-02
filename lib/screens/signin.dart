import 'dart:convert';

import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/screens/product_size.dart';
import 'package:doafric/utils/style_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apis/api.dart';
import '../db_helper/sqlite_database.dart';
import '../product_details.dart';
import '../utils/string_file.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  String error = '';
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                // Container(
                //   width: double.infinity,
                //   height: double.infinity,
                //   child: Image.asset(
                //     "assets/background.jpg",
                //     fit: BoxFit.fill,
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Center(
                    //     child: Image.asset(
                    //   "assets/logo.png",
                    //   height: 30,
                    //   width: 30,
                    //   alignment: Alignment.center,
                    // )),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(
                      "Learn With Us",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      width: 180,
                      child: Text(
                        "RRTutors, Hyderabad",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Learn new Technologies 😋",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 45),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: _emailController,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Colors.white70, fontSize: 15),
                              ),
                              onSaved: (val) {
                                email = val!;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Colors.white70, fontSize: 15),
                              ),
                              onSaved: (val) {
                                email = val!;
                              },
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              error,
                              style: Style_File.subtitle.copyWith(
                                  color: Colors.red, fontSize: 15.sp),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (isLoading) {
                                      return;
                                    }
                                    if (_emailController.text.isEmpty ||
                                        _passwordController.text.isEmpty) {
                                      scaffoldMessenger.showSnackBar(const SnackBar(
                                          content: Text(
                                              "Please Fill all fileds"),),);
                                      return;
                                    }
                                    login(_emailController.text,
                                        _passwordController.text);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Navigator.pushReplacementNamed(
                                        context, "/home");
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Text(
                                      "SUBMIT",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 30,
                                  bottom: 0,
                                  top: 0,
                                  child: (isLoading)
                                      ? const Center(
                                          child: SizedBox(
                                              height: 26,
                                              width: 26,
                                              child:
                                                  CircularProgressIndicator(
                                                backgroundColor: Colors.green,
                                              )))
                                      : Container(),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(fontSize: 14, color: Colors.white60),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/fingerprint.png",
                      height: 36,
                      width: 36,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/signup");
                      },
                      child: const Text(
                        "Don't have an account?",
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  login(email, password) async {
    Map data = {'email': email, 'password': password};
    print(data.toString());
    final response = await http.post(Uri.parse(LOGIN),
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
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (!resposne['error']) {
        Map<String, dynamic> user = resposne['data'];
        print(" User name ${user['id']}");
        SqliteDatabase.writeData(StorageKeys.userId, user['id']);
        savePref(1, user['name'], user['email'], user['id']);
        if (SqliteDatabase.readData("goto") == "ProductSize") {
          Get.off(ProductSize1(
              id: SqliteDatabase.readData("productid"),
              product: SqliteDatabase.readData("product"),
              variant1: SqliteDatabase.readData("variant1"),
              variant2: SqliteDatabase.readData("variant2"),
              variant3: SqliteDatabase.readData("variant3")));
        } else if (SqliteDatabase.readData("goto") == "ProductDetail") {
          Get.off(ProductDetails(
              id: SqliteDatabase.readData("productid")!,
              varient: SqliteDatabase.readData("variant")));
        }
      } else {
        print(" ${resposne['message']}");
      }
      // scaffoldMessenger.showSnackBar(SnackBar(content:Text("${resposne['message']}")));
      DialogHelper.showFlutterToast(strMsg: "Login successful");
    } else {
      scaffoldMessenger
          .showSnackBar(const SnackBar(content: Text("Please try again!")));
    }
  }

  savePref(int value, String name, String email, int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", value);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("id", id.toString());
    preferences.commit();
  }
}
