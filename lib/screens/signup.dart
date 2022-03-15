// ignore_for_file: prefer_const_constructors, avoid_print, prefer_final_fields, unnecessary_new, use_key_in_widget_constructors, dead_code, use_function_type_syntax_for_parameters

import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/controller/signup_controller.dart';
import 'package:marketies/screens/otp_signup.dart';
import 'package:marketies/screens/termsandcondition.dart';
import 'package:marketies/utils/constant.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {
  bool agree = false;

  bool obscure1 = true;

  ScrollController _controller = new ScrollController();

  SignUpController jobController = Get.put(SignUpController());

  bool isloading = false;
  String image = "";
  String base64Image = "";
  String fileName = "";
  File? file;
  bool isLoading = false;
  final picker = ImagePicker();

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SignUpController>(() => SignUpController());
    return Scaffold(
        body: 


        Obx(() => 

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
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SignUp",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Obx(() => SizedBox(
                              //   height: 100,
                              //   width: 100,
                              //   child: Stack(
                              //     children: [
                              //       file == null
                              //           ? CircleAvatar(
                              //               radius: 45,
                              //               backgroundImage: AssetImage(
                              //                   "assets/images/profilepic.jpeg"),
                              //             )
                              //           : CircleAvatar(
                              //               radius: 45,
                              //               backgroundImage:
                              //                   FileImage(File(file!.path)),
                              //             ),
                              //       Positioned(
                              //         top: 55,
                              //         left: 70,
                              //         child: InkWell(
                              //           onTap: () {
                              //             Get.find<SignUpController>().getImage();
                              //           },
                              //           child: Container(
                              //             height: 25,
                              //             width: 25,
                              //             decoration: BoxDecoration(
                              //                 shape: BoxShape.circle,
                              //                 color: Colors.white,
                              //                 border: Border.all(
                              //                     color: Colors.grey
                              //                         .withOpacity(0.2))),
                              //             child: Center(
                              //                 child: Icon(
                              //               Icons.camera_alt,
                              //               color: Colors.grey,
                              //               size: 14,
                              //             )),
                              //           ),
                              //         ),
                              //       )
                              //     ],
                              //   ),
                              // ),)

                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    file == null
                                        ? CircleAvatar(
                                            radius: 45,
                                            backgroundImage: AssetImage(
                                                "assets/images/tr.jpeg"),
                                          )
                                        : CircleAvatar(
                                            radius: 45,
                                            backgroundImage:
                                                FileImage(File(file!.path)),
                                          ),
                                    Positioned(
                                      top: 55,
                                      left: 70,
                                      child: InkWell(
                                        onTap: () {
                                          getImage();
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey
                                                      .withOpacity(0.2))),
                                          child: Center(
                                              child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey,
                                            size: 14,
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "First Name",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: firstNameController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter first name';
                              }

                              return null;
                            },
                            maxLines: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"))
                            ],
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter Your First Name",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Last Name",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: lastNameController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter last name';
                              }

                              return null;
                            },
                            maxLines: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"))
                            ],
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter Your Last Name",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Mobile Number",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter phone number.';
                              }

                              if (val.length != 10) {
                                return 'Please enter valid phone number.';
                              }
                              return null;
                            },
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter Your Mobile Number",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 30,
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
                            keyboardType: TextInputType.emailAddress,
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
                            height: 30,
                          ),
                          Text(
                            "Password",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            obscureText: obscure1,
                            controller: passwordController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter password';
                              }

                            
                              return null;
                            },
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 22.0),
                                child: Checkbox(
                                    activeColor: Color(0xFFE9BC1D),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                    ),
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return kPrimaryColor;
                                      }
                                      return kPrimaryColor;
                                    }),
                                    value: agree,
                                    onChanged: (val) {
                                      setState(() {
                                        agree = val!;
                                      });
                                    }),
                              ),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                      text: "I have read and agreed to the ",
                                      style: GoogleFonts.cabin(
                                          height: 1.5,
                                          letterSpacing: 0.2,
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                      children: [
                              
                                        
                                        TextSpan(
                                          recognizer: new TapGestureRecognizer()..onTap = () {
                                            Get.to(Terms());
                                          },
                                          text: "Terms "
                                              "\n & Condition",
                                          style: GoogleFonts.cabin(
                                              color: kPrimaryColor,
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),



                              Get.find<SignUpController>().isLoading.value
                         
                  ? Align(
                      alignment: Alignment.center,
                      child: Platform.isAndroid
                          ? CircularProgressIndicator()
                          : CupertinoActivityIndicator())
                  :




                          DefaultButton(
                              width: double.infinity,
                              height: 50,
                              text: "Signup",
                              press: () {
                                

                                if (validateForm(_formKey) == true) {


                                  if (file == null) {
                                      print("WithoutImage");
                                      if (agree) {
                                      Get.find<SignUpController>().signupApi(
                                          firstNameController.text.toString(),
                                          lastNameController.text.toString(),
                                          mobileController.text.toString(),
                                          emailController.text
                                              .trim()
                                              .toString(),
                                          passwordController.text.toString(),
                                         );
                                    } else {
                                         
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please select Terms and condition",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: kPrimaryColor,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    }


                                    
                                  } else {
                                      print("WithImage");
                                      if (agree) {
                                      Get.find<SignUpController>().signupImageApi(
                                          firstNameController.text.toString(),
                                          lastNameController.text.toString(),
                                          mobileController.text.toString(),
                                          emailController.text
                                              .trim()
                                              .toString(),
                                          passwordController.text.toString(),
                                          file!
                                         );
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please select Terms and condition",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: kPrimaryColor,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    }


                                  }





                                   



                                  


                                  
                                 
                                  
                                  

                                  print('validated');
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
                          SizedBox(
                            height: 20,
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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
      base64Image = base64Encode(file!.readAsBytesSync());
    } else {
      file = File(pickedFile!.path);
      print('No image selected.');
    }

    // fileName = file!.path.split("/").last;
    print("ImageName: " + fileName.toString() + "_");
    print("Image: " + base64Image.toString() + "_");
    setState(() {});
  }
}
