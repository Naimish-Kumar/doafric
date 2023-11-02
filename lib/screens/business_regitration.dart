// import 'dart:io' as Io;
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';
// import 'package:uuid/uuid.dart';
// import 'package:world/controller/import.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../components/description_text_field.dart';

// class BusinessRegistration extends StatefulWidget {
//   const BusinessRegistration({Key? key}) : super(key: key);

//   @override
//   _BusinessRegistrationState createState() => _BusinessRegistrationState();
// }
// class _BusinessRegistrationState extends State<BusinessRegistration>with TickerProviderStateMixin, ImagePickerListeners {
//   int id = 0, connectionStatus = 0, selectedIndex = -1;
//   bool enableList = false, countryList = false, stateList = false, cityList = false, storeList = false, visible = false;
//   int _selectedIndex = 0, _countryIndex = 0, _stateIndex = 0, _cityIndex = 0, _storeIndex = 0, checkedIndex = 0,backStatus=1,continueStatus=1;
//   late SharedPreferences prefs;
//   String totalItems = "0", categoryName = "", categoryId = " ", img = "0", categoryRootId = "", categoryRootName = "", countryId = "",
//       stateId = "", cityId = "", storeId = "", rootId = "", storeTypeId = "";
//   List<dynamic> locationData = [];
//   var _isSelected = false;
//   List<String> selected = [];
//   List<Sub> categories = [];
//   List selectedCategoryList = [];
//   String selectedReport = '';

//   List<Map<String, dynamic>>rootCat = [];
//   bool sunday = false, monday = false, tuesday = false, wednesday = false, thursday = false, friday = false, saturday = false;
//   List<Map<String, dynamic>>subCat = [];
//   List<Map<String, dynamic>>countryValue = [];
//   List<Map<String, dynamic>>stateValue = [];
//   List<Map<String, dynamic>>cityValue = [];
//   List<Map<String, dynamic>>paymentValue = [];
//   List<Map<String, dynamic>>dataValue5 = [];
//   List<Map<String, dynamic>>dataValueStore = [];
//   List<Map<String, dynamic>>storeValue = [];
//   List<Chip> listChip = <Chip>[];
//   List<dynamic>dataCart = [];
//   List<dynamic>subCategory = [];
//   List<dynamic>category = [];
//   List<dynamic>country = [];
//   List<dynamic>state = [];
//   List<dynamic>cityData = [];
//   List<dynamic>paymentType = [];
//   List<dynamic>storeData = [];
//   List<dynamic>rootCategory = [];
//   List<dynamic>createStore = [];
//   List<String> selectedCategory = [];
//   List<String> paymentList = [];
//   List<String> paymentName = [];
//   File? _image;
//   File? _imgLogo;
//   var currentStep = 0;
//   bool viewOne = true, viewTwo = false, viewThree = false;
//   static final _formKey = GlobalKey<FormState>();
//   bool isLoading = false;
//   var result = "";
//   String img64 = "";
//   String businessLogo = "";
//   late double height, width;
//   String imgFood = "";
//   Response ? response;
//   String progress = "", flag = "0";
//   List<String> selectedSubCategory = [];
//   List data = [];
//   List<bool> _value = [];
//   List<bool> payment = [];
//   String _radioValue = "Nearest", currency = "", symbol = "",lat="",long="";
//   TimeOfDay selectedTime = TimeOfDay.now();
//   var uuid = const Uuid();
//   String _sessionToken = "";
//   List<dynamic> _placeList = [];
//   List selectedChoices = [];

//   static TextEditingController storeName = TextEditingController();
//   static TextEditingController mobile = TextEditingController();
//   static TextEditingController address = TextEditingController();
//   static TextEditingController storeDescription = TextEditingController();
//   static TextEditingController alterMob = TextEditingController();
//   static TextEditingController ownerName = TextEditingController();
//   static TextEditingController emailId = TextEditingController();
//   static TextEditingController year = TextEditingController();
//   static TextEditingController link = TextEditingController();
//   static final _formKey1 = GlobalKey<FormState>();

//   Future root() async {
//     prefs = await SharedPreferences.getInstance();
//     id = prefs.getInt(Constants.id) ?? 0;
//     isLoading = true;
//     try {
//       final isConnected = await InternetAddress.lookup('google.com');
//       if (isConnected.isNotEmpty && isConnected[0].rawAddress.isNotEmpty) {
//         if (id
//             .toString()
//             .isNotEmpty && int.parse(id.toString()) > 0) {
//           Map<String, String> request = {"user_id": id.toString()};
//           var response = await API().post(
//               request, Base_url.businessRootCategory);
//           if (response['result'].toString() == 'S') {
//             rootCat = List<Map<String, dynamic>>.from(response['data_value']);
//             rootCategory = rootCat[0]["country_list"];
//             rootId = rootCategory[0]['category_root_id'].toString();
//             subcategory(rootId);
//             isLoading = false;
//           } else {
//             isLoading = false;
//             MessageUtils.displayToast(response["msg"]);
//           }
//         }
//       }
//     } on SocketException catch (_) {
//       isLoading = false;
//       MessageUtils.displayToast(Constants.noConnection);
//     }
//     setState(() {});
//   }

//   Future subcategory(rootId) async {
//     prefs = await SharedPreferences.getInstance();
//     id = prefs.getInt(Constants.id) ?? 0;
//     isLoading = true;
//     try {
//       final isConnected = await InternetAddress.lookup('google.com');
//       if (isConnected.isNotEmpty && isConnected[0].rawAddress.isNotEmpty) {
//         if (id
//             .toString()
//             .isNotEmpty && int.parse(id.toString()) > 0) {
//           Map<String, String> request = {
//             "user_id": id.toString(),
//             "root_category_id": rootId.toString()
//           };
//           var response = await API().post(request, Base_url.category3);
//           if (response['result'].toString() == 'S') {
//             subCat = List<Map<String, dynamic>>.from(response['data_value']);
//             selectedCategory.clear();
//             category = subCat[0]["category"];
//             for (int i = 0; i < category.length; i++) {
//               categories.add(Sub(name: category[i]["category_name"],
//                   id: category[i]["category_id"]));
//             }
//             _value = List<bool>.filled(category.length, false);
//             isLoading = false;
//           } else {
//             isLoading = false;
//             MessageUtils.displayToast(response["msg"]);
//           }
//         }
//       }
//     } on SocketException catch (_) {
//       isLoading = false;
//       MessageUtils.displayToast(Constants.noConnection);
//     }
//     setState(() {});
//   }

//   Future countryResponse() async {
//     prefs = await SharedPreferences.getInstance();
//     id = prefs.getInt(Constants.id) ?? 0;
//     isLoading = true;
//     try {
//       final isConnected = await InternetAddress.lookup('google.com');
//       if (isConnected.isNotEmpty && isConnected[0].rawAddress.isNotEmpty) {
//         if (id
//             .toString()
//             .isNotEmpty && int.parse(id.toString()) > 0) {
//           Map<String, String> request = {"user_id": id.toString()};
//           var response = await API().post(request, Base_url.country);
//           if (response['result'].toString() == 'S') {
//             countryValue =
//             List<Map<String, dynamic>>.from(response['data_value']);
//             country = countryValue[0]["country_list"];
//             stateResponse(country[0]['id'].toString());
//             countryId = country[0]['id'].toString();
//             isLoading = false;
//           } else {
//             isLoading = false;
//             MessageUtils.displayToast(response["msg"]);
//           }
//         }
//       }
//     } on SocketException catch (_) {
//       isLoading = false;
//       MessageUtils.displayToast(Constants.noConnection);
//     }
//     setState(() {});
//   }

