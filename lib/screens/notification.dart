// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_new

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/notificationService/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {

  // String title;

  // Notifications{(required this.title);}
 

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  List<String> titleList = [];



 List<String> bodyList= [];


@override
void initState() {
  super.initState();
  getData();
}

void getData() async{

  SharedPreferences preferences = await SharedPreferences.getInstance();
  titleList = preferences.getStringList("titleList")!;
  bodyList = preferences.getStringList("bodyList")!;

//  Iterable titleListt = titleList.reversed.cast<String>();
  
  setState(() {
    
  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Notifications",
            style: GoogleFonts.cabin(color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg.png"),
                      fit: BoxFit.cover)),
            ),
            ListView.builder(
              itemCount: titleList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withOpacity(0.5)),
                            child: Center(
                              child: Text(
                                titleList[index].substring(0,1).toUpperCase(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cabin(
                                
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 // "Birla Cement Added A Product",
                                 titleList[index].toString()=="null"?"":titleList[index].toString(),
                                  style: GoogleFonts.cabin(
                                      color: Colors.black,
                                      letterSpacing: 1,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  //"Hi! We have assigned you a new agent for your previous enquiry. They will message you shortly",
                                     bodyList[index].toString()=="null"?"":bodyList[index].toString(),
                                  style: GoogleFonts.cabin(
                                    color: Colors.black54,
                                    letterSpacing: 1,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Divider(
                      height: 5,
                      color: Colors.grey.withOpacity(0.7),
                    )
                  ],
                );
              },
            ),
          ],
        ));
  }
}
