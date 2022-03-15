// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/controller/home_controller.dart';
import 'package:marketies/controller/wallet_controller.dart';
import 'package:marketies/controller/wallet_history_controller.dart';
import 'package:marketies/controller/withdrawal_controller.dart';
import 'package:marketies/models/home_model.dart';
import 'package:marketies/screens/kyc_detail_1.dart';
import 'package:marketies/utils/constant.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  // WalletHistoryController walletHistoryController =
  //     Get.put(WalletHistoryController());

  TextEditingController amountController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  HomeController homeController = Get.put((HomeController()));

  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    Get.lazyPut<WalletController>(() => WalletController());
    Get.lazyPut<WithdrawalController>(() => WithdrawalController());
    Get.lazyPut<WalletHistoryController>(() => WalletHistoryController());
    runApi();
  }

  void runApi() async {
    await Get.find<WalletController>().walletApi();
    await Get.find<WalletHistoryController>().walletHistoryApi();

    setState(() {
      Get.find<WalletController>().isLoading.value = false;
      Get.find<WalletHistoryController>().isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: GetBuilder<WalletController>(
        init: WalletController(),
        builder: (value) =>

            //   Obx(
            // () =>

            Get.find<WalletController>().isLoading.value
                ? Align(
                    alignment: Alignment.center,
                    child: Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator())
                : SafeArea(
                    child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Stack(
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    )),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
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
                                          Obx(
                                            () => Text(
                                              "₹" +
                                                  Get.find<WalletController>()
                                                      .totalAmount
                                                      .toString(),
                                              style: GoogleFonts.cabin(
                                                  color: Colors.white,
                                                  fontSize: 24),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "Total Earnings",
                                            style: GoogleFonts.cabin(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                      Center(
                                          child: SvgPicture.asset(
                                        "assets/icons/-wallet.svg",
                                        color: Colors.white,
                                        width: 44,
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                                        InkWell(
                                          onTap: () {
                                            // Get.to(MyHomePage());
                                          },
                                          child: Text(
                                            "₹" +
                                                Get.find<WalletController>()
                                                    .currentAmount
                                                    .toString(),
                                            style: GoogleFonts.cabin(
                                                color: Colors.black,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Available Balance",
                                          style: GoogleFonts.cabin(
                                              color: Colors.black,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Center(
                                        child: SvgPicture.asset(
                                      "assets/icons/-wallet.svg",
                                      color: kPrimaryColor,
                                      width: 44,
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Withdrawal Amount",
                                style: GoogleFonts.cabin(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: amountController,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please enter amount.';
                                    }

                                    return null;
                                  },
                                  style: TextStyle(
                                      color: kTextFieldColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                  cursorColor: Colors.grey,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    hintText: "Enter Amount",
                                    hintStyle: TextStyle(
                                        color: kTextFieldColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                    focusColor: kTextFieldColor,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              // GetBuilder<WalletController>(
                              //   init:WalletController(),
                              //   builder: (value) =>

                              Get.find<WalletController>().isLoading.value
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Platform.isAndroid
                                          ? CircularProgressIndicator()
                                          : CupertinoActivityIndicator())
                                  : SizedBox(
                                      width: 350,
                                      height: 50,
                                      child: FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        color: kPrimaryColor,
                                        onPressed: () async {
                                          if (validateForm(_formKey) == true) {
                                            var amount = int.parse(
                                                amountController.text
                                                    .toString());
                                            var available_amount = int.parse(
                                                Get.find<WalletController>()
                                                    .currentAmount
                                                    .toString());
                                            var kyc = homeController.kycStatus
                                                .toString();

                                            print("kyc show:" +
                                                Get.find<WalletController>()
                                                    .kycStatus
                                                    .toString());

                                            if (amount > 199) {
                                              if (amount < available_amount) {
                                                print("new kyc " +
                                                    kyc.toString());
                                                if (Get.find<WalletController>()
                                                        .kycStatus
                                                        .toString() ==
                                                    "1") {
                                                  print("again kyc " +
                                                      kyc.toString());

                                                  if (Get.find<
                                                              WalletHistoryController>()
                                                          .walletHistoryList !=
                                                      null) {
                                                    if (Get.find<
                                                                WalletHistoryController>()
                                                            .walletHistoryList
                                                            .length !=
                                                        0) {
                                                      if (Get.find<
                                                                  WalletHistoryController>()
                                                              .walletHistoryList
                                                              .first
                                                              .status
                                                              .toString() !=
                                                          "null") {
                                                        print("ncgn");
                                                        if (Get.find<
                                                                    WalletHistoryController>()
                                                                .walletHistoryList
                                                                .first
                                                                .status
                                                                .toString() ==
                                                            "0") {
                                                          Get.defaultDialog(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              title: "",

                                                              // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                                              content: Column(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    "assets/icons/pending.svg",
                                                                    width: 200,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                      "Your last withdrawal request is still pending",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts.cabin(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 140,
                                                                    height: 40,
                                                                    child:
                                                                        FlatButton(
                                                                      color:
                                                                          kPrimaryColor,
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20)),
                                                                      onPressed:
                                                                          () {
                                                                        Get.back();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Ok",
                                                                        style: GoogleFonts.cabin(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ));
                                                        
                                                        
                                                        
                                                        } else {
                                                          setState(() {});

                                                          Get.find<
                                                                  WalletHistoryController>()
                                                              .isLoading
                                                              .value = true;

                                                          Get.find<
                                                                  WithdrawalController>()
                                                              .withdrawalApi(
                                                                  amountController
                                                                      .text
                                                                      .toString());
                                                        }
                                                      } else {
                                                        setState(() {
                                                          print("Runnnvnd");
                                                        });

                                                        Get.find<
                                                                WalletHistoryController>()
                                                            .isLoading
                                                            .value = true;

                                                        Get.find<
                                                                WithdrawalController>()
                                                            .withdrawalApi(
                                                                amountController
                                                                    .text
                                                                    .toString());
                                                      }
                                                    } else {
                                                      setState(() {
                                                        print("Runnnvnd");
                                                      });

                                                      Get.find<
                                                              WalletHistoryController>()
                                                          .isLoading
                                                          .value = true;

                                                      Get.find<
                                                              WithdrawalController>()
                                                          .withdrawalApi(
                                                              amountController
                                                                  .text
                                                                  .toString());
                                                    }
                                                  } else {
                                                    setState(() {
                                                      print("Runnnvnd");
                                                    });

                                                    Get.find<
                                                            WalletHistoryController>()
                                                        .isLoading
                                                        .value = true;

                                                    Get.find<
                                                            WithdrawalController>()
                                                        .withdrawalApi(
                                                            amountController
                                                                .text
                                                                .toString());
                                                  }
                                                } else {
                                                  Get.defaultDialog(
                                                      contentPadding:
                                                          EdgeInsets.all(10),
                                                      title: "",

                                                      // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                                      content: Column(
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/icons/kyc.svg",
                                                            width: 200,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Please update your kyc",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: GoogleFonts.cabin(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          SizedBox(
                                                            width: 140,
                                                            height: 40,
                                                            child: FlatButton(
                                                              color:
                                                                  kPrimaryColor,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              onPressed: () {
                                                                // Get.to(
                                                                //     // KYCDetails1());

                                                                Get.back();
                                                              },
                                                              child: Text(
                                                                "Click here!",
                                                                style: GoogleFonts.cabin(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ));
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: 'insufficient balance',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        kPrimaryColor,
                                                    textColor: Colors.white,
                                                    fontSize: 14.0);
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Amount should be more than or equal to ₹200',
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.TOP,
                                                  timeInSecForIosWeb: 4,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }

                                            print('validated');
                                          }

                                          amountController.text = "";
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        },
                                        child: Text(
                                          "Payment Request",
                                          style: GoogleFonts.cabin(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),

                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 50,
                                child: AppBar(
                                  backgroundColor: Colors.white,
                                  bottom: TabBar(
                                      isScrollable: true,
                                      unselectedLabelColor:
                                          Colors.white.withOpacity(0.3),
                                      indicatorColor: kPrimaryColor,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            'Withdrawal',
                                            style: GoogleFonts.cabin(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Text(
                                              'Credited',
                                              style: GoogleFonts.cabin(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                              ),

                              GetBuilder<WalletHistoryController>(
                                init: WalletHistoryController(),
                                builder: (value) =>
                                    Get.find<WalletHistoryController>()
                                            .isLoading
                                            .value
                                        ? Align(
                                            alignment: Alignment.center,
                                            child: Platform.isAndroid
                                                ? CircularProgressIndicator()
                                                : CupertinoActivityIndicator())
                                        : Expanded(
                                            child: TabBarView(
                                              children: [
                                                // first tab bar view widget
                                                allData(),

                                                Get.find<WalletHistoryController>()
                                                        .isLoading
                                                        .value
                                                    ? Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Platform
                                                                .isAndroid
                                                            ? CircularProgressIndicator()
                                                            : CupertinoActivityIndicator())
                                                    : creditData()

                                                // Center(
                                                //   child: Text(
                                                //     'Successfull Payment',
                                                //   ),
                                                // ),

                                                // second tab bar viiew widget
                                              ],
                                            ),
                                          ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
      )),
    );
  }

  SingleChildScrollView allData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          ListView.builder(
            shrinkWrap: true,
            controller: _controller,
            itemCount:
                Get.find<WalletHistoryController>().walletHistoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 100,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.6))),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  //"29-12-2021, 04:02 AM",
                                  Get.find<WalletHistoryController>()
                                          .walletHistoryList[index]
                                          .created_at
                                          .toString()
                                          .substring(0, 10),
                                      //      +
                                      // " , " +
                                      // Get.find<WalletHistoryController>()
                                      //     .walletHistoryList[index]
                                      //     .created_at
                                      //     .toString()
                                      //     .substring(11, 16),
                                  style: GoogleFonts.cabin(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Withdrawal",
                                  style: GoogleFonts.cabin(
                                    fontSize: 14,
                                    color: kTextFieldColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                 Text(
                                  //"Withdrawal",

                                  "Transaction Id: "+Get.find<WalletHistoryController>()
                                          .walletHistoryList[index]
                                          .transaction_id.toString(),
                                  style: GoogleFonts.cabin(
                                    fontSize: 14,
                                    color: kTextFieldColor,
                                  ),
                                ),

                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "₹" +
                                      Get.find<WalletHistoryController>()
                                          .walletHistoryList[index]
                                          .amount
                                          .toString(),
                                  style: GoogleFonts.cabin(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Get.find<WalletHistoryController>()
                                            .walletHistoryList[index]
                                            .status
                                            .toString() ==
                                        "0"
                                    ? Text(
                                        "Pending",
                                        style: GoogleFonts.cabin(
                                          fontSize: 16,
                                          color: Colors.orange,
                                        ),
                                      )
                                    : Get.find<WalletHistoryController>()
                                                .walletHistoryList[index]
                                                .status
                                                .toString() ==
                                            "1"
                                        ? Text(
                                            "Successfull",
                                            style: GoogleFonts.cabin(
                                              fontSize: 16,
                                              color: kApprovedColor,
                                            ),
                                          )
                                        : Text(
                                            "Cancelled",
                                            style: GoogleFonts.cabin(
                                              fontSize: 16,
                                              color: kRedColor,
                                            ),
                                          )
                              ],
                            )
                          ],
                        ),
                      )),
                ],
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView creditData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          ListView.builder(
            shrinkWrap: true,
            controller: _controller,
            itemCount:
                Get.find<WalletHistoryController>().creditHistoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 100,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.6))),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  //"29-12-2021, 04:02 AM",
                                  Get.find<WalletHistoryController>()
                                          .creditHistoryList[index]
                                          .created_at
                                          .toString()
                                          .substring(0, 10),
                                          // +
                                      // " , " +
                                      // Get.find<WalletHistoryController>()
                                      //     .creditHistoryList[index]
                                      //     .created_at
                                      //     .toString()
                                      //     .substring(11, 16),
                                  style: GoogleFonts.cabin(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Earnings",
                                  style: GoogleFonts.cabin(
                                    fontSize: 14,
                                    color: kTextFieldColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                //   Text(
                                //   //"Withdrawal",

                                //   "Transaction Id: "+Get.find<WalletHistoryController>()
                                //           .creditHistoryList[index]
                                //           .transaction_id.toString(),
                                //   style: GoogleFonts.cabin(
                                //     fontSize: 14,
                                //     color: kTextFieldColor,
                                //   ),
                                // ),

                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "₹" +
                                      Get.find<WalletHistoryController>()
                                          .creditHistoryList[index]
                                          .amount
                                          .toString(),
                                  style: GoogleFonts.cabin(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Get.find<WalletHistoryController>()
                                            .creditHistoryList[index]
                                            .status
                                            .toString() ==
                                        "0"
                                    ? Text(
                                        "Pending",
                                        style: GoogleFonts.cabin(
                                          fontSize: 16,
                                          color: Colors.orange,
                                        ),
                                      )
                                    : Get.find<WalletHistoryController>()
                                                .creditHistoryList[index]
                                                .status
                                                .toString() ==
                                            "1"
                                        ? Text(
                                            "Successfull",
                                            style: GoogleFonts.cabin(
                                              fontSize: 16,
                                              color: kApprovedColor,
                                            ),
                                          )
                                        : Text(
                                            "Cancelled",
                                            style: GoogleFonts.cabin(
                                              fontSize: 16,
                                              color: kRedColor,
                                            ),
                                          )
                              ],
                            )
                          ],
                        ),
                      )),
                ],
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