//   Future stateResponse(countryId) async {
//     prefs = await SharedPreferences.getInstance();
//     id = prefs.getInt(Constants.id) ?? 0;
//     isLoading = true;
//     try {
//       final isConnected = await InternetAddress.lookup('google.com');
//       if (isConnected.isNotEmpty && isConnected[0].rawAddress.isNotEmpty) {
//         if (id
//             .toString()
//             .isNotEmpty && int.parse(id.toString()) > 0) {
//           Map<String, String> request = {
//             "user_id": id.toString(),
//             "country_id": countryId.toString()
//           };
//           var response = await API().post(request, Base_url.state);
//           if (response['result'].toString() == 'S') {
//             stateValue =
//             List<Map<String, dynamic>>.from(response['data_value']);
//             state = stateValue[0]["country_list"];
//             cityResponse(state[0]['id'].toString());
//             storeId = state[0]['id'].toString();
//             isLoading = false;
//           } else {
//             isLoading = false;
//             MessageUtils.displayToast(response["msg"]);
//           }
//         }
//       }
//     } on SocketException catch (_) {
//       isLoading = false;
//       MessageUtils.displayToast(Constants.noConnection);
//     }
//     setState(() {});
//   }

//   Future cityResponse(stateId) async {
//     prefs = await SharedPreferences.getInstance();
//     id = prefs.getInt(Constants.id) ?? 0;
//     isLoading = true;
//     try {
//       final isConnected = await InternetAddress.lookup('google.com');
//       if (isConnected.isNotEmpty && isConnected[0].rawAddress.isNotEmpty) {
//         if (id
//             .toString()
//             .isNotEmpty && int.parse(id.toString()) > 0) {
//           Map<String, String> request = {
//             "user_id": id.toString(),
//             "state_id": stateId.toString(),
//           };
//           var response = await API().post(request, Base_url.city);
//           if (response['result'].toString() == 'S') {
//             cityValue = List<Map<String, dynamic>>.from(response['data_value']);
//             cityData = cityValue[0]["country_list"];
//             cityId = cityData[0]['city_id'].toString();
//             isLoading = false;
//           } else {
//             isLoading = false;
//             MessageUtils.displayToast(response["msg"]);
//           }
//         }
//       }
//     } on SocketException catch (_) {
//       isLoading = false;
//       MessageUtils.displayToast(Constants.noConnection);
//     }
//     setState(() {});
//   }

//   Future storeType() async {
//     prefs = await SharedPreferences.getInstance();
//     id = prefs.getInt(Constants.id) ?? 0;
//     isLoading = true;
//     try {
//       final isConnected = await InternetAddress.lookup('google.com');
//       if (isConnected.isNotEmpty && isConnected[0].rawAddress.isNotEmpty) {
//         if (id.toString().isNotEmpty && int.parse(id.toString()) > 0) {
//           Map<String, String> request = {"user_id": id.toString()};
//           var response = await API().post(request, Base_url.store);
//           if (response['result'].toString() == 'S') {
//             dataValueStore = List<Map<String, dynamic>>.from(response['data_value']);
//             storeData = dataValueStore[0]["store_type"];
//             storeTypeId = storeData[0]['store_type_id'].toString();
//             isLoading = false;
//           } else {
//             isLoading = false;
//             MessageUtils.displayToast(response["msg"]);
//           }
//         }
//       }
//     } on SocketException catch (_) {
//       isLoading = false;
//       MessageUtils.displayToast(Constants.noConnection);
//     }
//     setState(() {});
//   }

//   Future storeCreate() async {
//     if (storeName.text.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please enter storeName.");
//     } else if (storeData.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please select business Type");
//     } else if (address.text.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please enter your address");
//     } else if (_radioValue.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please select your preference");
//     }else if (storeDescription.text.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please enter storeDescription.");
//     } else if (year.text.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please enter establishment year");
//     }else if (paymentName.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please select payment mode");
//     // } else if (businessLogo.toString().trim().isEmpty) {
//     //   MessageUtils.displayToast("Please select business logo");
//     } else if (ownerName.text.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please enter ownerName.");
//     }else if (mobile.text.toString().trim().isEmpty || mobile.text.toString().trim().length < 10) {
//       MessageUtils.displayToast("Please enter your valid mobile number");
//     } else if (emailId.text.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please enter emailId.");
//     }else if (country.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please select country");
//     }else if (state.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please select state");
//     }else if (cityData.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please select city");
//     }else if (rootCategory.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please select rootCategory");
//     }else if (lat.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please select valid address");
//     }else if (long.toString().trim().isEmpty) {
//       MessageUtils.displayToast("Please select valid address");
//     }
//     else {
//       prefs = await SharedPreferences.getInstance();
//       id = prefs.getInt(Constants.id) ?? 0;
//       isLoading = true;
//       try {
//         final isConnected = await InternetAddress.lookup('google.com');
//         if (isConnected.isNotEmpty && isConnected[0].rawAddress.isNotEmpty) {
//           if (id.toString().isNotEmpty && int.parse(id.toString()) > 0) {
//             Map<String, String> request = {
//               "user_id": id.toString(),
//               "website_url": link.text.toString(),
//               "payment_type": paymentList.join("," + " "),
//               "root_category_id": rootId,
//               "category_id": selectedCategory.join("," + " "),
//               "etablish_working_year": year.text.toString().trim(),
//               "sub_category_id": "0",
//               "store_name": storeName.text.trim(),
//               "address": address.text.trim(),
//               "country_id": countryId.toString().trim(),
//               "state_id": stateId.toString().trim(),
//               "city_id": cityId.toString().trim(),
//               "pincode": "",
//               "store_description": storeDescription.text.trim(),
//               "store_logo": businessLogo,
//               "store_image": img64,
//               "store_mobile_no": mobile.text.toString().trim(),
//               "store_alt_mobile_no": alterMob.text.toString().trim(),
//               "store_email_id": emailId.text.trim(),
//               "business_owner_name": ownerName.text.trim(),
//               "store_type": storeTypeId.toString().trim(),
//               "lat":lat, "long":long,
//               "market_range": _radioValue.toString().trim(),
//               "currency": currency.toString().trim(),
//               "currency_symbol": symbol.toString().trim()
//             };
//             var response = await API().post(request, Base_url.createStore);
//             if (response['result'].toString() == 'S') {
//               storeValue =
//               List<Map<String, dynamic>>.from(response['data_value']);
//               MessageUtils.displayToast(response["msg"]);
//               isLoading = false;
//               Navigator.of(context).pop();
//               alterMob.clear();
//               ownerName.clear();
//               mobile.clear();
//               storeDescription.clear();
//               year.clear();
//               link.clear();
//               storeName.clear();
//               address.clear();
//             } else {
//               isLoading = false;
//               MessageUtils.displayToast(response["msg"]);
//             }
//           }
//         }
//       } on SocketException catch (_) {
//         isLoading = false;
//         MessageUtils.displayToast(Constants.noConnection);
//       }
//     }
//     setState(() {});
//   }

//   Future paymentResponse() async {
//     prefs = await SharedPreferences.getInstance();
//     id = prefs.getInt(Constants.id) ?? 0;
//     isLoading = true;
//     try {
//       final isConnected = await InternetAddress.lookup('google.com');
//       if (isConnected.isNotEmpty && isConnected[0].rawAddress.isNotEmpty) {
//         if (id
//             .toString()
//             .isNotEmpty && int.parse(id.toString()) > 0) {
//           Map<String, String> request = {"user_id": id.toString()};
//           var response = await API().post(request, Base_url.paymentType);
//           if (response['result'].toString() == 'S') {
//             paymentValue =
//             List<Map<String, dynamic>>.from(response['data_value']);
//             paymentList.clear();
//             paymentType = paymentValue[0]["store_type"];
//             payment = List<bool>.filled(paymentType.length, false);
//             paymentMode(context);
//             isLoading = false;
//           } else {
//             isLoading = false;
//             MessageUtils.displayToast(response["msg"]);
//           }
//         }
//       }
//     } on SocketException catch (_) {
//       isLoading = false;
//       MessageUtils.displayToast(Constants.noConnection);
//     }
//     setState(() {});
//   }

