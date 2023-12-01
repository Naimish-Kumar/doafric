import 'package:doafric/navigation_drawer_item/update_profile.dart';
import 'package:doafric/screens/efit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apis/api_client.dart';
import '../page_routes/routes.dart';
import '../utils/colors.dart';
import '../utils/font_size.dart';
import '../utils/responsive_screen.dart';
import '../utils/text_widget.dart';

class profileDetails extends StatefulWidget {
  const profileDetails({Key? key}) : super(key: key);

  @override
  State<profileDetails> createState() => _profileDetailsState();
}

class _profileDetailsState extends State<profileDetails> {
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
    var categoryName = "Profile Details";
    return Scaffold(
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
            Get.offAndToNamed(Routes.dashboard);
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
        child: FutureBuilder(
            future: ApiClient.GetProfileDetails(id: _id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map map = snapshot.data as Map;
                final data1 = map['data'];
                return SizedBox(
                  height: Get.height,
                  width: Get.height,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 50),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 40,
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 30),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.account_circle_rounded),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Name",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data1['name'] ?? '',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.email_rounded),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Email",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data1['email'] ?? '',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.phone),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Phone",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data1['mobile'].toString(),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.location_city),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "City",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data1['city'] ?? '',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.map_rounded),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "State",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data1['state'] ?? '',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.flag_circle),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Country",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data1['country'] ?? '',
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: ()
                               {
                                Get.to(UpdateProfile(
                                  name: data1['name'] ?? '',
                                  email: data1['email'] ?? '',
                                  phone: data1['mobile'] ?? '',
                                  town: data1['state'] ?? '',
                                  country: data1['country'] ?? '',
                                ));
                              },
                              child: Center(
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
                              ),
                            ),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'http://duafric-admin.devshs.com/upload_images/category_images/936894738.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
