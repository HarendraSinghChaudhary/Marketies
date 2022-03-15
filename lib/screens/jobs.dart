// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_final_fields, unnecessary_new

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/controller/job_controller.dart';
import 'package:marketies/screens/job_details.dart';
import 'package:marketies/utils/constant.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class Jobs extends StatefulWidget {
  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  ScrollController _controller = new ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
      bool isRefresh = false;

  @override
  Widget build(BuildContext context) {
     FocusScope.of(context).unfocus();
    

    Get.lazyPut<JobController>(() => JobController());
    

    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "Jobs",
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
                            'Part Time',
                            style: GoogleFonts.cabin(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Full Time',
                            style: GoogleFonts.cabin(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Credit Line',
                            style: GoogleFonts.cabin(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Shop & Earn',
                            style: GoogleFonts.cabin(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ]),
                  preferredSize: Size.fromHeight(30.0)),
            ),
            body: 
            
            GetBuilder<JobController>(
              init: JobController(),
              
              builder: (value) => 
            
                  Get.find<JobController>().isLoading.value
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
                      TabBarView(
                        children: [
            
            
            
                          allData(),
                          partTimeData(),
                          fullTimeData(),
                          creditLineData(),
                          shopandearnData()
                        ],
                      )
                    ],
                  )
                  ))
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
      child: ListView(
        shrinkWrap: true,
        controller: _controller,
        children: [
          ListView.builder(
            shrinkWrap: true,
            controller: _controller ,
            physics: ScrollPhysics(),
            itemCount:
                Get.find<JobController>().jobList.length,
            itemBuilder:
                (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(
                        "/jobDetails?name=" +
                            Get.find<JobController>()
                                .jobList[index]
                                .title
                                .toString() +
                            "&image=" +
                            Get.find<JobController>()
                                .jobList[index]
                                .photo
                                .toString() +
                            "&jobType=" +
                            Get.find<JobController>()
                                .jobList[index]
                                .job_type
                                .toString() +
                            "&description=" +
                            Get.find<JobController>()
                                .jobList[index]
                                .description
                                .toString() +
                            "&jobId=" +
                            Get.find<JobController>()
                                .jobList[index]
                                .id
                                .toString(),
                        // "/getData?channel=First video&content= flutter X"
                      );
                    },
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
    
                        borderRadius:
                            BorderRadius.circular(10),
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
                                // "assets/images/profilepic.jpeg"
                                Get.find<JobController>()
                                    .jobList[index]
                                    .photo
                                    .toString()),
                          ),
                          title: Text(
                            // "Job Name",
    
                            Get.find<JobController>()
                                .jobList[index]
                                .title
                                .toString(),
                            style: GoogleFonts.cabin(
                              fontSize: 17,
                            ),
                          ),
                          subtitle: Padding(
                            padding:
                                EdgeInsets.only(top: 4.0),
                            child: Text(
                              // "Full Time",
                              Get.find<JobController>()
                                  .jobList[index]
                                  .job_type
                                  .toString(),
                              style: GoogleFonts.cabin(
                                fontSize: 14,
                                color: kSubtitleColor,
                              ),
                            ),
                          ),
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
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView fullTimeData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List>(
              future: getfullTime(),
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

                          //  itemCount: jobController.jobList.indexWhere((element) => element['job_type'].toString()=='Full Time').toString().length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                 InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      "/jobDetails?name=" +
                                         snapshot.data![index]
                                              .title
                                              .toString() +
                                          "&image=" +
                                          snapshot.data![index]
                                              .photo
                                              .toString() +
                                          "&jobType=" +
                                         snapshot.data![index]
                                              .job_type
                                              .toString() +
                                          "&description=" +
                                         snapshot.data![index]
                                              .description
                                              .toString() +
                                          "&jobId=" +
                                        snapshot.data![index]
                                              .id
                                              .toString(),
                                      // "/getData?channel=First video&content= flutter X"
                                    );
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
                                            // "assets/images/profilepic.jpeg"
                                            snapshot.data![index].photo
                                                .toString(),
                                          ),
                                        ),
                                        title: Text(
                                          // "Job Name",
                                          snapshot.data![index].title
                                              .toString(),
                                          //jobController.jobList[jobController.jobList.indexWhere((element) => element['job_type'].toString()=='Full Time')].title.toString(),
                                          style: GoogleFonts.cabin(
                                            fontSize: 17,
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            // "Full Time",
                                            snapshot.data![index].job_type
                                                .toString(),
                                            style: GoogleFonts.cabin(
                                              fontSize: 14,
                                              color: kSubtitleColor,
                                            ),
                                          ),
                                        ),
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
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView partTimeData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List>(
              future: getpartTime(),
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

                          //  itemCount: jobController.jobList.indexWhere((element) => element['job_type'].toString()=='Full Time').toString().length,
                          itemBuilder: (BuildContext context, int index) {
                            print("snapshot: " +
                                snapshot.data!.length.toString());
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      "/jobDetails?name=" +
                                         snapshot.data![index]
                                              .title
                                              .toString() +
                                          "&image=" +
                                          snapshot.data![index]
                                              .photo
                                              .toString() +
                                          "&jobType=" +
                                         snapshot.data![index]
                                              .job_type
                                              .toString() +
                                          "&description=" +
                                         snapshot.data![index]
                                              .description
                                              .toString() +
                                          "&jobId=" +
                                        snapshot.data![index]
                                              .id
                                              .toString(),
                                      // "/getData?channel=First video&content= flutter X"
                                    );
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
                                            // "assets/images/profilepic.jpeg"
                                            snapshot.data![index].photo
                                                .toString(),
                                          ),
                                        ),
                                        title: Text(
                                          // "Job Name",
                                          snapshot.data![index].title
                                              .toString(),
                                          //jobController.jobList[jobController.jobList.indexWhere((element) => element['job_type'].toString()=='Full Time')].title.toString(),
                                          style: GoogleFonts.cabin(
                                            fontSize: 17,
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            // "Full Time",
                                            snapshot.data![index].job_type
                                                .toString(),
                                            style: GoogleFonts.cabin(
                                              fontSize: 14,
                                              color: kSubtitleColor,
                                            ),
                                          ),
                                        ),
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
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView creditLineData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List>(
              future: creditLine(),
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

                          //  itemCount: jobController.jobList.indexWhere((element) => element['job_type'].toString()=='Full Time').toString().length,
                          itemBuilder: (BuildContext context, int index) {
                            print("snapshot: " +
                                snapshot.data!.length.toString());
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      "/jobDetails?name=" +
                                         snapshot.data![index]
                                              .title
                                              .toString() +
                                          "&image=" +
                                          snapshot.data![index]
                                              .photo
                                              .toString() +
                                          "&jobType=" +
                                         snapshot.data![index]
                                              .job_type
                                              .toString() +
                                          "&description=" +
                                         snapshot.data![index]
                                              .description
                                              .toString() +
                                          "&jobId=" +
                                        snapshot.data![index]
                                              .id
                                              .toString(),
                                      // "/getData?channel=First video&content= flutter X"
                                    );
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
                                            // "assets/images/profilepic.jpeg"
                                            snapshot.data![index].photo
                                                .toString(),
                                          ),
                                        ),
                                        title: Text(
                                          // "Job Name",
                                          snapshot.data![index].title
                                              .toString(),
                                          //jobController.jobList[jobController.jobList.indexWhere((element) => element['job_type'].toString()=='Full Time')].title.toString(),
                                          style: GoogleFonts.cabin(
                                            fontSize: 17,
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            // "Full Time",
                                            snapshot.data![index].job_type
                                                .toString(),
                                            style: GoogleFonts.cabin(
                                              fontSize: 14,
                                              color: kSubtitleColor,
                                            ),
                                          ),
                                        ),
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
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  SingleChildScrollView shopandearnData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<List>(
              future: shopAndEarn(),
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

                          //  itemCount: jobController.jobList.indexWhere((element) => element['job_type'].toString()=='Full Time').toString().length,
                          itemBuilder: (BuildContext context, int index) {
                            print("snapshot: " +
                                snapshot.data!.length.toString());
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                 InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      "/jobDetails?name=" +
                                         snapshot.data![index]
                                              .title
                                              .toString() +
                                          "&image=" +
                                          snapshot.data![index]
                                              .photo
                                              .toString() +
                                          "&jobType=" +
                                         snapshot.data![index]
                                              .job_type
                                              .toString() +
                                          "&description=" +
                                         snapshot.data![index]
                                              .description
                                              .toString() +
                                          "&jobId=" +
                                        snapshot.data![index]
                                              .id
                                              .toString(),
                                      // "/getData?channel=First video&content= flutter X"
                                    );
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
                                            // "assets/images/profilepic.jpeg"
                                            snapshot.data![index].photo
                                                .toString(),
                                          ),
                                        ),
                                        title: Text(
                                          // "Job Name",
                                          snapshot.data![index].title
                                              .toString(),
                                          //jobController.jobList[jobController.jobList.indexWhere((element) => element['job_type'].toString()=='Full Time')].title.toString(),
                                          style: GoogleFonts.cabin(
                                            fontSize: 17,
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding: EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            // "Full Time",
                                            snapshot.data![index].job_type
                                                .toString(),
                                            style: GoogleFonts.cabin(
                                              fontSize: 14,
                                              color: kSubtitleColor,
                                            ),
                                          ),
                                        ),
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
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }


   void _onRefresh() async {
    
    setState(() {
      isRefresh = true;
    });

    await Get.find<JobController>().jobApi();
   
   setState(() {
     print("fnjkasnfs");
     isRefresh = false;
     
   
   });
  }





  Future<List> getfullTime() async {
    print("............");
    Get.lazyPut<JobController>(() => JobController());
    RxList<dynamic> _list = RxList.empty();
    print('........${Get.find<JobController>().jobList.length}');

    for (var i = 0; i < Get.find<JobController>().jobList.length; i++) {
      if (Get.find<JobController>().jobList[i].job_type == 'Full Time') {
        _list.add(Get.find<JobController>().jobList[i]);
      }
    }

    // print('this is the first Index : ${_list[0]}');
    // print('this is the first Index : ${_list.length}');

    return _list;
  }

  Future<List> getpartTime() async {
    print("............");
    Get.lazyPut<JobController>(() => JobController());
    RxList<dynamic> _list1 = RxList.empty();
    print('........${Get.find<JobController>().jobList.length}');

    for (var j = 0; j < Get.find<JobController>().jobList.length; j++) {
      if (Get.find<JobController>().jobList[j].job_type == 'Part Time') {
        _list1.add(Get.find<JobController>().jobList[j]);
      }
    }

    // print('this is the second Index : ${_list1[0]}');
    // print('this is the second Index : ${_list1.length}');

    return _list1;
  }

  Future<List> creditLine() async {
    print("............");
    Get.lazyPut<JobController>(() => JobController());
    RxList<dynamic> _list1 = RxList.empty();
    print('........${Get.find<JobController>().jobList.length}');

    for (var j = 0; j < Get.find<JobController>().jobList.length; j++) {
      if (Get.find<JobController>().jobList[j].job_type == 'Credit Line') {
        _list1.add(Get.find<JobController>().jobList[j]);
      }
    }

    // print('this is the second Index : ${_list1[0]}');
    // print('this is the second Index : ${_list1.length}');

    return _list1;
  }

  Future<List> shopAndEarn() async {
    print("............");
    Get.lazyPut<JobController>(() => JobController());
    RxList<dynamic> _list1 = RxList.empty();
    print('........${Get.find<JobController>().jobList.length}');

    for (var j = 0; j < Get.find<JobController>().jobList.length; j++) {
      if (Get.find<JobController>().jobList[j].job_type == 'Shop and Earn') {
        _list1.add(Get.find<JobController>().jobList[j]);
      }
    }

    // print('this is the second Index : ${_list1[0]}');
    // print('this is the second Index : ${_list1.length}');

    return _list1;
  }
}