//   _onChanges() {
//     if (_sessionToken == null) {
//       setState(() {
//         _sessionToken = uuid.v4();
//       });
//     }
//     getSuggestion(address.text);
//   }

//   void getSuggestion(String input) async {
//     String googleMapApi = Constants.googleMapApi;
//     String type = '(regions)';
//     String baseURL =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request =
//         '$baseURL?input=$input&key=$googleMapApi&sessiontoken=$_sessionToken';
//     var response = await http.get(Uri.parse(request));
//     print("request" + request);
//     if (response.statusCode == 200) {
//       setState(() {
//         _placeList = json.decode(response.body)['predictions'];
//       });
//     } else {
//       throw Exception('Failed to load predictions');
//     }
//   }

//   @override
//   void initState() {
//     storeType();
//     countryResponse();
//     root();
//     super.initState();
//     address.addListener(() {
//       _onChanges();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: white,
//       appBar: appBar(context),
//       body: SafeArea(
//         child: LoadingOverlay(
//           opacity: 0,
//           progressIndicator: const CircularProgressIndicator(),
//           isLoading: isLoading,
//           child: ListView(
//             children: [
//               Visibility(
//                 visible: viewOne,
//                 child: businessForm(context),
//               ),
//               Visibility(
//                 visible: viewTwo,
//                 child: contactForm(context),
//               ),
//               Visibility(
//                 visible: viewThree,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.only(top: 20, bottom: 10, left: 15),
//                       child: Text("Primary Business", textScaleFactor: 1,
//                         style: TextStyle(fontSize: 15,
//                             color: textColor,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.4),),
//                     ),
//                     rootCategory.isNotEmpty ? Padding(
//                       padding: const EdgeInsets.only(
//                           top: 5, bottom: 5, left: 15, right: 15),
//                       child: Column(
//                         children: <Widget>[
//                           InkWell(
//                             onTap: onHandleTap,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: enableList ? Colors.black : innerBorder, width: 1),
//                                 borderRadius: const BorderRadius.all(Radius.circular(12)), color: Colors.white,
//                               ),
//                               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                               height: 40.0,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   Expanded(
//                                       child: Text(
//                                         // ignore: unnecessary_null_comparison
//                                         _selectedIndex != null ? rootCategory[_selectedIndex]['category_root_name'] : "Select value",
//                                         style: const TextStyle(fontSize: 14.0),
//                                       )
//                                   ),
//                                   const Icon(Icons.expand_more, size: 20.0, color: Color(0XFFbbbbbb)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           enableList ? _buildSearchList() : Container(),
//                           const SizedBox(height: 5,),
//                         ],
//                       ),
//                     ) : const BlankField(text: "Select Root Category"),
//                     const SizedBox(height: 5,),
//                     subCategoryList(context),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar:  Padding(
//         padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
//         child: Button(text: "Back", press: () => backNavigation(),
//           press1: () => continueNavigation(), text1: "Continue",),
//       ),
//     );
//   }
//   appBar(context) {
//     return PreferredSize(
//       preferredSize: const Size.fromHeight(140.0),
//       child: AppBar(
//         centerTitle: true,
//         backgroundColor: lightBg,
//         elevation: 0.0,
//         leading: IconButton(
//           icon: SvgPicture.asset(
//             "assets/img/backArrow.svg",
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size(0, 0),
//           child: Container(
//             color: lightBg,
//             constraints: const BoxConstraints.expand(height: 85),
//             child: Column(
//               children: [
//                 const Text("Registration",
//                   style: TextStyle(
//                       color: Colors.black87, fontSize: 18,
//                       fontWeight: FontWeight.w600, letterSpacing: 0.4
//                   ),
//                   overflow: TextOverflow.ellipsis,),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: 20, right: 20, top: 20, bottom: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             viewOne = true;
//                             viewTwo = false;
//                             viewThree = false;
//                           });
//                         },
//                         child: (viewOne) ? Container(
//                           height: 30,
//                           width: 30,
//                           decoration: BoxDecoration(color: themeColor,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: const Center(child: Text("1", style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: white,), textAlign: TextAlign.center,)),
//                         ) :
//                         const Text("1", style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: textColor)),
//                       ),
//                       const Expanded(child: Padding(
//                         padding: EdgeInsets.only(left: 20, right: 20),
//                         child: Divider(color: textColor,
//                           height: 5,
//                           thickness: 1,),
//                       )),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             viewOne = false;
//                             viewTwo = true;
//                             viewThree = false;
//                           });
//                         },
//                         child: (viewTwo) ? Container(
//                           height: 30,
//                           width: 30,
//                           decoration: BoxDecoration(color: themeColor,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: const Center(child: Text("2", style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: white,), textAlign: TextAlign.center,)),
//                         ) : const Text("2", style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: textColor)),
//                       ),
//                       const Expanded(child: Padding(
//                         padding: EdgeInsets.only(left: 20, right: 20),
//                         child: Divider(color: textColor,
//                           height: 5,
//                           thickness: 1,),
//                       )),
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             viewOne = false;
//                             viewTwo = false;
//                             viewThree = true;
//                           });
//                         },
//                         child: (viewThree) ? Container(
//                           height: 30,
//                           width: 30,
//                           decoration: BoxDecoration(color: themeColor,
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: const Center(child: Text("3",
//                             style: TextStyle(fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                               color: white,), textAlign: TextAlign.center,)),
//                         ) : const Text("3", style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                             color: textColor)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget businessForm(context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Container(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const Padding(
//                 padding: EdgeInsets.only(top: 10, bottom: 5, left: 5),
//                 child: Text("Store / Individual ", textScaleFactor: 1,
//                   style: TextStyle(fontSize: 15,
//                       color: textColor,
//                       fontWeight: FontWeight.w600,
//                       letterSpacing: 0.4),),
//               ),
//               BorderTextField(hintText: 'Enter Store/Individual Name',
//                 controller: storeName,
//                 maxLength: 0,
//                 textType: TextInputType.name,
//                 maxLine: 1,),
//               storeData.isNotEmpty ? Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Column(
//                   children: <Widget>[
//                     InkWell(
//                       onTap: onStoreTap,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: storeList
//                                   ? Colors.blue
//                                   : innerBorder,
//                               width: storeList
//                                   ? 2
//                                   : 1),
//                           borderRadius: const BorderRadius.all(
//                               Radius.circular(12)),
//                           color: Colors.white,
//                         ),
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                         height: 40.0,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             Expanded(
//                                 child: Text(
//                                   _storeIndex != null
//                                       ? storeData[_storeIndex]['st_name']
//                                       : "Select value",
//                                   style: const TextStyle(fontSize: 14.0,
//                                       color: textColor),
//                                 )
//                             ),
//                             const Icon(Icons.expand_more,
//                                 size: 20.0, color: Color(0XFFbbbbbb)),
//                           ],
//                         ),
//                       ),
//                     ),
//                     storeList ? buildStoreList() : Container(),
//                     const SizedBox(height: 5,),
//                   ],
//                 ),
//               ) :
//               const BlankField(text: "Select Business Type"),
//               SizedBox(
//                 height:50,
//                 child: Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: GooglePlaceAutoCompleteTextField(
//                       textEditingController: address,
//                       textStyle:const TextStyle(fontSize:12,color:textColor),
//                       googleAPIKey: Constants.googleMapApi,
//                       inputDecoration: InputDecoration(
//                         contentPadding: const EdgeInsets.only(
//                             left: 14.0, bottom: 8.0, top: 8.0),
//                         fillColor: grey_100,
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: themeColor, width: 2),
//                           borderRadius: BorderRadius.circular(11),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: innerBorder),
//                           borderRadius: BorderRadius.circular(11),
//                         ),
//                         hintText: 'Enter Your Address Line ',
//                         hintStyle: TextStyle(color: textColor.withOpacity(0.4), fontSize: 12),
//                         counterText: '',
//                         floatingLabelBehavior: FloatingLabelBehavior.never,
//                         suffixIcon: IconButton(
//                           icon: const Icon(
//                             Icons.location_on_rounded, color: grey_400,
//                             size: 22,), onPressed: () {},
//                         ),
//                       ),
//                       debounceTime: 800,
//                       // countries: const ["in", "fr"],
//                       isLatLngRequired: true,
//                       getPlaceDetailWithLatLng: (Prediction prediction) {
//                         lat=prediction.lat.toString();
//                         long=prediction.lng.toString();
//                       },
//                       itmClick: (Prediction prediction) {
//                         address.text = prediction.description!;
//                         address.selection = TextSelection.fromPosition(
//                             TextPosition(offset: prediction.description!.length));
//                       }
//                     // default 600 ms ,
//                   ),
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.only(bottom: 5, top: 5),
//               //   child: Column(
//               //     mainAxisAlignment: MainAxisAlignment.center,
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //       SizedBox(
//               //         height: 50,
//               //         child: Padding(
//               //           padding: const EdgeInsets.all(5.0),
//               //           child: TextFormField(
//               //             controller: address,
//               //             decoration: InputDecoration(
//               //               contentPadding: const EdgeInsets.only(
//               //                   left: 14.0, bottom: 8.0, top: 8.0),
//               //               fillColor: grey_100,
//               //               focusedBorder: OutlineInputBorder(
//               //                 borderSide: const BorderSide(
//               //                     color: themeColor, width: 2),
//               //                 borderRadius: BorderRadius.circular(11),
//               //               ),
//               //               enabledBorder: OutlineInputBorder(
//               //                 borderSide: const BorderSide(color: innerBorder),
//               //                 borderRadius: BorderRadius.circular(11),
//               //               ),
//               //               hintText: 'Enter Your Address Line ',
//               //               hintStyle: TextStyle(
//               //                   color: textColor.withOpacity(0.4),
//               //                   fontSize: 12),
//               //               counterText: '',
//               //               floatingLabelBehavior: FloatingLabelBehavior.never,
//               //               suffixIcon: IconButton(
//               //                 icon: const Icon(
//               //                   Icons.location_on_rounded, color: grey_400,
//               //                   size: 22,), onPressed: () {},
//               //               ),
//               //             ),
//               //             keyboardType: TextInputType.name,
//               //             maxLines: 1,
//               //             maxLength: 0 == 0 ? 500 : 0,
//               //           ),
//               //         ),
//               //       ),
//               //       Visibility(
//               //         visible: address.text
//               //             .toString()
//               //             .isNotEmpty ? true : false,
//               //         child: Padding(
//               //           padding: const EdgeInsets.all(5.0),
//               //           child: Container(
//               //             padding: const EdgeInsets.all(5.0),
//               //             decoration: BoxDecoration(
//               //               border: Border.all(color: grey_400,),
//               //               borderRadius: const BorderRadius.all(
//               //                   Radius.circular(5)),
//               //               color: Colors.white,
//               //             ),
//               //             child: ListView.builder(
//               //               physics: const NeverScrollableScrollPhysics(),
//               //               shrinkWrap: true,
//               //               itemCount: _placeList.length,
//               //               itemBuilder: (context, index) {
//               //                 return ListTile(
//               //                   onTap: () {
//               //                     setState(()async {
//               //                       address.text = _placeList[index]["description"];
//               //                       // Prediction p = await PlacesAutocomplete.show(
//               //                       //     context: context, apiKey:"AIzaSyBZvh19xVeeJOYFYhmL6AQjF1Hcfvmio7I",
//               //                       //     onError: onError);
//               //                       // displayPrediction(p);
//               //
//               //                     });
//               //                   },
//               //                   leading: Container(
//               //                       width: 30,
//               //                       height: 30,
//               //                       decoration: BoxDecoration(
//               //                         borderRadius: BorderRadius.circular(20.0),
//               //                         color: grey_500,
//               //                       ),
//               //                       alignment: Alignment.center,
//               //                       child: const Icon(
//               //                         Icons.location_on_rounded, color: white,
//               //                         size: 16,)),
//               //                   title: Text(_placeList[index]["description"],
//               //                     style: const TextStyle(
//               //                         fontSize: 14, color: textColor),),
//               //                 );
//               //               },
//               //             ),
//               //           ),
//               //         ),
//               //       )
//               //     ],
//               //   ),
//               // ),
//               InkWell(
//                   onTap: () {
//                     setState(() {
//                       preferenceView(context);
//                     });
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 5, bottom: 5),
//                     child: SizedBox(
//                       height: 50,
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               border: Border.all(color: innerBorder),
//                               borderRadius: BorderRadius.circular(12.0)
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 12, left: 10),
//                             child: Text(_radioValue, style: const TextStyle(
//                               color: textColor, fontSize: 12,),
//                               textAlign: TextAlign.start,),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//               ),
//               DescriptionTextField(
//                 hintText: 'Company Description/Work Description',
//                 controller: storeDescription,
//                 maxLength:1000,
//                 textType: TextInputType.name,
//                 maxLine: 5,),
//               BorderTextField(
//                 hintText: 'Enter Establishment year / Working from year',
//                 controller: year,
//                 maxLength: 0,
//                 textType: TextInputType.name,
//                 maxLine: 1,),
//               BorderTextField(hintText: 'Website Link',
//                 controller: link,
//                 maxLength: 0,
//                 textType: TextInputType.name,
//                 maxLine: 1,),
//               const SizedBox(height: 5,),
//               InkWell(
//                   onTap: () {
//                     setState(() {
//                       paymentResponse();
//                     });
//                   },
//                   child: SizedBox(
//                     height: 50,
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: innerBorder),
//                             borderRadius: BorderRadius.circular(12.0)
//                         ),
//                         child: paymentName.isEmpty ? Padding(
//                           padding: const EdgeInsets.only(top:10, left: 10),
//                           child: Text("Select Payment Mode", style: TextStyle(
//                             color: textColor.withOpacity(0.4),fontSize: 12),),
//                         ) :
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(paymentName.join("," + " "),
//                             style: const TextStyle(
//                               color: textColor,),),
//                         ),
//                       ),
//                     ),
//                   )),
//               const SizedBox(height: 5,),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const Padding(
//                     padding: EdgeInsets.only(top: 10, bottom: 3, left: 5),
//                     child: Text("Business Logo / Individual Image /Store Image",
//                       textScaleFactor: 1,
//                       style: TextStyle(fontSize: 12,
//                           color: grey_700,
//                           fontWeight: FontWeight.w500),),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 15),
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           flag = "0";
//                           photoView(context);
//                         });
//                       },
//                       child: Center(
//                         child: _imgLogo == null ? Stack(
//                           children: <Widget>[
//                             Center(
//                               child: businessLogo == "" ? Container(
//                                   height: 150, width: 200,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xFF778899),
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(12)),
//                                   ),
//                                   child: Image.asset(
//                                       "assets/img/photo_camera.png")) :
//                               ClipRRect(
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(12)),
//                                   child: Image.network(
//                                     businessLogo, height: 150, width: 200,)),
//                             ),
//                           ],
//                         ) : ClipRRect(
//                             borderRadius: const BorderRadius.all(
//                                 Radius.circular(12)),
//                             child: Image.file(File(_imgLogo!.path),height: 150, width: 200,)),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   photoView(BuildContext context) {
//     showDialog(
//         context: context, barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Upload Photo",
//               style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),),
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(20))),
//             actions: <Widget>[
//               const Padding(
//                 padding: EdgeInsets.only(left: 15, right: 15),
//                 child: Divider(height: 10,),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     MaterialButton(
//                       child: const Text('CANCEL'),
//                       textColor: Colors.blue,
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     MaterialButton(
//                       child: const Text('Ok'),
//                       textColor: Colors.blue,
//                       onPressed: () {
//                         setState(() {
//                           Navigator.of(context).pop();
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//             content: SingleChildScrollView(
//               child: SizedBox(
//                 width: double.maxFinite,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     const Divider(),
//                     // ConstrainedBox(
//                     //   constraints: BoxConstraints(
//                     //     maxHeight: MediaQuery.of(context).size.height * 0.14,
//                     //   ),
//                     //   child:
//                     Padding(
//                       padding: const EdgeInsets.only(top: 30, bottom: 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               FloatingActionButton(
//                                   elevation: 5.0,
//                                   child: const Icon(Icons.camera_alt_rounded),
//                                   onPressed: () {
//                                     ImagePickerHandler(this).getImageFromCam();
//                                     Navigator.of(context).pop();
//                                   }
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 10),
//                                 child: Text("Camera", style: TextStyle(
//                                     color: textColor,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16
//                                 ),),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               FloatingActionButton(
//                                   elevation: 5.0,
//                                   child: const Icon(Icons.photo_album_rounded),
//                                   onPressed: () {
//                                     ImagePickerHandler(this)
//                                         .getImageFromGallery();
//                                     Navigator.of(context).pop();
//                                   }
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(top: 10),
//                                 child: Text("Gallery", style: TextStyle(
//                                     color: textColor,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16
//                                 ),),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }
//     );
//   }

