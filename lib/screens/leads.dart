import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/controller/get_lead_data_controller.dart';
import 'package:marketies/screens/lead_Details.dart';
import 'package:marketies/utils/constant.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Leads extends StatefulWidget {
  const Leads({Key? key}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Leads> {
    RefreshController _refreshController =
      RefreshController(initialRefresh: false);
      bool isRefresh = false;
  ScrollController _controller = new ScrollController();

  // final GetLeadDataController getLeadDataController =
  //     Get.put(GetLeadDataController());

  @override
  void initState() {
    super.initState();
     Get.lazyPut<GetLeadDataController>(() => GetLeadDataController());
     runApi();
  }

  void runApi()async{
    setState(() {
      Get.find<GetLeadDataController>().isLoading.value = true;
    });

    await Get.find<GetLeadDataController>().getLeadDataApi();

    setState(() {
      Get.find<GetLeadDataController>().isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Leads",
            style: GoogleFonts.cabin(color: Colors.black),
          ),
          bottom: PreferredSize(
              child: TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.white.withOpacity(0.3),
                  indicatorColor: kPrimaryColor,
                  // ignore: prefer_const_literals_to_create_immutables
                  tabs: [
                    Tab(
                      child: Text(
                        'All',
                        style: GoogleFonts.cabin(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Approved',
                        style: GoogleFonts.cabin(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Pending',
                        style: GoogleFonts.cabin(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Rejected',
                        style: GoogleFonts.cabin(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Send for Audit',
                        style: GoogleFonts.cabin(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ]),
              preferredSize: Size.fromHeight(30.0)),
        ),
        body: GetBuilder<GetLeadDataController>(
            init: GetLeadDataController(),
            builder: (value) =>

                // Obx(() =>

                // Get.find<GetLeadDataController>().getListDataList.length != 0
                    //?
                     Get.find<GetLeadDataController>().isLoading.value
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
                                        image:
                                            AssetImage("assets/images/bg.png"),
                                        fit: BoxFit.cover)),
                              ),
                              TabBarView(
                                children: <Widget>[
                                  allData(),
                                  getApprovedData(),
                                  getPendingData(),
                                  getRejectedData(),
                                  getAuditData(),
                                ],
                              ),
                            ],
                          )
                    // : Padding(
                    //   padding: const EdgeInsets.only(bottom: 80.0),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Image.asset("assets/images/nodata.png"),
                    //         Text(
                    //           "No leads available\n"
                    //           "Please create lead ....",
                    //           textAlign: TextAlign.center,
                    //           style: GoogleFonts.cabin(
                    //             fontSize: 21,
                    //             color: kRedColor,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    // )
                    
                    ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add, size: 35),
          onPressed: () {
            Get.toNamed("/appliedJobs");
          },
        ),
      ),
    );
  }

  SmartRefresher allData() {
    return SmartRefresher(
       enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                 onRefresh: _onRefresh,
                  onLoading: () {
          _refreshController.loadNoData();
        },
      child: ListView.builder(
         shrinkWrap: true,
        controller: _controller ,
        physics: ScrollPhysics(),
        itemCount: Get.find<GetLeadDataController>().getListDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.to(LeadDetails(), arguments: [
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .id
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .user_id
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .job_id
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .name
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .mobile
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .reason
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .points
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .created_at
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .status
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .title
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .photo
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .description
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .job_type
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .status1
                        .toString(),
                    Get.find<GetLeadDataController>()
                        .getListDataList[index]
                        .subLifeStyle,
                  ]);
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
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
                  child: Center(
                    child: ListTile(
                      horizontalTitleGap: 7,
                      leading: CircleAvatar(
                        radius: 30,
                        //minRadius: 30,
                        backgroundImage: NetworkImage(
                          Get.find<GetLeadDataController>()
                              .getListDataList[index]
                              .photo
                              .toString(),
                        ),
                      ),
                      title: Text(
                        // "Job Name",
    
                        Get.find<GetLeadDataController>()
                            .getListDataList[index]
                            .title
                            .toString(),
                        style: GoogleFonts.cabin(
                          fontSize: 17,
                        ),
                      ),
                      subtitle: Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child:
                              //"Approved",
    
                              Get.find<GetLeadDataController>()
                                          .getListDataList[index]
                                          .status
                                          .toString() ==
                                      "1"
                                  ? Text(
                                      "Pending",
                                      style: GoogleFonts.cabin(
                                        fontSize: 16,
                                        color: Colors.orange,
                                      ),
                                    )
                                  : Get.find<GetLeadDataController>()
                                              .getListDataList[index]
                                              .status
                                              .toString() ==
                                          "2"
                                      ? Text(
                                          "Approved",
                                          style: GoogleFonts.cabin(
                                            fontSize: 16,
                                            color: kApprovedColor,
                                          ),
                                        )
                                      : Get.find<GetLeadDataController>()
                                                  .getListDataList[index]
                                                  .status
                                                  .toString() ==
                                              "3"
                                          ? Text(
                                              "Rejected",
                                              style: GoogleFonts.cabin(
                                                fontSize: 16,
                                                color: kRedColor,
                                              ),
                                            )
                                          : Get.find<GetLeadDataController>()
                                                      .getListDataList[
                                                          index]
                                                      .status
                                                      .toString() ==
                                                  "4"
                                              ? Text(
                                                  "Send for Audit",
                                                  style: GoogleFonts.cabin(
                                                    fontSize: 16,
                                                    color: kApprovedColor,
                                                  ),
                                                )
                                              : Text(
                                                  "job Status invalid",
                                                  style: GoogleFonts.cabin(
                                                      fontSize: 16,
                                                      color:
                                                          Colors.blueGrey),
                                                )),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: kSubtitleColor,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }



   void _onRefresh() async {
    
    setState(() {
      isRefresh = true;
    });

    await Get.find<GetLeadDataController>().getLeadDataApi();
   
   setState(() {
     print("fnjkasnfs");
     isRefresh = false;
     
   
   });
  }

  SingleChildScrollView getApprovedData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List>(
              future: approved(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Padding(
                    padding: EdgeInsets.only(top: 130.0),
                    child: Center(
                      child: Image.asset("assets/images/nodata.png"),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return snapshot.data!.length.toString() == "0"
                      ? Padding(
                          padding: EdgeInsets.only(top: 130.0),
                          child: Center(
                            child: Image.asset("assets/images/nodata.png"),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: _controller,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(LeadDetails(), arguments: [
                                      snapshot.data![index].id.toString(),
                                      snapshot.data![index].user_id.toString(),
                                      snapshot.data![index].job_id.toString(),
                                      snapshot.data![index].name.toString(),
                                      snapshot.data![index].mobile.toString(),
                                      snapshot.data![index].reason.toString(),
                                      snapshot.data![index].points.toString(),
                                      snapshot.data![index].created_at
                                          .toString(),
                                      snapshot.data![index].status.toString(),
                                      snapshot.data![index].title.toString(),
                                      snapshot.data![index].photo.toString(),
                                      snapshot.data![index].description
                                          .toString(),
                                      snapshot.data![index].job_type.toString(),
                                      snapshot.data![index].status1.toString(),
                                      snapshot.data![index].subLifeStyle,
                                    ]);
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
                                    child: Center(
                                      child: ListTile(
                                        horizontalTitleGap: 7,
                                        leading: CircleAvatar(
                                          radius: 30,
                                          //minRadius: 30,
                                          backgroundImage: NetworkImage(
                                            snapshot.data![index].photo
                                                .toString(),
                                          ),
                                        ),
                                        title: Text(
                                          // "Job Name",
      
                                          snapshot.data![index].title
                                              .toString(),
                                          style: GoogleFonts.cabin(
                                            fontSize: 17,
                                          ),
                                        ),
                                        subtitle: Padding(
                                            padding: EdgeInsets.only(top: 4.0),
                                            child:
                                                //"Approved",
      
                                                snapshot.data![index].status
                                                            .toString() ==
                                                        "1"
                                                    ? Text(
                                                        "Pending",
                                                        style:
                                                            GoogleFonts.cabin(
                                                          fontSize: 16,
                                                          color: Colors.orange,
                                                        ),
                                                      )
                                                    : snapshot.data![index]
                                                                .status
                                                                .toString() ==
                                                            "2"
                                                        ? Text(
                                                            "Approved",
                                                            style: GoogleFonts
                                                                .cabin(
                                                              fontSize: 16,
                                                              color:
                                                                  kApprovedColor,
                                                            ),
                                                          )
                                                        : snapshot.data![index]
                                                                    .status
                                                                    .toString() ==
                                                                "3"
                                                            ? Text(
                                                                "Rejected",
                                                                style:
                                                                    GoogleFonts
                                                                        .cabin(
                                                                  fontSize: 16,
                                                                  color:
                                                                      kRedColor,
                                                                ),
                                                              )
                                                            : snapshot
                                                                        .data![
                                                                            index]
                                                                        .status
                                                                        .toString() ==
                                                                    "4"
                                                                ? Text(
                                                                    "Send for Audit",
                                                                    style: GoogleFonts
                                                                        .cabin(
                                                                      fontSize:
                                                                          16,
                                                                      color:
                                                                          kApprovedColor,
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    "Invalid Status Data",
                                                                    style: GoogleFonts
                                                                        .cabin(
                                                                      fontSize:
                                                                          16,
                                                                      color:
                                                                          kRedColor,
                                                                    ),
                                                                  )),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: kSubtitleColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }

  SingleChildScrollView getPendingData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List>(
              future: pending(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Padding(
                    padding: EdgeInsets.only(top: 130.0),
                    child: Center(
                      child: Image.asset("assets/images/nodata.png"),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return snapshot.data!.length.toString() == "0"
                      ? Padding(
                          padding: EdgeInsets.only(top: 130.0),
                          child: Center(
                            child: Image.asset("assets/images/nodata.png"),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: _controller,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(LeadDetails(), arguments: [
                                      snapshot.data![index].id.toString(),
                                      snapshot.data![index].user_id.toString(),
                                      snapshot.data![index].job_id.toString(),
                                      snapshot.data![index].name.toString(),
                                      snapshot.data![index].mobile.toString(),
                                      snapshot.data![index].reason.toString(),
                                      snapshot.data![index].points.toString(),
                                      snapshot.data![index].created_at
                                          .toString(),
                                      snapshot.data![index].status.toString(),
                                      snapshot.data![index].title.toString(),
                                      snapshot.data![index].photo.toString(),
                                      snapshot.data![index].description
                                          .toString(),
                                      snapshot.data![index].job_type.toString(),
                                      snapshot.data![index].status1.toString(),
                                      snapshot.data![index].subLifeStyle,
                                    ]);
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
                                    child: Center(
                                      child: ListTile(
                                        horizontalTitleGap: 7,
                                        leading: CircleAvatar(
                                          radius: 30,
                                          //minRadius: 30,
                                          backgroundImage: NetworkImage(
                                            snapshot.data![index].photo
                                                .toString(),
                                          ),
                                        ),
                                        title: Text(
                                          // "Job Name",

                                          snapshot.data![index].title
                                              .toString(),
                                          style: GoogleFonts.cabin(
                                            fontSize: 17,
                                          ),
                                        ),
                                        subtitle: Padding(
                                            padding: EdgeInsets.only(top: 4.0),
                                            child:
                                                //"Approved",

                                                snapshot.data![index].status
                                                            .toString() ==
                                                        "1"
                                                    ? Text(
                                                        "Pending",
                                                        style:
                                                            GoogleFonts.cabin(
                                                          fontSize: 16,
                                                          color: Colors.orange,
                                                        ),
                                                      )
                                                    : snapshot.data![index]
                                                                .status
                                                                .toString() ==
                                                            "2"
                                                        ? Text(
                                                            "Approved",
                                                            style: GoogleFonts
                                                                .cabin(
                                                              fontSize: 16,
                                                              color:
                                                                  kApprovedColor,
                                                            ),
                                                          )
                                                        : snapshot.data![index]
                                                                    .status
                                                                    .toString() ==
                                                                "3"
                                                            ? Text(
                                                                "Rejected",
                                                                style:
                                                                    GoogleFonts
                                                                        .cabin(
                                                                  fontSize: 16,
                                                                  color:
                                                                      kRedColor,
                                                                ),
                                                              )
                                                            : Text(
                                                                "Send for Audit",
                                                                style:
                                                                    GoogleFonts
                                                                        .cabin(
                                                                  fontSize: 16,
                                                                  color:
                                                                      kApprovedColor,
                                                                ),
                                                              )),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: kSubtitleColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }

  SingleChildScrollView getRejectedData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List>(
              future: rejected(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Padding(
                    padding: EdgeInsets.only(top: 130.0),
                    child: Center(
                      child: Image.asset("assets/images/nodata.png"),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return snapshot.data!.length.toString() == "0"
                      ? Padding(
                          padding: EdgeInsets.only(top: 130.0),
                          child: Center(
                            child: Image.asset("assets/images/nodata.png"),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: _controller,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(LeadDetails(), arguments: [
                                      snapshot.data![index].id.toString(),
                                      snapshot.data![index].user_id.toString(),
                                      snapshot.data![index].job_id.toString(),
                                      snapshot.data![index].name.toString(),
                                      snapshot.data![index].mobile.toString(),
                                      snapshot.data![index].reason.toString(),
                                      snapshot.data![index].points.toString(),
                                      snapshot.data![index].created_at
                                          .toString(),
                                      snapshot.data![index].status.toString(),
                                      snapshot.data![index].title.toString(),
                                      snapshot.data![index].photo.toString(),
                                      snapshot.data![index].description
                                          .toString(),
                                      snapshot.data![index].job_type.toString(),
                                      snapshot.data![index].status1.toString(),
                                      snapshot.data![index].subLifeStyle,
                                    ]);
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
                                    child: Center(
                                      child: ListTile(
                                        horizontalTitleGap: 7,
                                        leading: CircleAvatar(
                                          radius: 30,
                                          //minRadius: 30,
                                          backgroundImage: NetworkImage(
                                            snapshot.data![index].photo
                                                .toString(),
                                          ),
                                        ),
                                        title: Text(
                                          // "Job Name",

                                          snapshot.data![index].title
                                              .toString(),
                                          style: GoogleFonts.cabin(
                                            fontSize: 17,
                                          ),
                                        ),
                                        subtitle: Padding(
                                            padding: EdgeInsets.only(top: 4.0),
                                            child:
                                                //"Approved",

                                                snapshot.data![index].status
                                                            .toString() ==
                                                        "1"
                                                    ? Text(
                                                        "Pending",
                                                        style:
                                                            GoogleFonts.cabin(
                                                          fontSize: 16,
                                                          color: Colors.orange,
                                                        ),
                                                      )
                                                    : snapshot.data![index]
                                                                .status
                                                                .toString() ==
                                                            "2"
                                                        ? Text(
                                                            "Approved",
                                                            style: GoogleFonts
                                                                .cabin(
                                                              fontSize: 16,
                                                              color:
                                                                  kApprovedColor,
                                                            ),
                                                          )
                                                        : snapshot.data![index]
                                                                    .status
                                                                    .toString() ==
                                                                "3"
                                                            ? Text(
                                                                "Rejected",
                                                                style:
                                                                    GoogleFonts
                                                                        .cabin(
                                                                  fontSize: 16,
                                                                  color:
                                                                      kRedColor,
                                                                ),
                                                              )
                                                            : Text(
                                                                "Send for Audit",
                                                                style:
                                                                    GoogleFonts
                                                                        .cabin(
                                                                  fontSize: 16,
                                                                  color:
                                                                      kApprovedColor,
                                                                ),
                                                              )),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: kSubtitleColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }

  SingleChildScrollView getAuditData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List>(
              future: audit(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Padding(
                    padding: EdgeInsets.only(top: 130.0),
                    child: Center(
                      child: Image.asset("assets/images/nodata.png"),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return snapshot.data!.length.toString() == "0"
                      ? Padding(
                          padding: EdgeInsets.only(top: 130.0),
                          child: Center(
                            child: Image.asset("assets/images/nodata.png"),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: _controller,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(LeadDetails(), arguments: [
                                      snapshot.data![index].id.toString(),
                                      snapshot.data![index].user_id.toString(),
                                      snapshot.data![index].job_id.toString(),
                                      snapshot.data![index].name.toString(),
                                      snapshot.data![index].mobile.toString(),
                                      snapshot.data![index].reason.toString(),
                                      snapshot.data![index].points.toString(),
                                      snapshot.data![index].created_at
                                          .toString(),
                                      snapshot.data![index].status.toString(),
                                      snapshot.data![index].title.toString(),
                                      snapshot.data![index].photo.toString(),
                                      snapshot.data![index].description
                                          .toString(),
                                      snapshot.data![index].job_type.toString(),
                                      snapshot.data![index].status1.toString(),
                                      snapshot.data![index].subLifeStyle,
                                    ]);
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
                                    child: Center(
                                      child: ListTile(
                                        horizontalTitleGap: 7,
                                        leading: CircleAvatar(
                                          radius: 30,
                                          //minRadius: 30,
                                          backgroundImage: NetworkImage(
                                            snapshot.data![index].photo
                                                .toString(),
                                          ),
                                        ),
                                        title: Text(
                                          // "Job Name",

                                          snapshot.data![index].title
                                              .toString(),
                                          style: GoogleFonts.cabin(
                                            fontSize: 17,
                                          ),
                                        ),
                                        subtitle: Padding(
                                            padding: EdgeInsets.only(top: 4.0),
                                            child:
                                                //"Approved",

                                                snapshot.data![index].status
                                                            .toString() ==
                                                        "1"
                                                    ? Text(
                                                        "Pending",
                                                        style:
                                                            GoogleFonts.cabin(
                                                          fontSize: 16,
                                                          color: Colors.orange,
                                                        ),
                                                      )
                                                    : snapshot.data![index]
                                                                .status
                                                                .toString() ==
                                                            "2"
                                                        ? Text(
                                                            "Approved",
                                                            style: GoogleFonts
                                                                .cabin(
                                                              fontSize: 16,
                                                              color:
                                                                  kApprovedColor,
                                                            ),
                                                          )
                                                        : snapshot.data![index]
                                                                    .status
                                                                    .toString() ==
                                                                "3"
                                                            ? Text(
                                                                "Rejected",
                                                                style:
                                                                    GoogleFonts
                                                                        .cabin(
                                                                  fontSize: 16,
                                                                  color:
                                                                      kRedColor,
                                                                ),
                                                              )
                                                            : Text(
                                                                "Send for Audit",
                                                                style:
                                                                    GoogleFonts
                                                                        .cabin(
                                                                  fontSize: 16,
                                                                  color:
                                                                      kApprovedColor,
                                                                ),
                                                              )),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: kSubtitleColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ],
      ),
    );
  }

  Future<List> approved() async {
    print("............");
    final GetLeadDataController getLeadDataController =
        Get.put(GetLeadDataController());
    RxList<dynamic> _list = RxList.empty();
    print('........${getLeadDataController.getListDataList.length}');

    for (var i = 0; i < getLeadDataController.getListDataList.length; i++) {
      if (getLeadDataController.getListDataList[i].status.toString() == '2') {
        _list.add(getLeadDataController.getListDataList[i]);
      }
    }

    // print('this is the first Index : ${_list[0]}');

    return _list;
  }

  Future<List> pending() async {
    print("............");
    final GetLeadDataController getLeadDataController =
        Get.put(GetLeadDataController());
    RxList<dynamic> _list = RxList.empty();
    print('........${getLeadDataController.getListDataList.length}');

    for (var i = 0; i < getLeadDataController.getListDataList.length; i++) {
      if (getLeadDataController.getListDataList[i].status.toString() == "1") {
        _list.add(getLeadDataController.getListDataList[i]);
      }
    }

    return _list;
  }

  Future<List> rejected() async {
    print("............");
    final GetLeadDataController getLeadDataController =
        Get.put(GetLeadDataController());
    RxList<dynamic> _list = RxList.empty();
    print('........${getLeadDataController.getListDataList.length}');

    for (var i = 0; i < getLeadDataController.getListDataList.length; i++) {
      if (getLeadDataController.getListDataList[i].status.toString() == "3") {
        _list.add(getLeadDataController.getListDataList[i]);
      }
    }

    // print('this is the first Index : ${_list[0]}');
    // print('this is the first Index : ${_list.length}');

    return _list;
  }

  Future<List> audit() async {
    print("............");
    final GetLeadDataController getLeadDataController =
        Get.put(GetLeadDataController());
    RxList<dynamic> _list = RxList.empty();
    print('........${getLeadDataController.getListDataList.length}');

    for (var i = 0; i < getLeadDataController.getListDataList.length; i++) {
      if (getLeadDataController.getListDataList[i].status.toString() == '4') {
        _list.add(getLeadDataController.getListDataList[i]);
      }
    }

    // print('this is the first Index : ${_list[0]}');
    // print('this is the first Index : ${_list.length}');

    return _list;
  }

  Future<void> _refresh() async {}
}
