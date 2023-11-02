import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(Icons.compare_arrows),
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear();
            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, "/login");
          },
        ),
        title: const Text(
          "Learn With Us",
        ),
        backgroundColor: Colors.black87,
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Stack(
        children: [
          // WebView(
          //   javascriptMode: JavascriptMode.unrestricted,
          //   initialUrl: 'https://rrtutors.com/language/Flutter',
          //   onPageFinished:(value){
          // setState(() {
          //   isLoading=true;
          // });

          //   },

          // ),
          (!isLoading)
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