//   nav(context) async {
//     Navigator.of(context).pop();
//   }

//   onHandleTap() {
//     setState(() {
//       enableList = !enableList;
//     });
//   }

//   _onChanged(int position) {
//     setState(() {
//       _selectedIndex = position;
//       enableList = !enableList;
//     });
//   }

//   Widget _buildSearchList() =>
//       Container(
//         // height: 200,
//         decoration: BoxDecoration(
//           border: Border.all(color: grey_400,),
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         margin: const EdgeInsets.only(top: 5.0),
//         child: ListView.builder(
//             padding: const EdgeInsets.all(0),
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             physics:
//             const BouncingScrollPhysics(parent: ScrollPhysics()),
//             itemCount: rootCategory.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: () {
//                   setState(() {
//                     subcategory(
//                         rootCategory[index]['category_root_id'].toString());
//                     rootId = rootCategory[index]['category_root_id'].toString();
//                   });
//                   _onChanged(index);
//                   selectedCategory.clear();
//                   selectedCategoryList.clear();
//                   subCategoryList(context);
//                 },
//                 child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0, vertical: 10.0),
//                     decoration: BoxDecoration(
//                         color: index == _selectedIndex
//                             ? Colors.grey[100]
//                             : Colors.white,
//                         borderRadius: const BorderRadius.all(
//                             Radius.circular(4.0))),
//                     child: Text(
//                       rootCategory[index]['category_root_name'].toString(),
//                       style: const TextStyle(color: Colors.black),)),
//               );
//             }),
//       );

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

