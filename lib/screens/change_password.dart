// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/controller/change_password_controller.dart';
import 'package:marketies/utils/constant.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPassword = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController confirmPassword = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscure = true;
  bool obscure1 = true;
  bool obscure2 = true;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,

          // ignore: prefer_const_constructors
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Change Password",
            style: GoogleFonts.cabin(color: Colors.black),
          ),
        ),
        body: Obx(() => Stack(
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Old Password",
                                style: GoogleFonts.cabin(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextFormField(
                                obscureText: obscure,
                                controller: oldPassword,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please enter old password';
                                  }

                                  return null;
                                },
                                style: TextStyle(
                                    color: kTextFieldColor, fontSize: 14),
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  hintText: "Enter Old Password",
                                  hintStyle: TextStyle(
                                      color: kTextFieldColor, fontSize: 14),
                                  focusColor: kTextFieldColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                      icon: obscure
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
                                obscureText: obscure1,
                                controller: newPassword,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please enter new password';
                                  }

                                  return null;
                                },
                                style: TextStyle(
                                    color: kTextFieldColor, fontSize: 14),
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  hintText: "Enter New Password",
                                  hintStyle: TextStyle(
                                      color: kTextFieldColor, fontSize: 14),
                                  focusColor: kTextFieldColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                      icon: obscure1
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
                                height: 25,
                              ),
                              Text(
                                "Confirm Password",
                                style: GoogleFonts.cabin(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              TextFormField(
                                obscureText: obscure2,
                                controller: confirmPassword,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please enter confirm password';
                                  }

                                  return null;
                                },
                                style: TextStyle(
                                    color: kTextFieldColor, fontSize: 14),
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  hintText: "Enter Confirm Password",
                                  hintStyle: TextStyle(
                                      color: kTextFieldColor, fontSize: 14),
                                  focusColor: kTextFieldColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                      icon: obscure2
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
                                          obscure2 = !obscure2;
                                        });
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),


                               Get.find<ChangePasswordController>().isLoading.value
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Platform.isAndroid
                                              ? CircularProgressIndicator()
                                              : CupertinoActivityIndicator())
                                      :




                              DefaultButton(
                                  width: double.infinity,
                                  height: 50,
                                  text: "SUBMIT",
                                  press: () {
                                    var old =
                                        oldPassword.text.toString().trim();
                                    var newPass =
                                        newPassword.text.toString().trim();
                                    var confirm =
                                        confirmPassword.text.toString().trim();

                                    if (validateForm(_formKey) == true) {
                                      if (newPass == confirm) {
                                        Get.find<ChangePasswordController>()
                                            .changePasswordApi(
                                                oldPassword.text
                                                    .toString()
                                                    .trim(),
                                                newPassword.text
                                                    .toString()
                                                    .trim());
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "New and confirm password should be same",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: kPrimaryColor,
                                            textColor: Colors.white,
                                            fontSize: 14.0);
                                      }

                                      print('validated');
                                    }
                                  })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
