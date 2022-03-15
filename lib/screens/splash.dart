// ignore_for_file: prefer_const_constructors, avoid_print, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/screens/homenav.dart';
import 'package:marketies/screens/introduction.dart';
import 'package:marketies/screens/login.dart';
import 'package:marketies/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String id = "";

  @override
  void initState() {
    getLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          // color: kPrimaryColor,
         
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(height: 200,),
                Image.asset("assets/images/logo-2.png",
                width: 200,
                ),
                
                 SizedBox(height: 210,),
                
                
                  Text("By",
                              style: GoogleFonts.cabin(
                                //  color: Colors.white,
                                 color: kPrimaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500)),
                
                
                                  SizedBox(height: 10,),
                
                                   Text("Growwings Solution",
                              style: GoogleFonts.cabin(
                                 // color: Colors.white,
                                 color: kPrimaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500)),
                
                                   SizedBox(height: 60,),
                
                
                                   Text("Earn Money Online, Part-Time Jobs",
                              style: GoogleFonts.cabin(
                                //  color: Colors.white,
                                 color: kPrimaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w100)),
                
                                   SizedBox(height: 40,),
                
                
                
              ],
            ),
          )
        ),
      ),
    );
  }

  getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString();
    var firstTime = true;
    firstTime = prefs.getBool("isFirstTimeLaunch")?? true;
    print("id :" + id.toString() + "^");

    Future.delayed(Duration(seconds: 2), () {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => IntdroductionScreen()));

      id.toString() == "" || id.toString() == "null" || id == ''
          ? firstTime != "null"?firstTime?
     Get.offAll(Introduction()):
     Get.offAll(Login()):
     Get.offAll(Login())
          : id.toString() == '72' ? Get.offAll(Login())
          :
           Get.offAll(HomeNav(index: 0,));
    });
  }
}