//   Widget _buildCountryList() =>
//       Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: grey_400,),
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         margin: const EdgeInsets.only(top: 5.0),
//         child: ListView.builder(
//             padding: const EdgeInsets.all(0),
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             physics:
//             const BouncingScrollPhysics(parent: ScrollPhysics()),
//             itemCount: country.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: () {
//                   setState(() {
//                     stateResponse(country[index]['id'].toString());
//                     countryId = country[index]['id'];
//                     currency = country[index]['currency'].toString();
//                     symbol = country[index]['currency_symbol'].toString();
//                   });
//                   onCountryChanged(index);
//                 },
//                 child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0, vertical: 10.0),
//                     decoration: BoxDecoration(
//                         color: index == _countryIndex
//                             ? Colors.grey[100]
//                             : Colors.white,
//                         borderRadius: const BorderRadius.all(
//                             Radius.circular(4.0))),
//                     child: Text(country[index]['name'] +
//                         (" ( " + country[index]['currency_symbol'] + " " +
//                             country[index]['currency'] + " ) ").toString(),
//                       style: const TextStyle(color: Colors.black),)),
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

//   Widget buildStateList() =>
//       Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: grey_400,),
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         margin: const EdgeInsets.only(top: 5.0),
//         child: ListView.builder(
//             padding: const EdgeInsets.all(0),
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             physics:
//             const BouncingScrollPhysics(parent: ScrollPhysics()),
//             itemCount: state.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: () {
//                   setState(() {
//                     stateId = state[index]['id'].toString();
//                     cityResponse(state[index]['id'].toString());
//                   });
//                   onStateChanged(index);
//                 },
//                 child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0, vertical: 10.0),
//                     decoration: BoxDecoration(
//                         color: index == _stateIndex
//                             ? Colors.grey[100]
//                             : Colors.white,
//                         borderRadius: const BorderRadius.all(
//                             Radius.circular(4.0))),
//                     child: Text(state[index]['name'].toString(),
//                       style: const TextStyle(color: Colors.black),)),
//               );
//             }),
//       );

//   onCityTap() {
//     setState(() {
//       cityList = !cityList;
//     });
//   }

//   onCityChanged(int position) {
//     setState(() {
//       _cityIndex = position;
//       cityList = !cityList;
//     });
//   }

//   Widget buildCityList() =>
//       Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: grey_400,),
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         margin: const EdgeInsets.only(top: 5.0),
//         child: ListView.builder(
//             padding: const EdgeInsets.all(0),
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             physics:
//             const BouncingScrollPhysics(parent: ScrollPhysics()),
//             itemCount: cityData.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: () {
//                   setState(() {
//                     cityId = cityData[index]['city_id'].toString();
//                   });
//                   onCityChanged(index);
//                 },
//                 child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0, vertical: 10.0),
//                     decoration: BoxDecoration(
//                         color: index == _cityIndex
//                             ? Colors.grey[100]
//                             : Colors.white,
//                         borderRadius: const BorderRadius.all(
//                             Radius.circular(4.0))),
//                     child: Text(cityData[index]['city_name'].toString(),
//                       style: const TextStyle(color: Colors.black),)),
//               );
//             }),
//       );

//   onStoreTap() {
//     setState(() {
//       storeList = !storeList;
//     });
//   }

//   onStoreChanged(int position) {
//     setState(() {
//       _storeIndex = position;
//       storeList = !storeList;
//     });
//   }

//   _selectTime(context, editText) async {
//     final TimeOfDay? timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//       initialEntryMode: TimePickerEntryMode.dial,
//     );
//     if (timeOfDay != null && timeOfDay != selectedTime) {
//       setState(() {
//         selectedTime = timeOfDay;
//         editText = "${selectedTime.hour}:${selectedTime.minute}".toString();
//       });
//     }
//     return selectedTime;
//   }

//   Widget buildStoreList() =>
//       Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: grey_400,),
//           borderRadius: const BorderRadius.all(Radius.circular(5)),
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//         margin: const EdgeInsets.only(top: 5.0),
//         child: ListView.builder(
//             padding: const EdgeInsets.all(0),
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             physics:
//             const BouncingScrollPhysics(parent: ScrollPhysics()),
//             itemCount: storeData.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 onTap: () {
//                   setState(() {
//                     storeTypeId = storeData[index]['store_type_id'].toString();
//                   });
//                   onStoreChanged(index);
//                 },
//                 child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10.0, vertical: 10.0),
//                     decoration: BoxDecoration(
//                         color: index == _storeIndex
//                             ? Colors.grey[100]
//                             : Colors.white,
//                         borderRadius: const BorderRadius.all(
//                             Radius.circular(4.0))),
//                     child: Text(storeData[index]['st_name'].toString(),
//                       style: const TextStyle(color: Colors.black),)),
//               );
//             }),
//       );

