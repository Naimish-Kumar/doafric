// import 'dart:convert';

// import 'package:doafric/apis/api.dart';
// import 'package:doafric/apis/api_client.dart';
// import 'package:doafric/db_helper/dialog_helper.dart';
// import 'package:doafric/home/accout_screen.dart';
// import 'package:doafric/page_routes/routes.dart';
// import 'package:doafric/utils/colors.dart';
// import 'package:doafric/utils/font_size.dart';
// import 'package:doafric/utils/responsive_screen.dart';
// import 'package:doafric/utils/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class Editprofile extends StatefulWidget {
//   const Editprofile({super.key});

//   @override
//   State<Editprofile> createState() => _EditprofileState();  
// }

// class _EditprofileState extends State<Editprofile> {
//   // int _id = 0;
//   @override
//   void initState() {
//     super.initState();
//     getPref();
//   }

//   getPref() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       _id = int.parse(preferences.getString('id').toString());
//     });
//     print("Hello$_id");
//     preferences.commit();
//   }

//   bool isLoading = false;
//   final TextEditingController _fullnameController = TextEditingController();
//   final TextEditingController _mobilenoController = TextEditingController();
//   final TextEditingController _towncityController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   bool countryList = false, stateList = false;
//   int _countryIndex = 0,
//       countryId = 0,
//       stateID = 0,
//       _stateIndex = 0,
//       backStatus = 1,
//       continueStatus = 1,
//       connectionStatus = 0;
//   List country = [];
//   List state = [];
//   String countryCode = "", stateCode = "";
//   int _id = 0, lenght = 0;

