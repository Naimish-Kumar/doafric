import 'dart:convert';
import 'dart:io';
import 'package:doafric/apis/api.dart';
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/db_helper/dialog_helper.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class UpdateProfile extends StatefulWidget {
  String name;
  String email;
  String? phone;
  String city;
  String state;
  String? profile_image;
  String country;
  int pincode;
  UpdateProfile(
      {super.key,
      required this.name,
      required this.email,
      required this.phone,
      required this.pincode,
      required this.profile_image,
      required this.state,
      required this.city,
      required this.country});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _fullnameController = TextEditingController();
  final _mobilenoController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();


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
  String countryCode = "", stateCode = "";
  int _id = 0, lenght = 0;
  bool isLoading = false;
  ScaffoldMessengerState? scaffoldMessenger;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _id = int.parse(preferences.getString('id').toString());
      lenght = int.parse(preferences.getString('lenght').toString());
    });
    print("Hello$_id");

    preferences.commit();
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getdata();
  }

  getdata() async {
    _fullnameController.value = TextEditingController.fromValue(
      TextEditingValue(text: widget.name),
    ).value;
    _mobilenoController.value = TextEditingController.fromValue(
      TextEditingValue(text: widget.phone.toString()),
    ).value;
    _emailController.value = TextEditingController.fromValue(
      TextEditingValue(text: widget.email),
    ).value;
    _cityController.value = TextEditingController.fromValue(
      TextEditingValue(text: widget.city),
    ).value;
    _stateController.value = TextEditingController.fromValue(
      TextEditingValue(text: widget.state),
    ).value;
    _countryController.value = TextEditingController.fromValue(
      TextEditingValue(text: widget.country),
    ).value;
    _pincodeController.value = TextEditingController.fromValue(
      TextEditingValue(text: widget.pincode.toString()),
    ).value;
    // imageFile = widget.profile_image;
    // if (imageFile != null) {
    //   imageSelect.value = true;
    // }
  }

  final imgPicker = ImagePicker();
  String? filePath;
  XFile? imageFile;
  RxBool imageSelect = false.obs;
  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Options",
              style:
                  TextStyle(color: colorPrimary, fontWeight: FontWeight.w500),
            ),
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
      imageFile = XFile(imgCamera!.path);
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = XFile(imgGallery!.path);
    });
    Navigator.of(context).pop();
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
              child: Column(
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
                          Obx(
                            () => Center(
                              child: Container(
                                width: Get.width / 2,
                                height: 100,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  border: Border.all(
                                      color: colorlightGrey, width: 1),
                                ),
                                child: imageSelect.value || imageFile != null
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(9.0)),
                                        child: Image.file(
                                          File(imageFile!.path),
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
                                          showOptionsDialog(context);
                                        },
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextFormScreen(
                                textEditingController: _fullnameController,
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
                              hinttext: "Email",
                              icon: Icons.email_rounded,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: TextFormScreen(
                              textEditingController: _mobilenoController,
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
                                                _cityController,
                                            hinttext: "City",
                                            icon: Icons.location_city_rounded,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: TextFormScreen(
                                            textEditingController:
                                                _stateController,
                                            hinttext: "State",
                                            icon: Icons.location_on_rounded,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: TextFormScreen(
                                            textEditingController:
                                                _pincodeController,
                                            hinttext: "Pin Code",
                                            icon: Icons.pin,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: TextFormScreen(
                                            textEditingController:
                                                _countryController,
                                            hinttext: "Country",
                                            icon: Icons.flag_circle_rounded,
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
                                        borderRadius: BorderRadius.circular(8),
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
                                      if (_emailController.text.isEmpty ||
                                          _fullnameController.text.isEmpty ||
                                          _mobilenoController.text.isEmpty ||
                                          _cityController.text.isEmpty ||
                                          _stateController.text.isEmpty ||
                                          _pincodeController.text.isEmpty ||
                                          _countryController.text.isEmpty) {
                                        DialogHelper.showFlutterToast(
                                            strMsg: "Please Fill all fileds");
                                      } else {
                                        updateprofile(
                                            name: _fullnameController.text,
                                            phone: _mobilenoController.text,
                                            email: _emailController.text,
                                            city: _cityController.text,
                                            state: _stateController.text,
                                            country: _countryController.text,
                                            imageProfile: imageFile,
                                            pincode: _pincodeController.text);
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getImageFromGallery() async {
    final XFile? image = await imgPicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = imageFile;
      imageSelect.value = true;
      filePath = image.path;
    } else {
      imageSelect.value = false;
      DialogHelper.showFlutterToast(strMsg: 'No File Selected');
    }
  }

  getImageFromCamera() async {
    final XFile? photo = await imgPicker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      imageFile = imageFile;
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

  updateprofile(
      {required String name,
      required String phone,
      required String email,
      required String country,
      required String state,
      required String city,
      required String pincode,
      required XFile? imageProfile}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString("id");
    if (imageProfile != null) {
      print("dhgkdjfg");
      var url = Uri.parse(UPDATEPROFILE);

      final request = http.MultipartRequest('POST', url);
      Map<String, String> headers = {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      };

      print(imageProfile!.path);
      request.headers.addAll(headers);
      print(request.headers);
      final file = await http.MultipartFile.fromPath(
          'profile_image', imageProfile!.path);
      request.files.add(file);
      request.fields['user_id'] = _id.toString();
      request.fields['name'] = name;
      request.fields['mobile'] = phone;
      request.fields['email'] = email;
      request.fields['country_id'] = country;
      request.fields['state_id'] = state;
      request.fields['city'] = city;
      request.fields['pincode'] = pincode;
      try {
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);
        print(response.body);
        var out = jsonDecode(response.body);
        if (out['status'] == "success") {
          DialogHelper.showFlutterToast(strMsg: 'Profile Updated Successfully');
          Get.back();
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("dhgkdjfdfdsfdsfg");
      DialogHelper.showFlutterToast(strMsg: 'Error ');
      Navigator.pop(context);
    }
  }
   onCountryTap() {
    setState(() {
      countryList = !countryList;
    });
  }

  onCountryChanged(int position) {
    setState(() {
      _countryIndex = position;
      countryList = !countryList;
    });
  }


final ImagePicker imgpicker = ImagePicker();
XFile? imagefiles;

openImages() async {
  try {
    final XFile? image = await imgpicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagefiles = image;
    } else {
      DialogHelper.showFlutterToast(strMsg: 'Image Not Selected');
    }
  } catch (e) {
    DialogHelper.showFlutterToast(strMsg: 'Error while picking file');
  }

 
  Widget _buildCountryList() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colorlightGrey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        margin: const EdgeInsets.only(top: 5.0),
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
            itemCount: country.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onCountryChanged(index);
                  setState(() {
                    countryCode = country[index]['phonecode'].toString();
                    countryId = country[index]['id'];
                    var api = ApiClient.getStateApi(id: countryId);
                    api.then((value) {
                      if (value['status'] == 'success') {
                        state = value["state_list"];
                        print("jjjj$state");
                        const CircularProgressIndicator(
                          color: colorPrimary,
                        );
                      } else {
                        DialogHelper.showFlutterToast(strMsg: value['msg']);
                      }
                    }, onError: (error) {
                      throw error.toString();
                    });
                  });
                },
                child: SingleChildScrollView(
                  child: Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: index == _countryIndex
                              ? Colors.grey[100]
                              : Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0))),
                      child: Text(
                        country[index]['name'] +
                            (" ( ${country[index]['phonecode']})").toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Amazon',
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      );

  onStateTap() {
    setState(() {
      stateList = !stateList;
    });
  }

  onStateChanged(int position) {
    setState(() {
      _stateIndex = position;
      stateList = !stateList;
    });
  }

  Widget buildStateList() => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: colorlightGrey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        margin: const EdgeInsets.only(top: 5.0),
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(parent: ScrollPhysics()),
            itemCount: state.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    stateID = state[index]['id'];
                  });
                  print(state[index]['id']);
                  onStateChanged(index);
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: index == _stateIndex
                          ? Colors.grey[100]
                          : Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    child: Text(
                      state[index]['name'].toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Amazon',
                      ),
                    )),
              );
            }),
      );

}
}