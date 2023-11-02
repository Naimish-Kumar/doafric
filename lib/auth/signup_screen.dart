import 'dart:convert';

import 'package:doafric/apis/api.dart';
import 'package:doafric/auth/verify_screen.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/db_helper/sqlite_database.dart';
import 'package:doafric/utils/app_validator.dart';
import 'package:doafric/utils/button_widget.dart';
import 'package:doafric/utils/button_widgetloader.dart';
import 'package:doafric/utils/string_file.dart';
import 'package:doafric/utils/textform.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => InitState();

  bool isLoading = false;
  ScaffoldMessengerState? scaffoldMessenger;
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}

class InitState extends State<SignUpScreen> {
  bool isLoading = false;
  bool _obscureText = true;
  bool _obscureText1 = true;
  final _formKey = GlobalKey<FormState>();
  String? name, email, password, confirmPassword, phoneno;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reppasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _trySubmitForm() {
      final bool? isValid = _formKey.currentState?.validate();
      if (isValid == true) {
        signup(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
            _reppasswordController.text,
            _phoneController.text);
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 2.h,
                ),
                TextFormScreen(
                  hinttext: 'Full Name',
                  icon: Icons.account_circle,
                  textEditingController: _nameController,
                  validator: AppValidator.nameValidator,
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextFormScreen(
                  hinttext: 'Email id',
                  icon: Icons.mail,
                  textEditingController: _emailController,
                  validator: AppValidator.emailValidator,
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextFormScreen(
                  hinttext: 'Password',
                  icon: Icons.lock,
                  textEditingController: _passwordController,
                  suffixIcon: true,
                  obscure: _obscureText,
                  onPressed: _toggle,
                  validator: AppValidator.passwordValidator,
                ),
                SizedBox(
                  height: 2.h,
                ),
                TextFormScreen(
                  hinttext: 'Confirm Password',
                  icon: Icons.lock,
                  textEditingController: _reppasswordController,
                  suffixIcon: true,
                  obscure: _obscureText1,
                  onPressed: _toggle1,
                  validator: AppValidator.confirm_passwordValidator,
                ),

                SizedBox(
                  height: 2.h,
                ),
                TextFormScreen(
                  hinttext: 'Phone Number',
                  icon: Icons.phone_android_rounded,
                  textEditingController: _phoneController,
                  validator: AppValidator.mobileValidator,
                ),

                SizedBox(
                  height: 3.h,
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                // TextFormField(
                //   controller: _nameController,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'This field is required';
                //     }
                //     if (value.trim().length < 4) {
                //       return 'Username must be at least 4 characters in length';
                //     }
                //     // Return null if the entered username is valid
                //     return null;
                //   },
                //   cursorColor: Colors.grey,
                //   decoration: InputDecoration(
                //     hintText: "Full Name ",
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
                //   onChanged: (value) => name = value,
                // ),

                // const SizedBox(
                //   height: 10,
                // ),
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
                //   onChanged: (value) => email = value,
                //   cursorColor: Colors.grey,
                //   decoration: InputDecoration(
                //     hintText: "Email ",
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

                // const SizedBox(
                //   height: 10,
                // ),
                // TextFormField(
                //   controller: _passwordController,
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'This field is required';
                //     }
                //     if (value.trim().length < 6) {
                //       return 'Password must be at least 6 characters in length';
                //     }
                //     // Return null if the entered password is valid
                //     return null;
                //   },
                //   obscureText: true,
                //   onChanged: (value) => password = value,
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
                // const SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   decoration: const BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.zero),
                //   ),
                //   alignment: Alignment.center,
                //   child: TextFormField(
                //     controller: _reppasswordController,
                //     obscureText: true,
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'This field is required';
                //       }
                //       if (value != password) {
                //         return 'Confirm password does not match the entered password';
                //       }
                //       return null;
                //     },
                //     onChanged: (value) => confirmPassword = value,
                //     cursorColor: Colors.grey,
                //     decoration: InputDecoration(
                //       hintText: "Confirm Password ",
                //       hintStyle: TextStyle(
                //           fontFamily: 'Amazon',
                //           fontSize: 12.0,
                //           color: Colors.grey.withOpacity(0.6)),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8.0),
                //         borderSide: const BorderSide(color: Colors.black12),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8.0),
                //         borderSide: const BorderSide(color: Colors.black12),
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),

                // Container(
                //   decoration: const BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.zero),
                //   ),
                //   alignment: Alignment.center,
                //   child: TextFormField(
                //     controller: _phoneController,
                //     keyboardType: TextInputType.phone,
                //     onChanged: (value) => phoneno = value,
                //     cursorColor: Colors.grey,
                //     decoration: InputDecoration(
                //       hintText: "Phone(Optional)",
                //       hintStyle: TextStyle(
                //           fontFamily: 'Amazon',
                //           fontSize: 12.0,
                //           color: Colors.grey.withOpacity(0.6)),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8.0),
                //         borderSide: const BorderSide(color: Colors.black12),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(8.0),
                //         borderSide: const BorderSide(color: Colors.black12),
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                SizedBox(
                  height: 5.h,
                ),
                // Text(
                //   error,
                //   style: Style_File.subtitle
                //       .copyWith(color: Colors.red, fontSize: 15.sp),
                // ),
                // SizedBox(
                //   height: 2.h,
                // ),
                !isLoading
                    ? ButtonWidget(
                        text: 'Sign Up',
                        onTap: () {
                          _trySubmitForm();
                        },
                      )
                    : ButtonWidgetLoader(),
                SizedBox(
                  height: 4.h,
                ),

                // GestureDetector(
                //   onTap: () {
                //     _trySubmitForm();
                //   },
                //   child: Container(
                //     alignment: Alignment.center,
                //     height: 40,
                //     decoration: BoxDecoration(
                //       color: colorPrimary,
                //       borderRadius: BorderRadius.circular(8.0),
                //       boxShadow: const [
                //         BoxShadow(
                //           offset: Offset(0, 10),
                //           blurRadius: 50,
                //           color: Colors.white,
                //         )
                //       ],
                //     ),
                //     child: const Text(
                //       "Sign Up",
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontFamily: 'Amazon',
                //       ),
                //     ),
                //   ),

                // ),
                // SizedBox(
                //   height: 3.h,
                // ),
              ],
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("--- Or sign in with ---",
          //           style: TextStyle(
          //             color: colorBlack,
          //             fontSize: 12,
          //             fontFamily: 'Amazon',
          //           )),
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Column(
          //       children: [
          //         SizedBox(
          //           height: 30,
          //           width: 30,
          //           child: Image.asset("assets/images/facebook.png"),
          //         ),
          //         Text("facebook",
          //             style: TextStyle(
          //               color: Colors.grey.withOpacity(0.6),
          //               fontSize: 12,
          //               fontFamily: 'Amazon',
          //             )),
          //       ],
          //     ),
          //     const SizedBox(
          //       width: 50,
          //     ),
          //     Column(
          //       children: [
          //         SizedBox(
          //           height: 30,
          //           width: 30,
          //           child: Image.asset("assets/images/google.png"),
          //         ),
          //         Text("google",
          //             style: TextStyle(
          //               color: Colors.grey.withOpacity(0.6),
          //               fontSize: 12,
          //               fontFamily: 'Amazon',
          //             )),
          //       ],
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 15),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text("We keep your data safe. for further assistance",
          //         style: TextStyle(
          //           color: Colors.grey.withOpacity(0.6),
          //           fontSize: 12,
          //           fontFamily: 'Amazon',
          //         )),
          //     Text(" please refer to our privacy policy.",
          //         style: TextStyle(
          //           color: Colors.grey.withOpacity(0.6),
          //           fontSize: 12,
          //           fontFamily: 'Amazon',
          //         )),
          //   ],
          // )
        ],
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText;
    });
  }

