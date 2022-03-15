// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/controller/home_controller.dart';

class IdCard extends StatefulWidget {
  const IdCard({Key? key}) : super(key: key);

  @override
  _IdCardState createState() => _IdCardState();
}

class _IdCardState extends State<IdCard> {

   HomeController idController = Get.put(HomeController());




  @override
  Widget build(BuildContext context) {

    print("image: "+idController.image.toString());
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
            "Identity Card",
            style: GoogleFonts.cabin(color: Colors.black),
          ),
        ),
        body:


        Obx(() => 

         idController.isLoading.value
                         
                  ? Align(
                      alignment: Alignment.center,
                      child: Platform.isAndroid
                          ? CircularProgressIndicator()
                          : CupertinoActivityIndicator())
                  :



        

         Stack(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                // Center(
                //   child: Stack(
                //     children: [
                //       Image.asset("assets/images/card.png"),
                //       Positioned(
                //           top: 50,
                //           left: 20,
                //           child: Container(
                //             height: 105,
                //             width: 80,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(3),
                //                 color: Colors.red,
                //                 image: DecorationImage(
                //                     image: AssetImage(
                //                       "assets/images/user.png",
                //                     ),
                //                     fit: BoxFit.fill)),
                //           )),
                //       Positioned(
                //         top: 45,
                //         left: 112,
                //         child: Text(
                //           "IDENTITY CARD",
                //           style: GoogleFonts.cabin(
                //               letterSpacing: 1.0,
                //               color: Colors.black,
                //               fontWeight: FontWeight.w700,
                //               fontSize: 22),
                //         ),
                //       ),
                //       Positioned(
                //         left: 112,
                //         top: 77,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "Name:",
                //               style: GoogleFonts.cabin(
                //                   letterSpacing: 1.0,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 13),
                //             ),
                //             SizedBox(
                //               height: 5,
                //             ),
                //             Text(
                //               "Email:",
                //               style: GoogleFonts.cabin(
                //                   letterSpacing: 1.0,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 13),
                //             ),
                //             SizedBox(
                //               height: 5,
                //             ),
                //             Text(
                //               "Mobile:",
                //               style: GoogleFonts.cabin(
                //                   letterSpacing: 1.0,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 13),
                //             ),
                //             SizedBox(
                //               height: 5,
                //             ),
                //             Text(
                //               "Designation:",
                //               style: GoogleFonts.cabin(
                //                   letterSpacing: 1.0,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 13),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Positioned(
                //         left: 200,
                //         top: 77,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "John Doe",
                //               style: GoogleFonts.cabin(
                //                   letterSpacing: 1.0,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 13),
                //             ),
                //             SizedBox(
                //               height: 5,
                //             ),
                //             Text(
                //               "johndue@gmai.com",
                //               style: GoogleFonts.cabin(
                //                   letterSpacing: 1.0,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 13),
                //             ),
                //             SizedBox(
                //               height: 5,
                //             ),
                //             Text(
                //               "+1 23456789",
                //               style: GoogleFonts.cabin(
                //                   letterSpacing: 1.0,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 13),
                //             ),
                //             SizedBox(
                //               height: 5,
                //             ),
                //             Text(
                //               "Sales Executive",
                //               style: GoogleFonts.cabin(
                //                   letterSpacing: 1.0,
                //                   color: Colors.black,
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 13),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Positioned(
                //           top: 155,
                //           left: 270,
                //           child: Image.asset(
                //             "assets/images/logo.png",
                //           ))
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 100,
                // ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 230,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/images/id-card.png"),
                          fit: BoxFit.fill)),
                  child: Stack(children: [
                    Positioned(
                        left: 210,
                        top: 10,
                        child: Image.asset(
                          "assets/images/logo_final2.png",
                          width: 150,
                        )),
                    Positioned(
                      left: 50,
                      top: 70,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            //minRadius: 30,
                            backgroundImage:
                                NetworkImage(idController.image.toString()),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 17,
                              ),
                              Container(
                              
                                width: 220,
                                child: Text(
                                 // "John Doe",

                                 idController.name.toString(),
                                 maxLines: 2,
                                 overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.cabin(
                                      letterSpacing: 1.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "SALES PARTNER",
                                style: GoogleFonts.cabin(
                                    //  letterSpacing: 1.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 200,
                      child: Column(
                        children: [
                          Container(
                            width: 350,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/call.svg",
                                      width: 17,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                     // "+91 987654321",
                                     idController.mobile.toString(),
                                      style: GoogleFonts.cabin(
                                          //  letterSpacing: 1.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                    
                    
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/massega.svg",
                                      width: 20,
                                      color: Colors.white,
                                    ),

                                     SizedBox(width: 5,),
                                    Container(
                                      width: 170,
                                     
                                      child: Text(
                                       // "+91 987654321",

                                       idController.email.toString(),
                                        style: GoogleFonts.cabin(
                                            //  letterSpacing: 1.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                    
                        ],
                      ),
                    )
                  ]),
                )
              ],
            ),
          ],
        ))
 
        
        
        
        );
        
        
        
        
        
 
  }
}
