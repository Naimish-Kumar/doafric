import 'package:flutter/material.dart';

class feedback extends StatelessWidget {
  const feedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '                        Feedback',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "* Write your feedback here",
                style: TextStyle(color: Colors.black),
              ),
              const Column(
                children: <Widget>[
                  Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          maxLines: 8, //or null
                          decoration: InputDecoration.collapsed(
                              hintText: "Enter your text here"),
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "* Name",
                style: TextStyle(color: Colors.black),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: TextField(
                            // controller: this.widget._passwordController,
                            //  obscureText: true,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.withOpacity(0.6)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "* Email",
                style: TextStyle(color: Colors.black),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: TextField(
                            // controller: this.widget._passwordController,
                            //  obscureText: true,
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.withOpacity(0.6)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              Container(
                margin: const EdgeInsets.only(left: 4, right: 4, top: 30),
                alignment: Alignment.center,
                height: 35,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    ( Color(0xFF113f60)),
                    ( Color(0xFF113f60))
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 20),
                      blurRadius: 50,
                      color: Colors.white,
                    )
                  ],
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
