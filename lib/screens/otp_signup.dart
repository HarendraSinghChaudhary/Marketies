// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/utils/constant.dart';

class OtpSignup extends StatefulWidget {
  @override
  State<OtpSignup> createState() => _LoginState();
}

class _LoginState extends State<OtpSignup> {

  bool obscure1 = false;

  ScrollController _controller = ScrollController();

     String? otp;

  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  TextEditingController fourth = TextEditingController();
  bool isloading = false;

  late FocusNode pin1FocusNode;
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin1FocusNode = FocusNode();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin1FocusNode.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }




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
                  "Verification",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cabin(
                    height: 1.5,
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                  SizedBox(height: 40,),



                Container(width: 600,
                child: Text.rich(
                                TextSpan(
                                    text: "OTP has been sent on your registered ",
                                    style: GoogleFonts.cabin(
                                        height: 1.5,
                                        letterSpacing: 0.2,
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600),
                                    children: [
                                      TextSpan(
                                        text: "Email Id ",
                                        
                                        style: GoogleFonts.cabin(
                                            color: Colors.black,
                                            fontSize: 18,
                                         
                                             
                                            fontWeight: FontWeight.w600),
                                      ),
                                       TextSpan(
                                        text: "john@gmail.com",
                                        
                                        style: GoogleFonts.cabin(
                                            color: kPrimaryColor,
                                            fontSize: 18,
                                           
                                            fontWeight: FontWeight.w600),
                                      )
                                    ]),
                              )
                ),


                SizedBox(height: 30,),



                  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 00),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: TextFormField(
                        maxLength: 1,
                        controller: first,
                        focusNode: pin1FocusNode,
                        autofocus: true,
                        obscureText: false,
                        style: TextStyle(fontSize: 24, color: Colors.black),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: "",
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              color: Color(0XFFE8E8E8),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          nextField(value, pin2FocusNode);
                          //previousField(value, pin2FocusNode);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: TextFormField(
                          maxLength: 1,
                          controller: second,
                          focusNode: pin2FocusNode,
                          obscureText: false,
                          style: TextStyle(fontSize: 24, color: Colors.black),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            counterText: "",
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: kPrimaryColor,
                                  ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: Color(0XFFE8E8E8),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            nextField(value, pin3FocusNode);
                            
                          }),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: TextFormField(
                          maxLength: 1,
                          controller: third,
                          focusNode: pin3FocusNode,
                          obscureText: false,
                          style: TextStyle(fontSize: 24, color: Colors.black),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            counterText: "",
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                 color: kPrimaryColor,
                                  ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: Color(0XFFE8E8E8),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            nextField(value, pin4FocusNode);
                            
                          }),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: TextFormField(
                        maxLength: 1,
                        controller: fourth,
                        focusNode: pin4FocusNode,
                        obscureText: false,
                        style: TextStyle(fontSize: 24, color: Colors.black),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: "",
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                                ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              color: Color(0XFFE8E8E8),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            pin4FocusNode.unfocus();
                            // Then you need to check is the code is correct or not
                          }
                        },
                      ),
                    ),
                  ]),
            ),


                 SizedBox(
                  height: 45,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't Recieve Code?",
                      style: GoogleFonts.cabin(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
        
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        // Get.toNamed("/signup");
                      },
                      child: Text(
                        "Resend Now",
                        style: GoogleFonts.cabin(
                            color: kPrimaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),


                SizedBox(
                  height: 25,
                ),
               
               
                DefaultButton(
                    width: double.infinity,
                    height: 50,
                    text: "Verify",
                    press: () {
                      Get.toNamed("/kyc1");
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
