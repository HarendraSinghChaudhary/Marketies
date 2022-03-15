// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/controller/home_controller.dart';
import 'package:marketies/controller/kyc_controller.dart';
import 'package:marketies/controller/withdrawal_controller.dart';
import 'package:marketies/screens/bank_details.dart';
import 'package:marketies/utils/constant.dart';

class KYCDetails1 extends StatefulWidget {
  const KYCDetails1({Key? key}) : super(key: key);

  @override
  _KYCDetails1State createState() => _KYCDetails1State();
}

class _KYCDetails1State extends State<KYCDetails1> {

  bool  isLoading = false;
  TextEditingController pancardController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String image = "";
  String base64Image = "";
  String filePanName = "";
  String fileAadharFrontName = "";
  String fileAadharBackName = "";

  File? filePan;
  File? fileAadharFront;
  File? fileAadharBack;

  var iSLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<KycController>(() => KycController());
    Get.lazyPut<HomeController>(() => HomeController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "KYC Details",
            style: GoogleFonts.cabin(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
              child: Visibility(
                visible: true,
                
                // Get.find<HomeController>().kycStatus.toString() == "0"
                    // ? true
                    // : false,
                child: InkWell(
                  onTap: () {
                    Get.toNamed("/homeNav");
                  },
                  child: Text(
                    "Skip >",
                    style: GoogleFonts.cabin(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
                            "Pan Card Number",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            maxLength: 10,
                            controller: pancardController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter pan card.';
                              }

                              if (val.length != 10) {
                                return 'Please enter valid pan card number';
                              }

                              return null;
                            },
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter Pan Card Number",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Pan Card Photo",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              getPanImage();
                            },
                            child: filePan == null
                                ? Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kkycPrimeColor,
                                        border: Border.all(
                                            color: kkycSecondaryColor)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/upload.png",
                                          width: 80,
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          "Upload Pan Card",
                                          style: GoogleFonts.cabin(
                                              color: kkycSecondaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kkycPrimeColor,
                                      border:
                                          Border.all(color: kkycSecondaryColor),
                                      image: DecorationImage(
                                          image: FileImage(
                                        File(filePan!.path),
                                      )),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Aadhar Number",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            maxLength: 12,
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter aadhar card number.';
                              }

                              if (val.length != 12) {
                                return 'Please enter valid aadhar card number';
                              }

                              return null;
                            },
                            controller: aadharController,
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter Aadhar Number",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Aadhar Photo",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              getAadharFrontImage();
                            },
                            child: fileAadharFront == null
                                ? Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kkycPrimeColor,
                                        border: Border.all(
                                            color: kkycSecondaryColor)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/upload.png",
                                          width: 80,
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          "Aadhar Front Photo",
                                          style: GoogleFonts.cabin(
                                              color: kkycSecondaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kkycPrimeColor,
                                      border:
                                          Border.all(color: kkycSecondaryColor),
                                      image: DecorationImage(
                                          image: FileImage(
                                        File(fileAadharFront!.path),
                                      )),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              getAadharBackImage();
                            },
                            child: fileAadharBack == null
                                ? Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kkycPrimeColor,
                                        border: Border.all(
                                            color: kkycSecondaryColor)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/upload.png",
                                          width: 80,
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          "Aadhar Front Photo",
                                          style: GoogleFonts.cabin(
                                              color: kkycSecondaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kkycPrimeColor,
                                      border:
                                          Border.all(color: kkycSecondaryColor),
                                      image: DecorationImage(
                                          image: FileImage(
                                        File(fileAadharBack!.path),
                                      )),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 30,
                          ),


                           isLoading
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Platform.isAndroid
                                      ? CircularProgressIndicator()
                                      : CupertinoActivityIndicator())
                              :



                          DefaultButton(
                              width: double.infinity,
                              height: 50,
                              text: "Next",
                              press: () {
                                if (validateForm(_formKey) == true) {
                                  if (filePan != null) {

                                    setState(() {

                                      isLoading = true;
                                      

                                    });

                                    if (fileAadharFront != null) {


                                      if (fileAadharBack != null) {


                                        // Get.toNamed("/bankDetails")










                                         Get.to(BankDetails(), arguments: [
                                    pancardController.text,
                                    filePan,
                                    aadharController.text,
                                    fileAadharFront,
                                    fileAadharBack
                                  ]);
                                        
                                      } else {

                                          Fluttertoast.showToast(
                                        msg: "Please upload back aadhar photo",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: kPrimaryColor,
                                        textColor: Colors.white,
                                        fontSize: 14.0);

                                        //   setState(() {
                                        //   isLoading = false;
                                        // });



                                      }
                                      
                                    } else {

                                       Fluttertoast.showToast(
                                        msg: "Please upload front aadhar photo",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: kPrimaryColor,
                                        textColor: Colors.white,
                                        fontSize: 14.0);

                                        //   setState(() {
                                        //   isLoading = false;
                                        // });


                                    }



                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please upload pan card photo",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: kPrimaryColor,
                                        textColor: Colors.white,
                                        fontSize: 14.0);


                                        setState(() {
                                          isLoading = false;
                                        });
                                  }

                                    setState(() {
                                          isLoading = false;
                                        });

                                 

                                  print('validated');
                                }
                                // Get.toNamed("/bankDetails?panCard="+pancardController.text.toString() +"&panCardImage="+filePanName.toString()+"&aadharNumber="+aadharController.text.toString()+"&aadharFrontImage="+fileAadharFrontName.toString()+"&aadharBackImage="+fileAadharBackName.toString(),
                              }),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future getPanImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    var panfile;

    if (pickedFile != null) {
      filePan = File(pickedFile.path);
      base64Image = base64Encode(filePan!.readAsBytesSync());
    } else {
      print('No image selected.');
    }

    // filePanName= filePan;

    panfile = filePan!.path.split("/").last;
    print("PanImageName: " + filePanName.toString() + "_");
    print("Image: " + base64Image.toString() + "_");

    setState(() {});
  }

  Future getAadharFrontImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      fileAadharFront = File(pickedFile.path);
      base64Image = base64Encode(fileAadharFront!.readAsBytesSync());
    } else {
      print('No image selected.');
    }

    fileAadharFrontName = fileAadharFront!.path.split("/").last;
    print("AadharFrontName: " + fileAadharFrontName.toString() + "_");
    print("Image: " + base64Image.toString() + "_");

    setState(() {});
  }

  Future getAadharBackImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      fileAadharBack = File(pickedFile.path);
      base64Image = base64Encode(fileAadharBack!.readAsBytesSync());
    } else {
      print('No image selected.');
    }

    fileAadharBackName = fileAadharBack!.path.split("/").last;
    print("AadharBackeName: " + fileAadharBackName.toString() + "_");
    print("Image: " + base64Image.toString() + "_");

    setState(() {});
  }
}
