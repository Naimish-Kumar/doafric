import 'dart:convert';
import 'package:doafric/apis/api.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/app_validator.dart';
import 'package:doafric/utils/button_widget.dart';
import 'package:doafric/utils/button_widgetloader.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/textform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../db_helper/sqlite_database.dart';
import '../product_details.dart';
import '../utils/string_file.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;

  final _formKey = GlobalKey<FormState>();
  // String?  email, password;

  String _error = "";
  bool isLoading = false;
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool setvalue = false;

  RxBool apiCall = true.obs;

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      login(_emailController.text, _passwordController.text);
      isLoading = true;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // TextFormField(
                  //   controller: _emailController,
                  //   validator: (value) {
                  //     if (value == null || value.trim().isEmpty) {
                  //       return 'Please enter your email address';
                  //     }
                  //     // Check if the entered email has the right format
                  //     if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                  //       return 'Please enter a valid email address';
                  //     }
                  //     // Return null if the entered email is valid
                  //     return null;
                  //   },
                  //   //onChanged: (value) => email = value,

                  //   onChanged: (val) {
                  //     email = val;
                  //   },

                  //   cursorColor: Colors.grey,
                  //   decoration: InputDecoration(
                  //     hintText: "Enter your email id ",
                  //     hintStyle: TextStyle(
                  //         fontFamily: 'Amazon',
                  //         fontSize: 12.0,
                  //         color: Colors.grey.withOpacity(0.6)),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //       borderSide: const BorderSide(color: Colors.black12),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //       borderSide: const BorderSide(color: Colors.black12),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(
                    height: 10,
                  ),

                  TextFormScreen(
                    hinttext: 'Enter your email id',
                    icon: Icons.mail,
                    textEditingController: _emailController,
                    validator: AppValidator.emailValidator,
                  ),

                  SizedBox(
                    height: 2.h,
                  ),
                  TextFormScreen(
                    hinttext: 'Lösenord',
                    icon: Icons.lock,
                    textEditingController: _passwordController,
                    // controller: _passwordController,

                    validator: AppValidator.passwordValidator,
                    suffixIcon: true,
                    obscure: _obscureText,
                    onPressed: _toggle,
                  ),

                  // TextFormField(
                  //   controller: _passwordController,

                  //   validator: (value) {
                  //     if (value == null || value.trim().isEmpty) {
                  //       return 'Please enter your password';
                  //     }
                  //     if (value.trim().length < 6) {
                  //       return 'Password must be at least 6 characters in length';
                  //     }
                  //     // Return null if the entered password is valid
                  //     return null;
                  //   },

                  //   // obscureText: true,

                  //   onChanged: (val) {
                  //     password = val;
                  //   },
                  //   cursorColor: Colors.grey,
                  //   decoration: InputDecoration(
                  //     hintText: "Password(minimum of 6 character) ",
                  //     hintStyle: TextStyle(
                  //         fontFamily: 'Amazon',
                  //         fontSize: 12.0,
                  //         color: Colors.grey.withOpacity(0.6)),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //       borderSide: const BorderSide(color: Colors.black12),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //       borderSide: const BorderSide(color: Colors.black12),
                  //     ),
                  //   ),
                  // ),

                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Text("Forgot Your Password?",
                            style: TextStyle(
                                fontFamily: 'Amazon',
                                color: colorBlack,
                                fontSize: 12)),
                        onTap: () {
                          Get.offAndToNamed(Routes.forgotpassword);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),

                  //                 void _trySubmitForm() {
                  //   final bool? isValid = _formKey.currentState?.validate();
                  //   if (isValid == true) {
                  //     signup(
                  //         _nameController.text,
                  //         _emailController.text,
                  //         _passwordController.text,
                  //         _reppasswordController.text,
                  //         _phoneController.text);
                  //   }
                  // }

                  Text(
                    _error,
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),

                  !isLoading
                      ? ButtonWidget(
                          text: 'Sign In',
                          onTap: () {
                            _trySubmitForm();
                          },
                        )
                      : ButtonWidgetLoader(),
                  SizedBox(
                    height: 1.h,
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     _trySubmitForm();
                  //   },
                  //   //   if (isLoading) {
                  //   //     return;
                  //   //   }

                  //   //   if (_emailController.text.isEmpty ||
                  //   //       _passwordController.text.isEmpty) {
                  //   //     DialogHelper.showFlutterToast(
                  //   //         strMsg: "Please Fill all fields");
                  //   //     return;
                  //   //   }
                  //   // login(_emailController.text, _passwordController.text);
                  //   // setState(() {
                  //   //   isLoading = true;
                  //   // });
                  //   // },

                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       color: colorPrimary,
                  //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           offset: Offset(0, 20),
                  //           blurRadius: 50,
                  //           color: Colors.white,
                  //         )
                  //       ],
                  //     ),
                  //     child: const Text(
                  //       "Sign In",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontFamily: 'Amazon',
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("--------- Or sign in with ---------",
                            style: TextStyle(
                              color: colorBlack,
                              fontSize: 12,
                              fontFamily: 'Amazon',
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset("assets/images/facebook.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("facebook",
                                style: TextStyle(
                                    fontFamily: 'Amazon',
                                    color: colorBlack,
                                    fontSize: 12)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset("assets/images/google.png"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("Google",
                                style: TextStyle(
                                    fontFamily: 'Amazon',
                                    color: colorBlack,
                                    fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("We keep your data safe. for further assistance",
                          style: TextStyle(
                              fontFamily: 'Amazon',
                              color: Colors.grey.withOpacity(0.6),
                              fontSize: 12)),
                      Text(" please refer to our privacy policy.",
                          style: TextStyle(
                              fontFamily: 'Amazon',
                              color: Colors.grey.withOpacity(0.6),
                              fontSize: 12)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  savePref(String name, String email, int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString("token", token);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("id", id.toString());
    preferences.commit();
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
    if (mounted) {
      setState(() {
        this.isLoading = false;
      });
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(" User name ${res}");
      print(" User id  ${res['data']["id"]}");
      if (res['status'] == 'error') {
        DialogHelper.showFlutterToast(strMsg: res['error']);
      } else if (res['status'] == 'success') {
        if (SqliteDatabase.readData("goto") == "ProductSize") {
          SqliteDatabase.writeData(StorageKeys.userId, res['data']["id"]);
          savePref(res['data']["name"] ?? '', res['data']["email"] ?? '',
              res['data']["id"] ?? 0);
          // Get.off(ProductSize1(
          //     id: SqliteDatabase.readData("productid"),
          //     product: SqliteDatabase.readData("product"),
          //     variant1: SqliteDatabase.readData("variant1"),
          //     variant2: SqliteDatabase.readData("variant2"),
          //     variant3: SqliteDatabase.readData("variant3")));
        } else if (SqliteDatabase.readData("goto") == "ProductDetail") {
          SqliteDatabase.writeData(StorageKeys.userId, res['data']["id"]);
          savePref(res['data']["name"] ?? '', res['data']["email"] ?? '',
              res['data']["id"] ?? 0);
          Get.off(ProductDetails(
              id: SqliteDatabase.readData("productid")!,
              varient: SqliteDatabase.readData("variant")));
        } else {
          SqliteDatabase.writeData(StorageKeys.userId, res['data']["id"]);
          savePref(res['data']["name"] ?? '', res['data']["email"] ?? '',
              res['data']["id"] ?? 0);
          Get.offAllNamed(Routes.dashboard);
        }
        DialogHelper.showFlutterToast(strMsg: res['msg']);
      } else {
        DialogHelper.showFlutterToast(strMsg: "Hello");
      }
    }
    //  DialogHelper.showFlutterToast(strMsg: "Something went wrong");
  }
}
