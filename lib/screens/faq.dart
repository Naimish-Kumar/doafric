import 'package:flutter/material.dart';

class faqScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 237, 240, 244)),
          ),
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
                        }, icon: Icon(Icons.arrow_back_ios)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,



                      children: [
                        Text("                    Help Center",style: TextStyle(color: Colors.black,fontSize: 18),),

                        // Text('Notifications', textAlign: TextAlign.center, ),

                      ],
                    ),
                  ],
                ),


                SizedBox(
                  height: 20,
                ),





                Container(
                  width: 1500.0,
                  height: 160.0,
                  color: Color(0xFF113f60),


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(

                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " FAQs",
                                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                              ),



                              Row(
                                children: [
                                  // search button




                                  Text(
                                    "PLaced on 22-12-20, 10.15 ",
                                    style: TextStyle(fontSize: 11, color: Colors.grey,),
                                  ),



                                ],
                              ),







                            ],
                          ),
                        ],
                      ),



                    ],

                  ),
                ),










              ],
      ),
    ),
    ),
      ),
    );
  }
}
