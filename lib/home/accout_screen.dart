import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doafric/auth/login_signup_screen.dart';
import 'package:doafric/cart_list.dart';
import 'package:doafric/main.dart';
import 'package:doafric/navigation_drawer_item/myorder.dart';
import 'package:doafric/navigation_drawer_item/update_profile.dart';
import 'package:doafric/screens/efit_profile.dart';
import 'package:doafric/screens/profile_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/change_password.dart';
import '../page_routes/routes.dart';
import '../utils/colors.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _id = 0;
  String? name, email, mobile, value;
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

    name = preferences.getString("name");
    email = preferences.getString("email");
    mobile = preferences.getString("mobile");
    preferences.getString("id");

    print("user ${preferences.getString("id")}");
    print("user ${preferences.getString("name")}");
    print("user ${preferences.getString("email")}");
    print("Hello$_id");
    preferences.commit();
  }

  bool signup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (name != null) ...[
                Stack(
                  children: [
                    Container(
                      width: Get.width,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(1.0)),
                          border: Border.all(color: colorPrimary, width: 2),
                          boxShadow: const [BoxShadow(color: colorPrimary)]),
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xFF113f60),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => UpdateProfile(
                                        name: name?? '',
                                        email: email??'',
                                        phone: mobile??'',
                                        town: '',
                                        country: '',
                                      ));
                                    },
                                    child: const Icon(
                                      Icons.settings,
                                      color: colorWhite,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const CartList());
                                    },
                                    child: const Icon(Icons.shopping_bag_outlined,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const SizedBox(
                                  width: 40,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: colorPrimary,
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                        color: colorPrimary, width: 1),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/cat1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: 'Amazon',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      email.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Amazon',
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() =>  UpdateProfile(
                                          name: name ?? '',
                                          email: email ?? '',
                                          phone: mobile ?? '',
                                          town: '',
                                          country: '',
                                        ));
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: colorWhite,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // top: 1,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          width: Get.width,
                          height: Get.height / 9,
                          margin: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                          // decoration: const BoxDecoration(color: Colors.black),

                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(color: colorPrimary, width: 2),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(1, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text('Membership Benefits',
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: 'Amazon',
                                              color: Colors.yellow)),
                                    ),
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          // Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12.0,
                                          color: Colors.yellow,
                                        )),
                                  ],
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('New Member Gift \n5% OFF',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Amazon',
                                            color: Colors.yellow)),
                                    VerticalDivider(),
                                    Text('Birthday Gift Item \n10% OFF',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Amazon',
                                          color: Colors.yellow,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
                Container(
                  width: Get.width,
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: const BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             const Text(
                                "My Orders",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Amazon',
                                    color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const MyOrder());
                              },
                              child: const Text(
                                "View All",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Amazon',
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Image(
                                    image: AssetImage(
                                      "assets/images/progress.png",
                                    ),
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.fill),
                                Text(
                                  "In Progress",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Amazon',
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Image(
                                    image: AssetImage(
                                      "assets/images/ship.png",
                                    ),
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.fill),
                                Text("Deliverd",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Amazon',
                                        color: Colors.grey))
                              ],
                            ),
                            Column(
                              children: [
                                Image(
                                    image: AssetImage(
                                      "assets/images/review.png",
                                    ),
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.fill),
                                Text("Reviews",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Amazon',
                                        color: Colors.grey))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                           Get.toNamed(Routes.addresslist);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  children: [
                                   Icon(
                                          Icons.playlist_add_check_circle_sharp,
                                          size: 20.0,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(width: 5,),
                                         Text("Address Book",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Amazon',
                                                color: Colors.black)),
                                  ],
                                ),
                              Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20.0,
                                    color: Colors.grey,
                                  )
                            ],
                          ),
                        ),
                      ),
                      
                      InkWell(
                        onTap: () {
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.credit_card,
                                    size: 20.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Payment",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Amazon',
                                          color: Colors.black)),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.0,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                       InkWell(
                        onTap: () {
                          Get.to(const profileDetails());
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.account_circle_rounded,
                                    size: 20.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Profile Details",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Amazon',
                                          color: Colors.black)),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.0,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                       InkWell(
                        onTap: () {
                          Get.to(ChangePassword(email.toString()));
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock,
                                    size: 20.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Change Password",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Amazon',
                                          color: Colors.black)),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.0,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                       
                        InkWell(
                        onTap: () {
                          Get.toNamed(Routes.helpSupport);
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    size: 20.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Help Center",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Amazon',
                                          color: Colors.black)),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.0,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                       
                       InkWell(
                        onTap: () {
                      AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            btnOkColor: colorPrimary,
                            borderSide:
                                BorderSide(color: colorPrimary, width: 0.1.h),
                            buttonsBorderRadius:
                                const BorderRadius.all(Radius.circular(2)),
                            headerAnimationLoop: false,
                            animType: AnimType.bottomSlide,
                            title: 'Logout',
                            desc: 'Are you sure you want to logout of doafric?',
                            showCloseIcon: true,
                            // btnCancelOnPress: () {
                            //   Navigator.pop(context);
                            // },
                            btnOkOnPress: () {
                              if (MyApp.userid == null) {
                                Navigator.pushReplacementNamed(
                                    context, Routes.loginSignupScreen);
                              } else {
                             
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamedAndRemoveUntil(
                                        Routes.loginSignupScreen,
                                        (Route<dynamic> route) => false);
                              }
                            },
                          ).show();
            
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.power_settings_new,
                                    size: 20.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Logout",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Amazon',
                                          color: Colors.black)),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20.0,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                       
                    ],
                  ),
                ),
              ] else ...[

                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                        image: AssetImage(
                          "assets/images/loginpic.jpg",
                        ),
                        width: 300,
                        height: 300,
                        fit: BoxFit.fill),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'You have no account! ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colorBlack),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.loginSignupScreen);
                          },
                          child: const Text(
                            ' Login Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: colorPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
