import 'dart:convert';
import 'dart:io';
import 'package:doafric/apis/api.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/screens/orderreview.dart';
import 'package:doafric/screens/profile_details.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:doafric/utils/textform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class UpdateProfile extends StatefulWidget {
  String name;
  String email;
  String phone;
  String town;
  String country;
  UpdateProfile(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.town,
      required this.country});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _mobilenoController = TextEditingController();
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
  bool viewOne = true, viewTwo = false, viewThree = false;
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

  saveAddress(add1, add2, zip, length) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("address_line_1", add1);
    preferences.setString("address_line_2", add2);
    preferences.setString("zip", zip);
    preferences.setString("lenght", length);
    preferences.commit();
    // DialogHelper.showFlutterToast(strMsg: "add1 "+add1+"add2 "+add2+"zip "+zip);
    const OrderReview();
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getdata();
  }

  getdata() async {
    _fullnameController.value =
        TextEditingController.fromValue(TextEditingValue(text: widget.name))
            .value;
    _mobilenoController.value =
        TextEditingController.fromValue(TextEditingValue(text: widget.phone))
            .value;
    _towncityController.value =
        TextEditingController.fromValue(TextEditingValue(text: widget.town))
            .value;
    _emailController.value =
        TextEditingController.fromValue(TextEditingValue(text: widget.email))
            .value;
    if (widget.name == null) {
      final _fullnameController = widget.name;
    } else {
      final _fullnameController = widget.name;
      return _fullnameController;
    }
  }

  File? imgFile;
  final imgPicker = ImagePicker();

  final ImagePicker picker = ImagePicker();
  String? filePath;
  File? imageFile;
  RxBool imageSelect = false.obs;
  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: const Text("Capture Image From Camera"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: const Text("Take Image From Gallery"),
                    onTap: () {
                      openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void openCamera() async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgFile = File(imgCamera!.path);
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgFile = File(imgGallery!.path);
    });
    Navigator.of(context).pop();
  }

  Widget displayImage() {
    if (imgFile == null) {
      return const Text("No Image Selected!");
    } else {
      return Image.file(imgFile!, width: 350, height: 350);
    }
  }

  @override
  Widget build(BuildContext context) {
    var categoryName = "Edit Profile";
    return Scaffold(
      backgroundColor: colorWhite,
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
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 237, 240, 244)),
              ),
              child: FutureBuilder(
                  future: ApiClient.getCountryApi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Obx(() => Center(
                                        child: Container(
                                            width: Get.width / 2,
                                            height: 100,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 50),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10.0)),
                                                border: Border.all(
                                                    color: colorlightGrey,
                                                    width: 1)),
                                            child: imageSelect.value ||
                                                    imageFile != null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                9.0)),
                                                    child: Image.file(
                                                      imageFile!,
                                                      width: Get.width,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : InkWell(
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.add,
                                                        color: colorBlack,
                                                        size: 30,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                     showOptionsDialog(
                                                          context);
                                                    },
                                                  )),
                                      )),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: TextFormScreen(
                                        textEditingController:
                                            _fullnameController,
                                        hinttext: widget.name,
                                        icon: Icons.account_circle_rounded),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: TextFormScreen(
                                      textEditingController: _emailController,
                                      hinttext: widget.email,
                                      icon: Icons.email_rounded,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: TextFormScreen(
                                      textEditingController:
                                          _mobilenoController,
                                      hinttext: "Phone",
                                      icon: Icons.phone,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 0,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: TextFormScreen(
                                                    textEditingController:
                                                        _towncityController,
                                                    hinttext: "Country",
                                                    icon: Icons
                                                        .location_on_rounded,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 50),
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: colorPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                           child: const Text(
                                              "Update Profile",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Amazon',
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            if (isLoading) {
                                              return;
                                            }
                                            if (_emailController.text.isEmpty ||
                                                _fullnameController
                                                    .text.isEmpty) {
                                              DialogHelper.showFlutterToast(
                                                  strMsg:
                                                      "Please Fill all fileds");
                                              return;
                                            }
                                            updateprofile(
                                                _fullnameController.text,
                                                _mobilenoController.text,
                                                _emailController.text,
                                                countryCode,
                                                stateID.toString(),
                                                _towncityController.text);
                                            setState(() {
                                              isLoading = true;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  getImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      imageSelect.value = true;
      filePath = image.path;
    } else {
      imageSelect.value = false;
      DialogHelper.showFlutterToast(strMsg: 'No File Selected');
    }
  }

  getImageFromCamera() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      imageFile = File(photo.path);
      imageSelect.value = true;
      filePath = photo.path;
    } else {
      imageSelect.value = false;
      DialogHelper.showFlutterToast(strMsg: 'No File Selected');
    }
  }

  void showPopupMenu() async {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.all(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose option',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              const Divider(
                color: Colors.black,
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  if (Get.isDialogOpen!) Get.back();
                  getImageFromCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  if (Get.isDialogOpen!) Get.back();
                  getImageFromGallery();
                },
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Future<void> requestCameraPermission(BuildContext context) async {
    final serviceStatus = await Permission.camera.isGranted;
    if (!serviceStatus) {
      await openAppSettings();
    }

    final status = await Permission.camera.request();
    final status1 = await Permission.storage.request();

    if (status == PermissionStatus.granted &&
        status1 == PermissionStatus.granted) {
      showPopupMenu();
    } else if (status == PermissionStatus.denied &&
        status1 == PermissionStatus.denied) {
    } else if (status == PermissionStatus.permanentlyDenied &&
        status1 == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  updateprofile(
    name,
    phone,
    email,
    country,
    state,
    towb,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString("id");
    print("Calling");
    Map data = {
      'user_id': preferences.getString('id'),
      'name': name,
      'mobile': phone,
      'email': email,
      'country_id': country,
      'state_id': state,
      'city': towb,
    };
    print(data.toString());
    final response = await http.post(Uri.parse(UPDATEPROFILE),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res);
      if (res['status'] == 'success') {
        Get.off(const profileDetails());
      } else if (res['status'] == 'error') {
        DialogHelper.showFlutterToast(strMsg: res['errors']);
      }
    } else {
      DialogHelper.showFlutterToast(strMsg: 'Please Try Again');
    }
  }
}
