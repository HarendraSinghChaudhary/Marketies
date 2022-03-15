// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/controller/forgot_password_controller.dart';
import 'package:marketies/utils/constant.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _LoginState();
}

class _LoginState extends State<ForgotPassword> {
  bool obscure1 = false;

  ScrollController _controller = new ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());

    return Scaffold(
        body:  Obx(() => 

                 Stack(
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
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg.png"),
                      fit: BoxFit.cover)),
              child: ListView(
                shrinkWrap: true,
                controller: _controller,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 00),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forgot Password",
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
                            "Email",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter email.';
                              }
                              if (!EmailValidator.validate(val)) {
                                return 'Please enter valid email.';
                              }
                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r"\s"))
                            ],
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter Email Id",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),


                           Get.find<ForgotPasswordController>().isLoading.value
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Platform.isAndroid
                                              ? CircularProgressIndicator()
                                              : CupertinoActivityIndicator())
                                      : 



                          DefaultButton(
                              width: double.infinity,
                              height: 50,
                              text: "Forgot Password",
                              press: () {

                                   if (validateForm(_formKey) == true) {
                                    Get.find<ForgotPasswordController>()
                                    .forgotPasswordApi(
                                        emailController.text.toString().trim());
                                }




                              
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: GoogleFonts.cabin(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.cabin(
                                      color: kPrimaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
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
                  top: 65,
                  left: 220,
                  child: Image.asset(
                    "assets/images/logo_final1.png",
                    width: 150,
                  ),
                )
      ],
    ))
 
        
        );
        
        

 
  }
}
