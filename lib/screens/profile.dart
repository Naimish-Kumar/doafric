// ignore_for_file: camel_case_types

import 'package:doafric/navigation_drawer_item/edit_profile.dart';
import 'package:doafric/utils/appbarforall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../apis/api_client.dart';


class profileDetails extends StatefulWidget {
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
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarScreens(text: "Profile Details"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          FutureBuilder(
              future: ApiClient.GetProfileDetails(id: _id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: Get.width,
                    height: Get.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    Map map = snapshot.data as Map;
                    final data1 = map['data'];
                    print('dataaaaa $map');

                    return SizedBox(
                      height: Get.height,
                      width: Get.height,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 0.2, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Profile Details",
                                  style: TextStyle(
                                      fontFamily: 'Amazon',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.off(
                                      EditProfile(
                                        name: data1['name'],
                                        email: data1['email'],
                                        phone: data1['mobile'],
                                        country: data1['country']['name'],
                                        town: data1['city'],
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontFamily: 'Amazon',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 0.2, color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                 // data1['name']??'',
                                 '',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  //data1['email']??'',
                                  '',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Phone",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                 // data1['mobile']?? '',
                                 '',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Country",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                 // data1['country']['name'].toString(),
                                 '',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "City",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                 // data1['city']??'',
                                 '',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
                return Container();
              }),
        ],
      )),
    );
  }
}
