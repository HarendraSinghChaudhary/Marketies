// ignore_for_file: prefer_const_constructors, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/utils/constant.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _LoginState();
}

class _LoginState extends State<ResetPassword> {

  bool obscure1 = false;
  bool obscure = false;

  ScrollController _controller = new ScrollController();




  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
        body: Stack(
          children: [
          Container(
          width: double.infinity, height: 400, color: kLoginBackgroundColor),
          Padding(
        padding: EdgeInsets.only(top: 230),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Colors.white,
            image: DecorationImage(image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover
            )
          ),
          child: ListView(
            shrinkWrap: true,
            controller: _controller,
            children: [
              Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 00),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reset Password",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cabin(
                    height: 1.5,
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "New Password",
                  style: GoogleFonts.cabin(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              
                TextFormField(
                  obscureText: obscure,
                  // controller: donationController,
        
                  style: TextStyle(color: kTextFieldColor, fontSize: 14),
                  cursorColor: Colors.grey,
        
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top:20),
                    hintText: "Enter New Password",
                    hintStyle:
                        TextStyle(color: kTextFieldColor, fontSize: 14),
                    focusColor: kTextFieldColor,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                        icon: obscure
                            // ignore: dead_code
                            ? Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Confirm Password",
                  style: GoogleFonts.cabin(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  obscureText: obscure1,
                  // controller: donationController,
        
                  style: TextStyle(color: kTextFieldColor, fontSize: 14),
                  cursorColor: Colors.grey,
        
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top:20),
                    hintText: "Enter Confirm Password",
                    hintStyle:
                        TextStyle(color: kTextFieldColor, fontSize: 14),
                    focusColor: kTextFieldColor,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                        icon: obscure1
                            // ignore: dead_code
                            ? Icon(
                                Icons.visibility_off_outlined,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                        onPressed: () {
                          setState(() {
                            obscure1 = !obscure1;
                          });
                        }),
                  ),
                ),
               
                SizedBox(
                  height: 45,
                ),
                DefaultButton(
                    width: double.infinity,
                    height: 50,
                    text: "Reset Password",
                    press: () {
                      Get.toNamed("/login");
                    }),
                SizedBox(
                  height: 25,
                ),
              
              ],
            ),
          ),
            ],
          )
        ),
          ),
          Positioned(
        top: 125,
        left: 30,
        child: Image.asset(
          "assets/images/girl.png",
          width: 110,
        ),
          ),
          Positioned(
        top: 85,
        left: 220,
        child: Image.asset(
          "assets/images/logo2.png",
          width: 150,
        ),
          )
          ],
        ));
  }
}
