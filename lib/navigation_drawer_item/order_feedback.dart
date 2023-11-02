import 'dart:convert';
import 'dart:io';
import 'package:doafric/apis/api.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
import 'package:doafric/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:givestarreviews/givestarreviews.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/accout_screen.dart';

// ignore: must_be_immutable
class OrderFeedback extends StatefulWidget {
  int orderid;
  OrderFeedback({
    required this.orderid,
  });
  @override
  _OrderFeedbackState createState() => _OrderFeedbackState();
}

class _OrderFeedbackState extends State<OrderFeedback> {
  bool isLoading = false;

  final TextEditingController _sharefeedbackController =
      TextEditingController();

  final ImagePicker picker = ImagePicker();
  String? filePath;
  File? imageFile;
  RxBool imageSelect = false.obs;
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

  @override
  Widget build(BuildContext context) {
    //print(widget.id);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Order Feedback',
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
                "Please give your valuable feedback ",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Amazon',
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(() => Container(
                  width: 150,
                  height: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: colorlightGrey, width: 1)),
                  child: imageSelect.value || imageFile != null
                      ? ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(9.0)),
                          child: Image.file(
                            imageFile!,
                            width: Get.width,
                            height: 200,
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
                            requestCameraPermission(context);
                          },
                        ))),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Order Feedback",
                    style: TextStyle(
                        fontFamily: 'Amazon',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 3, 66, 73)),
                  ),
                  // IconButton(
                  //     onPressed: () {
                  //       Get.off(OrderFeedback());
                  //     },
                  //     icon: Icon(Icons.arrow_right))
                  GiveStarReviews(
                    starData: [
                      GiveStarData(
                          text: ' ',
                          onChanged: (rate) {
                            print(rate);
                          }),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.zero),
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  maxLines: 3,
                  controller: _sharefeedbackController,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    hintText: "Share your feedback",
                    hintStyle: TextStyle(
                        fontFamily: 'Amazon',
                        fontSize: 12.0,
                        color: Colors.grey.withOpacity(0.6)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.black12),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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

                          orderfeedback(
                            _sharefeedbackController.text,
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF113f60)),
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
                            'Submit',
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
            ],
          ),
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

  orderfeedback(
    String feedback,
  ) async {
    Map data = {
      'user_id': _id.toString(),
      'order_id': widget.orderid.toString(),
      'product_id': 7.toString(),
      'rating': 4.toString(),
      'message': feedback.toString(),
    };
    print(data.toString());

    final response = await http.post(Uri.parse(ORDERFEEDBACK),
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
      print(res);

      if (res['status'] == 'success') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AccountScreen()));
      } else {
        throw Exception('Authentication Error');
      }
    } else {
      DialogHelper.showFlutterToast(strMsg: "Something went wrong");
    }
  }
}