//   @override
//   Widget build(BuildContext context) {
//     var categoryName = "Update Your Profile";
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: colorWhite,
//         centerTitle: true,
//         leading: InkWell(
//           child: const Icon(
//             Icons.arrow_back,
//             color: colorBlack,
//             size: 25,
//           ),
//           onTap: () {
//             Get.offAndToNamed(Routes.accountScreen);
//           },
//         ),
//         title: TextView(
//           textAlign: TextAlign.center,
//           fontWeight: FontWeight.w500,
//           font_size: isMobile(context)
//               ? MyFontSize().normalTextSizeMobile
//               : MyFontSize().normalTextSizeTablet,
//           fontColor: colorPrimary,
//           text: categoryName,
//           textStyle: Theme.of(context).textTheme.bodyLarge!,
//           softWrap: true,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//             height: Get.height,
//             width: Get.width,
//             decoration: BoxDecoration(
//               border:
//                   Border.all(color: const Color.fromARGB(255, 237, 240, 244)),
//             ),
//             child: FutureBuilder(
//                 future: ApiClient.getCountryApi(),
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   if (snapshot.hasData) {
//                     country.addAll(snapshot.data['country_list']);
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15, right: 15),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 Container(
//                                   alignment: Alignment.center,
//                                   child: TextField(
//                                     controller: _fullnameController,
//                                     cursorColor: Colors.grey,
//                                     decoration: InputDecoration(
//                                       hintText: "Full Name",
//                                       hintStyle: TextStyle(
//                                           fontSize: 12.0,
//                                           fontFamily: 'Amazon',
//                                           color: Colors.grey.withOpacity(0.6)),
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 Container(
//                                   color: Colors.white,
//                                   child: Column(
//                                     children: <Widget>[
//                                       Column(
//                                         children: <Widget>[
//                                           const SizedBox(
//                                             height: 10,
//                                           ),
//                                           country.isNotEmpty
//                                               ? SingleChildScrollView(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             top: 8,
//                                                             bottom: 8,
//                                                             left: 0,
//                                                             right: 0),
//                                                     child: Column(
//                                                       children: <Widget>[
//                                                         InkWell(
//                                                           onTap: onCountryTap,
//                                                           child: Container(
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               border: Border(
//                                                                 bottom: BorderSide(
//                                                                     color: countryList
//                                                                         ? Colors
//                                                                             .blue
//                                                                         : colorlightGrey,
//                                                                     width:
//                                                                         countryList
//                                                                             ? 2
//                                                                             : 1),
//                                                               ),
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                         .symmetric(
//                                                                     horizontal:
//                                                                         10.0),
//                                                             height: 40.0,
//                                                             child: Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceBetween,
//                                                               mainAxisSize:
//                                                                   MainAxisSize
//                                                                       .min,
//                                                               children: <
//                                                                   Widget>[
//                                                                 Expanded(
//                                                                     child: Text(
//                                                                   // ignore: unnecessary_null_comparison
//                                                                   _countryIndex !=
//                                                                           null
//                                                                       ? country[_countryIndex]
//                                                                               [
//                                                                               'name'] +
//                                                                           (" ( ${country[_countryIndex]['phonecode']})")
//                                                                       : "Select value",
//                                                                   style: const TextStyle(
//                                                                       fontSize:
//                                                                           12.0,
//                                                                       fontFamily:
//                                                                           'Amazon',
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w400),
//                                                                 )),
//                                                                 const Icon(
//                                                                     Icons
//                                                                         .expand_more,
//                                                                     size: 20.0,
//                                                                     color: Color(
//                                                                         0XFFbbbbbb)),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         countryList
//                                                             ? _buildCountryList()
//                                                             : Container(),
//                                                         const SizedBox(
//                                                           height: 5,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 )
//                                               : const Text("l"),
//                                           state.isNotEmpty
//                                               ? Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 8,
//                                                           bottom: 8,
//                                                           left: 0,
//                                                           right: 0),
//                                                   child: Column(
//                                                     children: <Widget>[
//                                                       InkWell(
//                                                         onTap: onStateTap,
//                                                         child: Container(
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             border: Border(
//                                                               bottom: BorderSide(
//                                                                   color: stateList
//                                                                       ? Colors
//                                                                           .blue
//                                                                       : colorlightGrey,
//                                                                   width:
//                                                                       stateList
//                                                                           ? 2
//                                                                           : 1),
//                                                             ),
//                                                             color: Colors.white,
//                                                           ),
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal:
//                                                                       10.0),
//                                                           height: 40.0,
//                                                           child: Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceBetween,
//                                                             mainAxisSize:
//                                                                 MainAxisSize
//                                                                     .min,
//                                                             children: <Widget>[
//                                                               Expanded(
//                                                                   child: Text(
//                                                                 // ignore: unnecessary_null_comparison
//                                                                 _stateIndex !=
//                                                                         null
//                                                                     ? state[_stateIndex]
//                                                                         ['name']
//                                                                     : "Select value",
//                                                                 style: const TextStyle(
//                                                                     fontSize:
//                                                                         14.0,
//                                                                     fontFamily:
//                                                                         'Amazon',
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400),
//                                                               )),
//                                                               const Icon(
//                                                                 Icons
//                                                                     .expand_more,
//                                                                 size: 20.0,
//                                                                 color: Color(
//                                                                     0XFFbbbbbb),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       stateList
//                                                           ? buildStateList()
//                                                           : Container(),
//                                                       const SizedBox(
//                                                         height: 5,
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 10,
//                                                       ),
//                                                     ],
//                                                   ))
//                                               : Container(),
//                                           Column(
//                                             children: [
//                                               Container(
//                                                 alignment: Alignment.center,
//                                                 child: TextField(
//                                                   controller:
//                                                       _towncityController,
//                                                   cursorColor: Colors.grey,
//                                                   decoration: InputDecoration(
//                                                     hintText: "Town/City*",
//                                                     hintStyle: TextStyle(
//                                                         fontSize: 12.0,
//                                                         fontFamily: 'Amazon',
//                                                         color: Colors.grey
//                                                             .withOpacity(0.6)),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 alignment: Alignment.center,
//                                                 child: TextField(
//                                                   controller: _emailController,
//                                                   cursorColor: Colors.grey,
//                                                   decoration: InputDecoration(
//                                                     hintText: "Email*",
//                                                     hintStyle: TextStyle(
//                                                         fontSize: 12.0,
//                                                         fontFamily: 'Amazon',
//                                                         color: Colors.grey
//                                                             .withOpacity(0.6)),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 alignment: Alignment.center,
//                                                 child: TextField(
//                                                   controller:
//                                                       _mobilenoController,
//                                                   cursorColor: Colors.grey,
//                                                   decoration: InputDecoration(
//                                                     hintText: "Phone*",
//                                                     hintStyle: TextStyle(
//                                                         fontSize: 12.0,
//                                                         fontFamily: 'Amazon',
//                                                         color: Colors.grey
//                                                             .withOpacity(0.6)),
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 height: 15,
//                                               )
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         height: 15,
//                                       ),
//                                       GestureDetector(
//                                         onTap: () {},
//                                         child: Container(
//                                           alignment: Alignment.center,
//                                           height: 35,
//                                           decoration: BoxDecoration(
//                                             color: colorPrimary,
//                                             borderRadius:
//                                                 BorderRadius.circular(1),
//                                             boxShadow: const [
//                                               BoxShadow(
//                                                 offset: Offset(0, 10),
//                                                 blurRadius: 50,
//                                                 color: Colors.white,
//                                               )
//                                             ],
//                                           ),
//                                           child: InkWell(
//                                             child: const Text(
//                                               "Save & Continue",
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontFamily: 'Amazon',
//                                               ),
//                                             ),
//                                             onTap: () {
//                                               if (isLoading) {
//                                                 return;
//                                               }
//                                               if (_emailController
//                                                       .text.isEmpty ||
//                                                   _fullnameController
//                                                       .text.isEmpty) {
//                                                 DialogHelper.showFlutterToast(
//                                                     strMsg:
//                                                         "Please Fill all fileds");
//                                                 return;
//                                               }

//                                               // submitaddress(
//                                               //   _fullnameController.text,
//                                               //   _mobilenoController.text,
//                                               //   _addressline1Controller
//                                               //       .text,
//                                               //   _addressline2Controller
//                                               //       .text,
//                                               //   countryCode,
//                                               //   stateID.toString(),
//                                               //   _zipController.text,
//                                               //   _emailController.text,
//                                               // );

//                                               setState(() {
//                                                 isLoading = true;
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ]),
//                         ),
//                       ],
//                     );
//                   }
//                   return Container();
//                 })),
//       ),
//     );
//   }

//   onCountryTap() {
//     setState(() {
//       countryList = !countryList;
//     });
//   }

//   onCountryChanged(int position) {
//     setState(() {
//       _countryIndex = position;
//       countryList = !countryList;
//     });
//   }

//   Widget _buildCountryList() => Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: colorlightGrey,
//           ),
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         margin: const EdgeInsets.only(top: 5.0),
//         child: ListView.builder(
//             padding: const EdgeInsets.all(0),
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
//             itemCount: country.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: () {
//                   onCountryChanged(index);
//                   setState(() {
//                     countryCode = country[index]['phonecode'].toString();
//                     countryId = country[index]['id'];
//                     var api = ApiClient.getStateApi(id: countryId);
//                     api.then((value) {
//                       if (value['status'] == 'success') {
//                         state = value["state_list"];
//                         print("jjjj$state");
//                         const CircularProgressIndicator();
//                       } else {
//                         DialogHelper.showFlutterToast(strMsg: value['msg']);
//                       }
//                     }, onError: (error) {
//                       throw error.toString();
//                     });
//                   });
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 10.0, vertical: 10.0),
//                   decoration: BoxDecoration(
//                       color: index == _countryIndex
//                           ? Colors.grey[100]
//                           : Colors.white,
//                       borderRadius:
//                           const BorderRadius.all(Radius.circular(4.0))),
//                   child: Text(
//                     country[index]['name'] +
//                         (" ( ${country[index]['phonecode']})")
//                             .toString(),
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontFamily: 'Amazon',
//                     ),
//                   ),
//                 ),
//               );
//             }),
//       );

