// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marketies/Testing/downloadfile.dart';
import 'package:marketies/controller/home_controller.dart';
import 'package:marketies/controller/home_slider_controller.dart';
import 'package:marketies/screens/homenav.dart';
import 'package:marketies/screens/login.dart';
import 'package:marketies/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    Get.lazyPut<HomeController>(() => HomeController());
    runApi();
  }

  void runApi() async {
    setState(() {
      Get.find<HomeController>().isLoading.value = true;
    });

    await Get.find<HomeController>().HomeSliderApi();

    setState(() {
      Get.find<HomeController>().isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  Get.lazyPut<HomeController>(() =>HomeController());

    print(
        "hbsdhjasbdhb..." + Get.find<HomeController>().user_status.toString());

    return Scaffold(
        body: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (value) {
              return Get.find<HomeController>().isLoading.value
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
                        Get.find<HomeController>().isLoading.value
                            ? Align(
                                alignment: Alignment.center,
                                child: Platform.isAndroid
                                    ? CircularProgressIndicator()
                                    : CupertinoActivityIndicator())
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 140,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )),
                                      child: Container(
                                        padding: EdgeInsets.only(top: 30),
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      // ignore: prefer_const_literals_to_create_immutables
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors
                                                                .black54
                                                                .withOpacity(
                                                                    0.5),
                                                            offset:
                                                                Offset(2, 2),
                                                            blurRadius: 10,
                                                            spreadRadius: 1)
                                                      ],
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              Get.find<
                                                                      HomeController>()
                                                                  .image
                                                                  .toString()),
                                                          fit: BoxFit.fill)),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Obx(() =>
                                                    // ),
                                                    Text(
                                                      //"John Doe",

                                                      Get.find<HomeController>()
                                                          .name
                                                          .toString(),
                                                      style: GoogleFonts.cabin(
                                                          color: Colors.white,
                                                          fontSize: 17),
                                                    ),

                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      // "johndoe@gmail.com",

                                                      Get.find<HomeController>()
                                                          .mobile
                                                          .toString(),

                                                      //  Get.find<HomeController>().email.toString(),
                                                      style: GoogleFonts.cabin(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.toNamed("/notifications");
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                child: Center(
                                                  child: Stack(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/icons/IconBell.svg",
                                                        width: 20,
                                                        color: Colors.white,
                                                      ),
                                                      Positioned(
                                                        left: 9,
                                                        bottom: 12,
                                                        child: Container(
                                                          height: 12,
                                                          width: 12,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white),
                                                              color: Colors.red,
                                                              shape: BoxShape
                                                                  .circle),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CustomSliderWidget(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      items:
                                          Get.find<HomeController>().sliderList,
                                      //  link: homeSliderController.linkUrl,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    // homeController.isLoading.value
                                    //       ? Align(
                                    //           alignment: Alignment.center,
                                    //           child: Platform.isAndroid
                                    //               ? CircularProgressIndicator()
                                    //               : CupertinoActivityIndicator())
                                    //       :
                                    Container(
                                      height: 80,
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                        borderRadius: BorderRadius.circular(10),
                                        // ignore: prefer_const_literals_to_create_immutables
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(2, 1),
                                              blurRadius: 2,
                                              spreadRadius: 0)
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 54,
                                              width: 54,
                                              decoration: BoxDecoration(
                                                color: kPinkColor,
                                                borderRadius:
                                                    BorderRadius.circular(9),
                                                // ignore: prefer_const_literals_to_create_immutables
                                              ),
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      "assets/icons/-wallet.svg",
                                                      color: Colors.white,
                                                      width: 30)),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "₹" +
                                                      Get.find<HomeController>()
                                                          .earning
                                                          .toString(),
                                                  //1,45,410",
                                                  style: GoogleFonts.cabin(
                                                      color: kPinkColor,
                                                      fontSize: 24),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "My Earnings",
                                                  style: GoogleFonts.cabin(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 80,
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                        borderRadius: BorderRadius.circular(10),
                                        // ignore: prefer_const_literals_to_create_immutables
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(2, 1),
                                              blurRadius: 2,
                                              spreadRadius: 0)
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  //"04",
                                                  Get.find<HomeController>()
                                                      .leads
                                                      .toString(),
                                                  style: GoogleFonts.cabin(
                                                      color: kCyanColor,
                                                      fontSize: 24),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Total Leads",
                                                  style: GoogleFonts.cabin(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                )
                                              ],
                                            ),
                                            Container(
                                              height: 54,
                                              width: 54,
                                              decoration: BoxDecoration(
                                                color: kCyanColor,
                                                borderRadius:
                                                    BorderRadius.circular(9),
                                                // ignore: prefer_const_literals_to_create_immutables
                                              ),
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                "assets/icons/recruitment-2.svg",
                                                color: Colors.white,
                                                width: 33,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Get.to(DownloadFile());
                                      },
                                      child: Container(
                                        height: 80,
                                        width: double.infinity,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                    
                                          borderRadius: BorderRadius.circular(10),
                                          // ignore: prefer_const_literals_to_create_immutables
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                offset: Offset(2, 1),
                                                blurRadius: 2,
                                                spreadRadius: 0)
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 54,
                                                width: 54,
                                                decoration: BoxDecoration(
                                                  color: kPurpleColor,
                                                  borderRadius:
                                                      BorderRadius.circular(9),
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                ),
                                                child: Center(
                                                    child: SvgPicture.asset(
                                                  "assets/icons/-newspapers.svg",
                                                  color: Colors.white,
                                                  width: 33,
                                                )),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    Get.find<HomeController>()
                                                        .jobs
                                                        .toString(),
                                                    //1,45,410",
                                                    style: GoogleFonts.cabin(
                                                        color: kPurpleColor,
                                                        fontSize: 24),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "Total Jobs",
                                                    style: GoogleFonts.cabin(
                                                        color: Colors.black,
                                                        fontSize: 18),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 0.5,
                                      height: 0.5,

                                    )
                                  ],
                                ),
                              )
                      ],
                    );
            })

//     floatingActionButton: FloatingActionButton(
//       onPressed: (){
//       var messaging = FirebaseMessaging.instance;
//                 messaging.getToken().then((value) {
// print(value);
//                 });
//     }
//     ),
        );
  }
}

class CustomSliderWidget extends StatefulWidget {
  // final List<String> items;
  final List items;

  CustomSliderWidget({required this.items});

  @override
  _CustomSliderWidgetState createState() => _CustomSliderWidgetState();
}

class _CustomSliderWidgetState extends State<CustomSliderWidget> {
  bool isloading = false;

  @override
  void initState() {
    super.initState();
  }

  int activeIndex = 0;
  setActiveDot(index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              onPageChanged: (index, reason) {
                setActiveDot(index);
              },
              enableInfiniteScroll: false,
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              autoPlayAnimationDuration: Duration(seconds: 2),
              // autoPlay: true,
              viewportFraction: 1,
            ),
            items: widget.items.map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      print("jdsfkdskfdkfbsd");
                      launchYoutube(item.link.toString());
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(item.banner_pic),
                          fit: BoxFit.fill,
                        ),
                      ),
                      // child: Image.asset(),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.items.length, (idx) {
              return activeIndex == idx ? ActiveDot() : InactiveDot();
            })),
      ],
    );
  }

  void launchYoutube(var url) async {
    print("launchingUrl: hgh");

    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    }
  }
}

class ActiveDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class InactiveDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
