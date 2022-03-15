// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/controller/edit_profile_controller.dart';
import 'package:marketies/controller/home_controller.dart';
import 'package:marketies/utils/constant.dart';



class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstController = new TextEditingController();
  TextEditingController lastController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  bool isloading = false;

  String image = "";
  String base64Image = "";
  String fileName = "";
  File? files;
  bool isLoading = false;
  final picker = ImagePicker();











  @override
  Widget build(BuildContext context) {
     Get.lazyPut<EditProfileController>(() => EditProfileController());
     Get.lazyPut<HomeController>(() => HomeController());
     Get.find<HomeController>().first_name = firstController.text;

     Get.find<HomeController>().first_name = firstController.text;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Edit Profile",
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


            // Obx(() => 
            
            
            
            // )






            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Stack(
                        children: [
                          files == null
                              ? CircleAvatar(
                                  radius: 45,
                                  backgroundImage:
                                      NetworkImage(Get.find<HomeController>().image.toString()),
                                )
                              : CircleAvatar(
                                  radius: 45,
                                  backgroundImage: FileImage(File(files!.path)),
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
                                    border: Border.all(color: Colors.grey)),
                                child: Center(
                                    child: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                  size: 14,
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "First Name",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                             controller: firstController,

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
                              hintText: "Enter your first name",
                              hintStyle:
                                  TextStyle(color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Last Name",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                           controller: lastController,

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
                              hintText: "Enter your last name",
                              hintStyle:
                                  TextStyle(color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Phone Number",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
              
                             controller: mobileController,

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
              
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                           
              
                            decoration: InputDecoration(
                              hintText: "Enter your phone number",
                              hintStyle:
                                  TextStyle(color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Email",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            enabled: false,
                            keyboardType: TextInputType.emailAddress,
              
                            // controller: donationController,
              
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
              
                            decoration: InputDecoration(
                              hintText: Get.find<HomeController>().email.toString(),
                              hintStyle:
                                  TextStyle(color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          DefaultButton(
                              width: double.infinity,
                              height: 50,
                              text: "Save Profile",
                              press: () {

                                



                                 if (validateForm(_formKey) == true) {


                                   if (files == null) {

                                //          Get.find<EditProfileController>().editProfileApi(
                                //   firstController.text.toString(),
                                //   lastController.text.toString(),
                                //    mobileController.text.toString()
                                
                                   
                                  
                                //  );
                                     
                                   } else {

                                         Get.find<EditProfileController>().editProfileApiwithImage(
                                  firstController.text.toString(),
                                  lastController.text.toString(),
                                   mobileController.text.toString(), files!
                                
                                   
                                  
                                 );


                                   }

                                  
                                 
                                  

                                  print('validated');
                                }









              
                             
              
              
              
                              }),
              
                               SizedBox(height: 50,),
              
              
              
              
              
              
              
              
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          
          
          
          ],
        ));
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        files = File(pickedFile.path);
      });
      base64Image = base64Encode(files!.readAsBytesSync());
    } else {
      print('No image selected.');
    }

    fileName = files!.path.split("/").last;
    print("ImageName: " + fileName.toString() + "_");
    print("Image: " + base64Image.toString() + "_");
    setState(() {});
  }
}