  signup(name, email, password, reppassword, phone) async {
    setState(() {
      widget.isLoading = false;
    });
    print("Calling");

    Map data = {
      'email': email,
      'password': password,
      'psw_repeat': reppassword,
      'name': name,
      'mobile': phone,
      'role_id': "2"
    };

    print(data.toString());
    final response = await http.post(Uri.parse(REGISTRATION),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    setState(() {
      widget.isLoading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        widget.isLoading = false;
      });

      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      if (res['status'] == 'success') {
        Map<String, dynamic> user = res['data'];
        print(" User name ${user["id"]}");
        SqliteDatabase.writeData(StorageKeys.userId, user['id']);
        SqliteDatabase.writeData(StorageKeys.userEmail, user['email']);

        print(SqliteDatabase.readData(StorageKeys.userId));
        print(
            "===============================================================");
        savePref(1, user['name'] ?? '', user['email'] ?? '', user['id'] ?? '',
            user['mobile'] ?? '');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => VarifyScreen(email)));
      } else if (res['status'] == 'error') {
        DialogHelper.showFlutterToast(strMsg: res['errors']['email'][0]);
      }
    } else {
      widget.scaffoldMessenger!
          .showSnackBar(const SnackBar(content: Text("Please Try again")));
    }
  }

  savePref(int value, String name, String email, int id, String mobile) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setInt("value", value);
    await preferences.setString("name", name);
    await preferences.setString("email", email);
    await preferences.setString("mobile", mobile);
    await preferences.setString(StorageKeys.userId, id.toString());
    await preferences.commit();
  }
}
