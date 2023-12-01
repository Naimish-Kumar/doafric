
import 'package:doafric/apis/api_client.dart';
import 'package:doafric/utils/appbarforall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  RxInt quantity = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarScreens(text: "About Us"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
              future: ApiClient.getAboutUs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final map = snapshot.data as Map;
                    final desc = map['about_us']['description'];
                    print('desc $map');
        
                    return Container(
                        margin: const EdgeInsets.all(15),
                        child: Html(data: desc));
                  }
                }
                return const  Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 9, 1, 27),
                    ),
                  
                );
              }),
        ),
      ),
    );
  }
}