//   onStateTap() {
//     setState(() {
//       stateList = !stateList;
//     });
//   }

//   onStateChanged(int position) {
//     setState(() {
//       _stateIndex = position;
//       stateList = !stateList;
//     });
//   }

//   Widget buildStateList() => Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: colorlightGrey,
//           ),
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         margin: const EdgeInsets.only(top: 5.0),
//         child: ListView.builder(
//             padding: const EdgeInsets.all(0),
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
//             itemCount: state.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: () {
//                   setState(() {
//                     stateID = state[index]['id'];
//                   });
//                   print(state[index]['id']);
//                   onStateChanged(index);
//                 },
//                 child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0, vertical: 10.0),
//                     decoration: BoxDecoration(
//                         color: index == _stateIndex
//                             ? Colors.grey[100]
//                             : Colors.white,
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(4.0))),
//                     child: Text(
//                       state[index]['name'].toString(),
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Amazon',
//                       ),
//                     )),
//               );
//             }),
//       );

//   resetPassword(
//       String oldpassword, String newpassword, String confirmpassword) async {
//     Map data = {
//       'id': _id.toString(),
//       'old_password': oldpassword,
//       'new_password': newpassword,
//       'confirm_password': confirmpassword
//     };
//     print(data.toString());

//     final response = await http.post(Uri.parse(UPDATEPROFILE),
//         headers: {
//           "Accept": "application/json",
//           "Content-Type": "application/x-www-form-urlencoded"
//         },
//         body: data,
//         encoding: Encoding.getByName("utf-8"));

//     print(data.toString());

//     setState(() {
//       isLoading = false;
//     });
//     if (response.statusCode == 200) {
//       setState(() {
//         isLoading = false;
//       });
//       Map<String, dynamic> res = jsonDecode(response.body);

//       if (res['status'] == 'success') {
//         Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => const AccountScreen()));
//       } else {
//         DialogHelper.showFlutterToast(strMsg: "Something went wrong");
//       }
//     } else {
//       DialogHelper.showFlutterToast(strMsg: "Something went wrong");
//     }
//   }
// }
