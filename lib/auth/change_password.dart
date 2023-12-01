import 'dart:convert';
import 'package:doafric/apis/api.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/utils/app_validator.dart';
import 'package:doafric/utils/button_widget.dart';
import 'package:doafric/utils/button_widgetloader.dart';
import 'package:doafric/utils/style_file.dart';
import 'package:doafric/utils/textform.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/accout_screen.dart';

// ignore: must_be_immutable
class ChangePassword extends StatefulWidget {
  String email;
  ChangePassword(this.email, {super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late ScaffoldMessengerState scaffoldMessenger;
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

  bool isLoading = false;
  bool _obscureText = true;
  bool _obscureText1 = true;
  final String _error = '';

  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  String? oldpassword, newpassword, confirmPassword;
  final _formKey = GlobalKey<FormState>();

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      changepassword(_oldpasswordController.text, _newPasswordController.text,
          _confirmpasswordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Form(
                key: _formKey,
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
                      'Change Password',
                      style: TextStyle(
                        fontFamily: 'Amazon',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: 5.h,
                    ),
                    TextFormScreen(
                      textEditingController: _oldpasswordController,
                      hinttext: "Current password",
                      // suffixIcon: true,
                      icon: Icons.lock,
                      // obscure: _obscureText1,
                      // onPressed: _toggle1,

                      validator: AppValidator.currentpasswordValidator,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormScreen(
                      textEditingController: _newPasswordController,
                      hinttext: "New password",
                      suffixIcon: true,
                      icon: Icons.lock,
                      obscure: _obscureText,
                      onPressed: _toggle,
                      validator: AppValidator.passwordValidator,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormScreen(
                      textEditingController: _confirmpasswordController,
                      hinttext: "Confirm new password",
                      suffixIcon: true,
                      icon: Icons.lock,
                      obscure: _obscureText1,
                      onPressed: _toggle1,
                      validator: AppValidator.confirm_passwordValidator,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      _error,
                      style: Style_File.subtitle
                          .copyWith(color: Colors.red, fontSize: 15.sp),
                    ),

                    SizedBox(
                      height: 6.h,
                    ),

                    !isLoading
                        ? ButtonWidget(
                            text: 'Submit',
                            onTap: () {
                              _trySubmitForm();
                            },
                          )
                        : const ButtonWidgetLoader(),
                    SizedBox(
                      height: 3.h,
                    ),

                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // TextFormField(
                    //     controller: _oldpasswordController,
                    //     cursorColor: Colors.grey,
                    //     validator: (value) {
                    //       if (value == null || value.trim().isEmpty) {
                    //         return 'This field is required';
                    //       }
                    //       if (value.trim().length < 6) {
                    //         return 'Password must be at least 6 characters in length';
                    //       }
                    //       // Return null if the entered password is valid
                    //       return null;
                    //     },
                    //     onChanged: (value) => oldpassword = value,
                    //     decoration: InputDecoration(
                    //         hintText: "Enter Old Password",
                    //         hintStyle: TextStyle(
                    //             fontFamily: 'Amazon',
                    //             fontSize: 12.0,
                    //             color: Colors.grey.withOpacity(0.6)),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8.0),
                    //           borderSide:
                    //               const BorderSide(color: Colors.black12),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8.0),
                    //           borderSide:
                    //               const BorderSide(color: Colors.black12),
                    //         ))),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // TextFormField(
                    //     controller: _newPasswordController,
                    //     cursorColor: Colors.grey,
                    //     validator: (value) {
                    //       if (value == null || value.trim().isEmpty) {
                    //         return 'This field is required';
                    //       }
                    //       if (value.trim().length < 6) {
                    //         return 'Password must be at least 6 characters in length';
                    //       }
                    //       // Return null if the entered password is valid
                    //       return null;
                    //     },
                    //     onChanged: (value) => newpassword = value,
                    //     decoration: InputDecoration(
                    //         hintText: "Enter New Password",
                    //         hintStyle: TextStyle(
                    //             fontFamily: 'Amazon',
                    //             fontSize: 12.0,
                    //             color: Colors.grey.withOpacity(0.6)),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8.0),
                    //           borderSide:
                    //               const BorderSide(color: Colors.black12),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8.0),
                    //           borderSide:
                    //               const BorderSide(color: Colors.black12),
                    //         ))),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // TextFormField(
                    //     controller: _confirmpasswordController,
                    //     cursorColor: Colors.grey,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'This field is required';
                    //       }
                    //       if (value != confirmPassword) {
                    //         return 'Confirm password does not match the entered password';
                    //       }
                    //       return null;
                    //     },
                    //     onChanged: (value) => confirmPassword = value,
                    //     decoration: InputDecoration(
                    //         hintText: "Enter Confirm Password",
                    //         hintStyle: TextStyle(
                    //             fontFamily: 'Amazon',
                    //             fontSize: 12.0,
                    //             color: Colors.grey.withOpacity(0.6)),
                    //         enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8.0),
                    //           borderSide:
                    //               const BorderSide(color: Colors.black12),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(8.0),
                    //           borderSide:
                    //               const BorderSide(color: Colors.black12),
                    //         ))),
                    // const SizedBox(
                    //   height: 30,
                    // ),

                    // GestureDetector(
                    //   onTap: () {
                    //     _trySubmitForm();
                    //   },

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
                    //       'Submit',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontFamily: 'Amazon',
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // Container(
                    //   padding: EdgeInsets.all(28),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       const SizedBox(
                    //         height: 22,
                    //       ),
                    //       SizedBox(
                    //         width: double.infinity,
                    //         child: ElevatedButton(
                    //           onPressed: () {
                    //             _trySubmitForm();
                    //           },
                    //           style: ButtonStyle(
                    //             foregroundColor:
                    //                 MaterialStateProperty.all<Color>(
                    //                     Colors.white),
                    //             backgroundColor:
                    //                 MaterialStateProperty.all<Color>(
                    //                     Color(0xFF113f60)),
                    //             shape: MaterialStateProperty.all<
                    //                 RoundedRectangleBorder>(
                    //               RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(24.0),
                    //               ),
                    //             ),
                    //           ),
                    //           child: const Padding(
                    //             padding: EdgeInsets.all(14.0),
                    //             child: Text(
                    //               'Submit',
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontFamily: 'Amazon',
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       )

                    //     ],
                    //   ),
                    // ),

                    // const SizedBox(
                    //   height: 18,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      _obscureText1 = !_obscureText1;
    });
  }

  changepassword(
      String oldpassword, String newpassword, String confirmpassword) async {
    Map data = {
      'id': _id.toString(),
      'old_password': oldpassword,
      'new_password': newpassword,
      'confirm_password': confirmpassword,
    };
    print(data.toString());

    final response = await http.post(Uri.parse(CHANGEPASSWORD),
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

      if (res['status'] == 'success') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AccountScreen()));
        DialogHelper.showFlutterToast(strMsg: res['msg']);
      } else {
        DialogHelper.showFlutterToast(strMsg: "Something went wrong");
      }
    } else {
      DialogHelper.showFlutterToast(strMsg: "Something went wrong");
    }
  }
}