//   Widget contactForm(context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Form(
//         key: _formKey1,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Padding(
//               padding: EdgeInsets.only(top: 10, bottom: 5, left: 5),
//               child: Text("Contact Details", textScaleFactor: 1,
//                 style: TextStyle(fontSize: 15,
//                     color: textColor,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: 0.4),),
//             ),
//             BorderTextField(hintText: 'Enter Owner Name',
//               controller: ownerName,
//               maxLength: 0,
//               textType: TextInputType.name,
//               maxLine: 1,),
//             BorderTextField(hintText: 'Enter Mobile Number',
//               controller: mobile,
//               maxLength: 10,
//               textType: TextInputType.number,
//               maxLine: 1,),
//             BorderTextField(hintText: 'Enter Alternate Mobile Number',
//               controller: alterMob,
//               maxLength: 10,
//               textType: TextInputType.number,
//               maxLine: 1,),
//             BorderTextField(hintText: 'Enter Email Id',
//               controller: emailId,
//               maxLength: 0,
//               textType: TextInputType.emailAddress,
//               maxLine: 1,),
//             country.isNotEmpty ? Padding(
//               padding: const EdgeInsets.only(
//                   top: 8, bottom: 8, left: 5, right: 5),
//               child: Column(
//                 children: <Widget>[
//                   InkWell(
//                     onTap: onCountryTap,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: countryList
//                               ? Colors.blue
//                               : innerBorder,
//                           width: countryList ? 2 : 1,),
//                         borderRadius: const BorderRadius.all(Radius.circular(
//                             12)),
//                         color: Colors.white,
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       height: 40.0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Expanded(
//                               child: Text(
//                                 // ignore: unnecessary_null_comparison
//                                 _countryIndex != null
//                                     ? country[_countryIndex]['name'] + (" ( " +
//                                     country[_countryIndex]['currency_symbol'] +
//                                     " " + country[_countryIndex]['currency'] +
//                                     " ) ")
//                                     : "Select value",
//                                 style: const TextStyle(fontSize: 14.0,
//                                     fontWeight: FontWeight.w400),
//                               )
//                           ),
//                           const Icon(Icons.expand_more,
//                               size: 20.0, color: Color(0XFFbbbbbb)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   countryList ? _buildCountryList() : Container(),
//                   const SizedBox(height: 5,),
//                 ],
//               ),
//             ) : const BlankField(text: "Select Country"),
//             state.isNotEmpty ? Padding(
//               padding: const EdgeInsets.only(
//                   top: 8, bottom: 8, left: 5, right: 5),
//               child: Column(
//                 children: <Widget>[
//                   InkWell(
//                     onTap: onStateTap,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             color: stateList
//                                 ? Colors.blue
//                                 : innerBorder,
//                             width: stateList ? 2 : 1),
//                         borderRadius: const BorderRadius.all(Radius.circular(
//                             12)),
//                         color: Colors.white,
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       height: 40.0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Expanded(
//                               child: Text(
//                                 // ignore: unnecessary_null_comparison
//                                 _stateIndex != null
//                                     ? state[_stateIndex]['name']
//                                     : "Select value",
//                                 style: const TextStyle(fontSize: 14.0),
//                               )
//                           ),
//                           const Icon(Icons.expand_more,
//                               size: 20.0, color: Color(0XFFbbbbbb)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   stateList ? buildStateList() : Container(),
//                   const SizedBox(height: 5,),
//                 ],
//               ),
//             ) : const BlankField(text: "Select State"),
//             cityData.isNotEmpty ? Padding(
//               padding: const EdgeInsets.only(
//                   top: 8, bottom: 8, left: 5, right: 5),
//               child: Column(
//                 children: <Widget>[
//                   InkWell(
//                     onTap: onCityTap,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             color: cityList
//                                 ? Colors.blue
//                                 : innerBorder,
//                             width: cityList ? 2 : 1),
//                         borderRadius: const BorderRadius.all(Radius.circular(
//                             12)),
//                         color: Colors.white,
//                       ),
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       height: 40.0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Expanded(
//                               child: Text(
//                                 // ignore: unnecessary_null_comparison
//                                 _cityIndex != null
//                                     ? cityData[_cityIndex]['city_name']
//                                     : "Select value",
//                                 style: const TextStyle(fontSize: 14.0),
//                               )
//                           ),
//                           const Icon(Icons.expand_more,
//                               size: 20.0, color: Color(0XFFbbbbbb)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   cityList ? buildCityList() : Container(),
//                   const SizedBox(height: 5,),
//                 ],
//               ),
//             ) : const BlankField(text: "Select City"),
//           ],
//         ),
//       ),
//     );
//   }
//   backNavigation() {
//     setState(() {
//       if(backStatus==1){
//         viewOne = true;
//         viewTwo = false;
//         viewThree= false;
//         Navigator.of(context).pop();
//       }else if(backStatus==2){
//         viewOne = true;
//         viewTwo = false;
//         viewThree= false;
//         backStatus=1;
//       }else if(backStatus==3){
//         viewOne = false;
//         viewTwo = true;
//         viewThree=false;
//         backStatus=2;
//       }
//     });
//   }
//   continueNavigation() {
//     setState(() {
//       if(continueStatus==1){
//         viewOne = false;
//         viewTwo = true;
//         viewThree= false;
//         continueStatus=2;
//         backStatus=2;
//       }else if(continueStatus==2){
//         viewOne = false;
//         viewTwo = false;
//         viewThree = true;
//         continueStatus=3;
//         backStatus=3;
//       }else if(continueStatus==3){
//         storeCreate();
//       }
//     });
//   }

//   // Widget _buildCheckBoxTile(index) {
//   //   return Column(
//   //     children: [
//   //       CheckboxListTile(
//   //         title: Padding(
//   //           padding: const EdgeInsets.only(top: 20, bottom: 20),
//   //           child: Text(
//   //             category[index]["category_name"], textScaleFactor: 1,
//   //             overflow: TextOverflow.visible,
//   //             style: const TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 12),
//   //             textAlign: TextAlign.start,
//   //           ),
//   //         ),
//   //         secondary: SizedBox(
//   //           height: 100, width: 60,
//   //           child: FadeInImage(
//   //             fit: BoxFit.fill,
//   //             placeholder: const AssetImage("assets/img/placeholder_two.png"),
//   //             image: NetworkImage(
//   //               Base_url.baseUrl + category[index]["category_image"],
//   //             ),
//   //             imageErrorBuilder: (context, error, stackTrace) {
//   //               return Center(
//   //                   child: Image.asset("assets/img/error.png", width: 30, height: 30));
//   //             },
//   //           ),
//   //         ),
//   //         autofocus: false,
//   //         activeColor: themeColor,
//   //         checkColor: Colors.white,
//   //         selected: _value[index],
//   //         dense: true,
//   //         value: _value[index],
//   //         onChanged: (bool? value) {
//   //           setState(() {
//   //             _value[index] = value!;
//   //             if (_value[index] == true) {
//   //               selectedCategory.add(category[index]["category_id"].toString());
//   //             } else {
//   //               selectedCategory.remove(
//   //                   category[index]["category_id"].toString());
//   //             }
//   //           });
//   //         },
//   //       ), //SizedBox
//   //       const Padding(
//   //         padding: EdgeInsets.only(left: 90, right: 0, top: 0, bottom: 0),
//   //         child: Divider(color: grey_400, height: 2,),
//   //       )
//   //     ],
//   //   );
//   // }
//   //
//   // Widget _buildExpansion(index, checked, subCategory, context) {
//   //   return Theme(
//   //       data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//   //       child: Column(
//   //         children: [
//   //           ExpansionTile(
//   //             onExpansionChanged: ((value) {
//   //               setState(() {
//   //                 selectedIndex = index;
//   //                 // request2(category[index]["category_id"].toString(),category[index]["category_name"].toString());
//   //               });
//   //             }),
//   //             leading: SizedBox(
//   //               height: 100, width: 60,
//   //               child: FadeInImage(
//   //                 fit: BoxFit.fill,
//   //                 placeholder: const AssetImage("assets/img/placeholder_two.png"),
//   //                 image: NetworkImage(
//   //                   Base_url.baseUrl + category[index]["category_image"],
//   //                 ),
//   //                 imageErrorBuilder: (context, error, stackTrace) {
//   //                   return Center(
//   //                       child: Image.asset("assets/img/error.png", width: 30, height: 30));
//   //                 },
//   //               ),
//   //             ),
//   //             title: (checked) ? Padding(
//   //               padding: const EdgeInsets.only(top: 15, bottom: 15),
//   //               child: Text(
//   //                 category[index]["category_name"], textScaleFactor: 1,
//   //                 overflow: TextOverflow.visible,
//   //                 style: const TextStyle(color: textColor,
//   //                     fontWeight: FontWeight.w700,
//   //                     fontSize: 16),
//   //                 textAlign: TextAlign.start,
//   //               ),
//   //             ) : Padding(
//   //               padding: const EdgeInsets.only(top: 20, bottom: 20),
//   //               child: Text(
//   //                 category[index]["category_name"], textScaleFactor: 1,
//   //                 overflow: TextOverflow.visible,
//   //                 style: const TextStyle(
//   //                     color: textColor,
//   //                     fontWeight: FontWeight.w500,
//   //                     fontSize: 12
//   //                 ),
//   //                 textAlign: TextAlign.start,
//   //               ),
//   //             ),
//   //             trailing: Icon((checked)
//   //                 ? Icons.arrow_circle_up_rounded
//   //                 : Icons.arrow_circle_down_rounded, color: themeColor,
//   //               size: 20,),
//   //             children: <Widget>[
//   //               subCategory.isNotEmpty ? GridView.builder(
//   //                   shrinkWrap: true,
//   //                   itemCount: subCategory.length,
//   //                   physics: const NeverScrollableScrollPhysics(),
//   //                   padding: EdgeInsets.symmetric(
//   //                       horizontal: width * 0.06, vertical: height * 0.01),
//   //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   //                       crossAxisCount: 4,
//   //                       mainAxisSpacing: 5,
//   //                       crossAxisSpacing: height * 0.03,
//   //                       childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.4)),
//   //                   itemBuilder: (BuildContext context, int index) {
//   //                     // bool checked = index == checkedIndex;
//   //                     return subSubSubCategory(index,);
//   //                   }
//   //               ) : Container(),
//   //             ],
//   //           ),
//   //           const Padding(
//   //             padding: EdgeInsets.only(left: 90, right: 0, top: 0, bottom: 0),
//   //             child: Divider(
//   //               color: grey_400,
//   //               height: 2,
//   //             ),
//   //           )
//   //         ],
//   //       )
//   //   );
//   // }

//   Widget chip(index) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: FilterChip(
//         label: Text(category[index]["category_name"]),
//         labelStyle: const TextStyle(color: Color(0xff6200ee),
//             fontSize: 16.0,
//             fontWeight: FontWeight.bold),
//         selected: selected.contains(category[index]["category_id"]),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30.0),),
//         backgroundColor: const Color(0xffededed),
//         onSelected: (isSelected) {
//           setState(() {
//             _isSelected = isSelected;
//             toggleSelection(category[index]["category_id"]);
//           });
//         },
//         selectedColor: const Color(0xffeadffd),),
//     );
//   }

//   void toggleSelection(id) {
//     setState(() {
//       if (_isSelected) {
//         _isSelected = false;
//         if (selected.contains(id)) {
//           selected.remove(id);
//         } else {
//           selected.add(id);
//         }
//       } else {
//         _isSelected = true;
//         if (selected.contains(id)) {
//           selected.remove(id);
//         } else {
//           selected.add(id);
//         }
//       }
//     });
//   }

//   Widget subSubSubCategory(index,) {
//     return Material(
//       color: Colors.white,
//       child: InkWell(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisSize: MainAxisSize.min,
//           verticalDirection: VerticalDirection.down,
//           children: [
//             Expanded(
//               flex: 4,
//               child: Container(
//                 decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(6)),
//                     border: Border.all(color: grey_300)
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: FadeInImage(
//                     fit: BoxFit.fill,
//                     placeholder: const AssetImage(
//                         "assets/img/placeholder_two.png"),
//                     image: NetworkImage(
//                       Base_url.baseUrl + subCategory[index]["category_sub_image"],
//                     ),
//                     imageErrorBuilder: (context, error, stackTrace) {
//                       return Center(
//                           child: Image.asset("assets/img/error.png", width: 30, height: 30));
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Container(
//                 padding: const EdgeInsets.only(
//                   top: 5,
//                 ),
//                 child: Text(
//                   subCategory[index]["category_sub_name"], textScaleFactor: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                       color: grey_700,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 10
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         onTap: () {},
//       ),
//     );
//   }

//   preferenceView(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//             builder: (context, StateSetter state) {
//               return AlertDialog(
//                 shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     const Text("Select Preference", textScaleFactor: 1,
//                       style: TextStyle(fontSize: 20.0,
//                         color: grey_800,
//                         fontWeight: FontWeight.w700,),
//                     ),
//                     InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(
//                           Icons.close_rounded, color: textColor, size: 22,)
//                     ),
//                   ],
//                 ),
//                 actions: <Widget>[
//                   const Padding(
//                     padding: EdgeInsets.only(left: 10, right: 10),
//                     child: Divider(height: 10,),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [

//                         MaterialButton(
//                           child: const Text('CANCEL'),
//                           textColor: Colors.blue,
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         MaterialButton(
//                           child: const Text('Ok'),
//                           textColor: Colors.blue,
//                           onPressed: () {
//                             setState(() {
//                               Navigator.of(context).pop();
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),

//                 ],
//                 content: SizedBox(
//                   width: double.minPositive,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Divider(),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 25),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Radio(
//                                   activeColor: themeColor,
//                                   value: "Nearest",
//                                   groupValue: _radioValue,
//                                   onChanged: (val) async {
//                                     state(() {
//                                       _radioValue = val.toString();
//                                     });
//                                   },
//                                 ),
//                                 const Text("Nearest", textScaleFactor: 1,
//                                     style: TextStyle(fontSize: 14.0,
//                                       fontWeight: FontWeight.w500,
//                                       color: textColor,)),
//                               ],
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Radio(
//                                 activeColor: themeColor,
//                                 value: "City",
//                                 groupValue: _radioValue,
//                                 onChanged: (val) async {
//                                   state(() {
//                                     _radioValue = val.toString();
//                                   });
//                                 },
//                               ),
//                               const Text("City", textScaleFactor: 1,
//                                   style: TextStyle(fontSize: 14.0,
//                                     fontWeight: FontWeight.w500,
//                                     color: textColor,)),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Radio(
//                                 value: "State",
//                                 groupValue: _radioValue,
//                                 activeColor: themeColor,
//                                 onChanged: (val) async {
//                                   state(() {
//                                     _radioValue = val.toString();
//                                   });
//                                 },
//                               ),
//                               const Text("State", textScaleFactor: 1,
//                                   style: TextStyle(fontSize: 14.0,
//                                     fontWeight: FontWeight.w500,
//                                     color: textColor,)),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Radio(
//                                 value: "Country",
//                                 activeColor: themeColor,
//                                 groupValue: _radioValue,
//                                 onChanged: (val) async {
//                                   state(() {
//                                     _radioValue = val.toString();
//                                   });
//                                 },
//                               ),
//                               const Text("Country", textScaleFactor: 1,
//                                   style: TextStyle(fontSize: 14.0,
//                                       fontWeight: FontWeight.w500,
//                                       color: textColor)),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Radio(
//                                 value: "World",
//                                 activeColor: themeColor,
//                                 groupValue: _radioValue,
//                                 onChanged: (val) async {
//                                   state(() {
//                                     _radioValue = val.toString();
//                                   });
//                                 },
//                               ),
//                               const Text("World", textScaleFactor: 1,
//                                   style: TextStyle(fontSize: 14.0,
//                                     fontWeight: FontWeight.w500,
//                                     color: textColor,)),
//                             ],
//                           ),
//                         ],
//                       ),
//                       // ),

//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//     );
//   }

//   paymentMode(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return StatefulBuilder(
//             builder: (context, StateSetter state) {
//               return AlertDialog(
//                 shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20))),
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     const Text("Select Payment Mode", textScaleFactor: 1,
//                       style: TextStyle(fontSize: 20.0, color: grey_800, fontWeight: FontWeight.w700,),
//                     ),
//                     InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(Icons.close_rounded, color: textColor, size: 22,)
//                     ),
//                   ],
//                 ),
//                 insetPadding: EdgeInsets.zero,
//                 actions: <Widget>[
//                   const Padding(padding: EdgeInsets.only(left: 10, right: 10),
//                     child: Divider(height: 10,),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [

//                         MaterialButton(
//                           child: const Text('CANCEL'),
//                           textColor: Colors.blue,
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                         MaterialButton(
//                           child: const Text('Ok'),
//                           textColor: Colors.blue,
//                           onPressed: () {
//                             setState(() {
//                               Navigator.of(context).pop();
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ),

//                 ],
//                 content: SingleChildScrollView(
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.75,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         const Divider(),
//                         SingleChildScrollView(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 20),
//                             child: ListView.builder(
//                                 shrinkWrap: true,
//                                 scrollDirection: Axis.vertical,
//                                 physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
//                                 padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
//                                 itemCount: paymentType.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return CheckboxListTile(
//                                     title: Text(
//                                       paymentType[index]["store_payment_methods_name"],
//                                       textScaleFactor: 1,
//                                       overflow: TextOverflow.visible,
//                                       style: const TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 12),
//                                       textAlign: TextAlign.start,
//                                     ),
//                                     autofocus: false,
//                                     activeColor: themeColor,
//                                     checkColor: Colors.white,
//                                     selected: payment[index],
//                                     dense: true,
//                                     value: payment[index],
//                                     onChanged: (bool? value) {
//                                       state(() {
//                                         payment[index] = value!;
//                                         if (payment[index] == true) {
//                                           paymentList.add(paymentType[index]["store_payment_methods_id"].toString());
//                                           paymentName.add(paymentType[index]["store_payment_methods_name"].toString());
//                                         } else {
//                                           paymentList.remove(paymentType[index]["store_payment_methods_id"].toString());
//                                           paymentName.remove(paymentType[index]["store_payment_methods_name"].toString());
//                                         }
//                                       });
//                                     },
//                                   );
//                                 }
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         }
//     );
//   }

//   String? validateCity(value) {
//     if (value.length < 0) {
//       return 'Please Enter City Name';
//     } else {
//       return null;
//     }
//   }

//   String? validateName(value) {
//     if (value.length < 0) {
//       return 'Please enter store name';
//     } else {
//       return null;
//     }
//   }

//   String? validateAddress(value) {
//     if (value.length < 0) {
//       return 'Please Enter Address';
//     } else {
//       return null;
//     }
//   }

//   String? validatePincode(value) {
//     if (value.length != 6) {
//       return 'Pincode must be of 6 digit';
//     } else {
//       return null;
//     }
//   }

//   void _validateInputs() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       setState(() {
//         viewOne = false;
//         viewTwo = true;
//       });
//     } else {
//       setState(() {});
//     }
//   }

//   String? validateLicense(value) {
//     if (value.length < 0) {
//       return 'Please Enter Drug License Number';
//     } else {
//       return null;
//     }
//   }

//   String? validateGSTIN(value) {
//     if (value.length < 0) {
//       return 'Please Enter GSTIN Number';
//     } else {
//       return null;
//     }
//   }

//   String? validateFood(value) {
//     if (value.length < 0) {
//       return 'Please Enter Food License Number';
//     } else {
//       return null;
//     }
//   }

//   void _validateInputss(context) {
//     if (_formKey1.currentState!.validate()) {
//       _formKey1.currentState!.save();
//       setState(() {
//         // storDetail2(context);
//       });
//     } else {
//       setState(() {});
//     }
//   }

//   @override
//   prescriptionImage(File _image) {
//     setState(() {
//       if (flag == 0) {
//         this._image = _image;
//         final bytes = Io.File(_image.path).readAsBytesSync();
//         businessLogo = base64Encode(bytes);
//       } else {
//         File logo = _image;
//         _imgLogo = logo;
//         final bytes = Io.File(logo.path).readAsBytesSync();
//         img64 = base64Encode(bytes);
//       }
//     });
//   }

//   subCategoryList(context){
//     return category.isNotEmpty ? Wrap(
//       spacing: 5.0,
//       runSpacing: 3.0,
//       children: [
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Center(
//               child: categoryChoiceList(context),
//             ),
//           ),
//         ),
//       ],
//     ) : DataNotFound(press: () => subcategory(rootId));
//   }

//   categoryChoiceList(context) {
//     return Wrap(
//         children: category
//             .map((item) => (Container(
//           padding: const EdgeInsets.all(2.0),
//           child: ChoiceChip(
//             selectedColor: lightBg,
//             backgroundColor: textColor.withOpacity(0.08),
//             label: Text(item['category_name'],),
//             // avatar: selectedChoices.contains(item['category_id']) ? const Icon(Icons.check_rounded, color: themeColor, size: 14,):
//             // Icon(Icons.check_rounded, color: textColor.withOpacity(0.7), size: 14,),
//             labelStyle: selectedCategory.contains(item['category_id'])?
//             const TextStyle(color: themeColor,fontWeight: FontWeight.w600, fontSize: 12,letterSpacing: .3):
//             TextStyle(color: textColor.withOpacity(0.7), fontWeight: FontWeight.w500,fontSize: 12,letterSpacing: .3),
//             selected: selectedCategory.contains(item['category_id']),
//             onSelected: (selected) {
//               setState(() {
//                 selectedCategory.contains(item['category_id'])
//                     ? selectedCategory.remove(item['category_id'])
//                     : selectedCategory.add(item['category_id']);
//                 // selectedCategory = selectedChoices;
//                 // widget.onSelectionChanged(selectedChoices);
//               });
//             },
//           ),
//         ))).toList());
//   }

// }

// class Sub {
//   Sub({ required this.name, required this.id});
//   final String name,id;
// }

// // class MultiSelectChip extends StatefulWidget {
// //   final List category;
// //   final List selectedCategory;
// //   final Function onSelectionChanged;
// //
// //   MultiSelectChip({required this.category, required this.onSelectionChanged, required this.selectedCategory});
// //
// //   @override
// //   _MultiSelectChipState createState() => _MultiSelectChipState();
// // }
// //
// // class _MultiSelectChipState extends State<MultiSelectChip> {
// //   List selectedChoices = [];
// //   List selectedCategory = [];
// //   @override
// //   Widget build(BuildContext context) {
// //     return Wrap(
// //         children: widget.category
// //             .map((item) => (Container(
// //           padding: const EdgeInsets.all(2.0),
// //           child: ChoiceChip(
// //             selectedColor: lightBg,
// //             backgroundColor: textColor.withOpacity(0.08),
// //             label: Text(item['category_name'],),
// //             // avatar: selectedChoices.contains(item['category_id']) ? const Icon(Icons.check_rounded, color: themeColor, size: 14,):
// //             // Icon(Icons.check_rounded, color: textColor.withOpacity(0.7), size: 14,),
// //             labelStyle: selectedChoices.contains(item['category_id'])?
// //             const TextStyle(color: themeColor,fontWeight: FontWeight.w600, fontSize: 12,letterSpacing: .3):
// //             TextStyle(color: textColor.withOpacity(0.7), fontWeight: FontWeight.w500,fontSize: 12,letterSpacing: .3),
// //             selected: selectedChoices.contains(item['category_id']),
// //             onSelected: (selected) {
// //               setState(() {
// //                 selectedChoices.contains(item['category_id'])
// //                     ? selectedChoices.remove(item['category_id'])
// //                     : selectedChoices.add(item['category_id']);
// //                 selectedCategory = selectedChoices;
// //                 print("uuuuu "+selectedCategory.toString());
// //                 widget.onSelectionChanged(selectedChoices);
// //               });
// //             },
// //           ),
// //         ))).toList());
// //   }
// // }