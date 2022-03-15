// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/Testing/send_data.dart';
import 'package:marketies/controller/edit_profile_controller.dart';
import 'package:marketies/controller/home_controller.dart';
import 'package:marketies/controller/wallet_controller.dart';
import 'package:marketies/screens/home1.dart';

import 'package:marketies/utils/constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreMenu extends StatefulWidget {
  const MoreMenu({Key? key}) : super(key: key);

  @override
  _MoreMenuState createState() => _MoreMenuState();
}

class _MoreMenuState extends State<MoreMenu> {
  String image = "";
  String base64Image = "";
  String fileName = "";
  File? files;
  bool isLoading = false;
  final picker = ImagePicker();
  HomeController homeController = HomeController();
  void launchTelegram() async {
    String url = "https://t.me/Marketies";
    print("launchingUrl: $url");
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void launchYoutube() async {
    String url = "https://youtube.com/channel/UCK1KpjAqBopIW2XCRaHeWPA";
    print("launchingUrl: $url");
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

void runApi()async {
  Get.find<WalletController>().isLoading.value = true;
  await Get.find<WalletController>().walletApi();
  setState(() {
    Get.find<WalletController>().isLoading.value = false;
  });
}

@override
void initState() {
  super.initState();
   Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<WalletController>(() =>WalletController());
      runApi();
}

  @override
  Widget build(BuildContext context) {
   
  
    return Scaffold(
        body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (value) =>

                // Obx(() =>

                Get.find<HomeController>().isLoading.value
                    ? Align(
                        alignment: Alignment.center,
                        child: Platform.isAndroid
                            ? CircularProgressIndicator()
                            : CupertinoActivityIndicator())
                    : Stack(
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
                                Container(
                                  height: 280,
                                  width: double.infinity,
                          
                                  child: Stack(
                                    children: [
                                      ClipPath(
                                        clipper: MyClipper(),
                                        child: Container(
                                          width: double.infinity,
                                          height: 200,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 70.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                             
                                            
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                             
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 110,
                                                      child: Stack(
                                                        children: [
                                                          files == null
                                                              ? CircleAvatar(
                                                                  radius: 50,
                                                                  backgroundImage:
                                                                      NetworkImage(Get.find<
                                                                              HomeController>()
                                                                          .image
                                                                          .toString()),
                                                                )
                                                              : CircleAvatar(
                                                                  radius: 50,
                                                                  backgroundImage:
                                                                      FileImage(File(
                                                                          files!.path)),
                                                                ),
                                                          Positioned(
                                                            top: 60,
                                                            left: 80,
                                                            child: InkWell(
                                                              onTap: () {
                                                                getImage();
                                                              },
                                                              child: Container(
                                                                height: 25,
                                                                width: 25,
                                                                decoration: BoxDecoration(
                                                                    shape:
                                                                        BoxShape.circle,
                                                                    color: Colors.white,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey)),
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
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    // "John Doe",

                                                    Get.find<HomeController>()
                                                        .name
                                                        .toString(),
                                                    style: GoogleFonts.cabin(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                Text(
                                                  //"johndoe@gmail.com",

                                                  Get.find<HomeController>()
                                                      .email
                                                      .toString(),
                                                  style: GoogleFonts.cabin(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Positioned(
                                      //   top: 60,
                                      //   left: 290,
                                      //   child: InkWell(
                                      //     onTap: () {
                                      //       // Get.toNamed("/editProfile");
                                      //     },
                                      //     child: Text(
                                      //       "Edit Profile",
                                      //       style: GoogleFonts.cabin(
                                      //         color: Colors.white,
                                      //         fontSize: 17,
                                      //         decoration: TextDecoration.underline,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  color: kSliderColor,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 330.0),
                                    child: Center(
                                      child: Text("Menu",
                                          style: GoogleFonts.cabin(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/idCard");
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("ID Card",
                                            style: GoogleFonts.cabin(
                                                color: kmenuColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: kmenuColor,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: kmenuColor,
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {


                                      





                                    if (Get.find<WalletController>()
                                            .kycStatus
                                            .toString() ==
                                        "1") {

                                           



                                      Fluttertoast.showToast(
                                          msg: "Your KYC is approved",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: kPrimaryColor,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    } else if (Get.find<WalletController>()
                                            .kycStatus
                                            .toString() ==
                                        "0") { 
                                          Fluttertoast.showToast(
                                          msg: "Your KYC is pending",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: kPrimaryColor,
                                          textColor: Colors.white,
                                          fontSize: 14.0);


                                      
                                     
                                    }

                                    else{
                                       Get.toNamed("/kyc1");

                                    }
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("KYC",
                                            style: GoogleFonts.cabin(
                                                color: kmenuColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Row(
                                          children: [


                                              Get.find<WalletController>().isLoading.value
                    ? Align(
                        alignment: Alignment.center,
                        child: Platform.isAndroid
                            ? CircularProgressIndicator()
                            : CupertinoActivityIndicator())
                    :
                                            Get.find<WalletController>()
                                                        .kycStatus
                                                        .toString() ==
                                                    "1"
                                                ? Text("Approved",
                                                    style: GoogleFonts.cabin(
                                                        color: kApprovedColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700)) :

                                                            Get.find<WalletController>()
                                                        .kycStatus
                                                        .toString() ==
                                                    "2"
                                                ? Text("Rejected",
                                                    style: GoogleFonts.cabin(
                                                        color: kRedColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700))
                                                : Text("Pending",
                                                    style: GoogleFonts.cabin(
                                                        color:
                                                            Color(0xFFFA1100),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: kmenuColor,
                                              size: 18,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: kmenuColor,
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/changePassword");
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Change Password",
                                            style: GoogleFonts.cabin(
                                                color: kmenuColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: kmenuColor,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: kmenuColor,
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/help");
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Help And Support",
                                            style: GoogleFonts.cabin(
                                                color: kmenuColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: kmenuColor,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: kmenuColor,
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    launchTelegram();
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Join Us On Telegram",
                                            style: GoogleFonts.cabin(
                                                color: kmenuColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: kmenuColor,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: kmenuColor,
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    launchYoutube();
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Watch Training Video ",
                                            style: GoogleFonts.cabin(
                                                color: kmenuColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: kmenuColor,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: kmenuColor,
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/terms");
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Terms And Conditions",
                                            style: GoogleFonts.cabin(
                                                color: kmenuColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: kmenuColor,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: kmenuColor,
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/privacy");
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Privacy Policy",
                                            style: GoogleFonts.cabin(
                                                color: kmenuColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: kmenuColor,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: kmenuColor,
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                        contentPadding: EdgeInsets.all(10),
                                        title: "",

                                        // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                        content: Column(
                                          children: [
                                            Text(
                                                "Are you sure you want to "
                                                "\nLogout?",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.cabin(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: 140,
                                              height: 40,
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                color: kPrimaryColor,
                                                onPressed: () async {
                                                  var prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  prefs.setString('id', '');
                                                  prefs.setString('name', '');
                                                  prefs.setString(
                                                      'first_name', '');
                                                  prefs.setString('email', '');
                                                  prefs.setString(
                                                      'last_name', '');
                                                  prefs.setString('mobile', '');
                                                  prefs.setString(
                                                      'profile_pic', '');
                                                  prefs.setString(
                                                      'ranking', '');
                                                  prefs.setString(
                                                      'email_verified_at', '');
                                                  prefs.setString(
                                                      'created_at', '');
                                                  prefs.setString(
                                                      'total_wallet_amount',
                                                      '');
                                                  prefs.setString(
                                                      'current_wallet_amout',
                                                      '');
                                                  prefs.setString('status', '');

                                                  prefs.commit();

                                                  Get.offAllNamed("/login");
                                                },
                                                child: Text(
                                                  "Logout",
                                                  style: GoogleFonts.cabin(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: 140,
                                              height: 40,
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text(
                                                  "Cancel",
                                                  style: GoogleFonts.cabin(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                 
                                 
                                 
                                 
                                 
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Logout",
                                            style: GoogleFonts.cabin(
                                                color: kmenuColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700)),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: kmenuColor,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),

                                //    Divider(
                                //   color: kmenuColor,
                                //   height: 5,
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     Get.to(Home1());
                                //   },
                                //   child: Container(
                                //     margin:
                                //         EdgeInsets.symmetric(horizontal: 10),
                                //     height: 50,
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Text("Testing",
                                //             style: GoogleFonts.cabin(
                                //                 color: kmenuColor,
                                //                 fontSize: 16,
                                //                 fontWeight: FontWeight.w700)),
                                //         Icon(
                                //           Icons.arrow_forward_ios,
                                //           color: kmenuColor,
                                //           size: 18,
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // Divider(
                                //   color: kmenuColor,
                                //   height: 5,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      )));
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

    await Get.find<EditProfileController>().editProfileApiwithImage(
        Get.find<HomeController>().first_name.toString(),
        Get.find<HomeController>().last_name.toString(),
        Get.find<HomeController>().mobile.toString(),
        files!);
    setState(() {
      homeController.getData();
    });
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
