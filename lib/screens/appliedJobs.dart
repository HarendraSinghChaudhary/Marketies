// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_new

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/controller/applied_jobs_controller.dart';
import 'package:marketies/screens/create_lead.dart';
import 'package:marketies/utils/constant.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppliedJobs extends StatefulWidget {
  const AppliedJobs({Key? key}) : super(key: key);

  @override
  State<AppliedJobs> createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {

   RefreshController _refreshController =
      RefreshController(initialRefresh: false);
      bool isRefresh = false;

  

  @override
  void initState() {
    super.initState();
    Get.lazyPut<AppliedJobsController>(() => AppliedJobsController());
    runApi();
    
  }

void runApi()async {
  setState(() {
     Get.find<AppliedJobsController>().isLoading.value = true;
     isRefresh = false;
  });
  await Get.find<AppliedJobsController>().LeadsListApi();
   
  setState(() {
    Get.find<AppliedJobsController>().isLoading.value = false;
      isRefresh = false;
  });
}
  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();
    
    // final LeadsListController leadListController = Get.put(LeadsListController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Applied Jobs",
            style: GoogleFonts.cabin(color: Colors.black),
          ),
        ),
        body: GetBuilder<AppliedJobsController>(
          init: AppliedJobsController(),
          builder: (value) =>
        
        Get.find<AppliedJobsController>().isLoading.value
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
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: TextFormField(
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                            //controller: mesageTextController,
                            onChanged: (value) {
        
                              if(value.length==0){
 Get.find<AppliedJobsController>()
                                  .LeadsListApi();
                              }else{
                              if (value.isNotEmpty) {
        
                              Get.find<AppliedJobsController>()
                                  .searchData(value.toString());
        
                                
                              }else{
                                Get.find<AppliedJobsController>()
                                  .LeadsListApi();
                              }
        
                              }
        
        
                            },
                            validator: (val) {},
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 60),
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 60),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                              suffixIcon: InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 30,
                                  )
                                  //SvgPicture.asset("assets/icons/search.svg", width: 20, color: kPrimaryColor,)
                                  ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                       // Obx(
                         // () =>
                          
                           ListView.builder(
                            shrinkWrap: true,
                            controller: _controller,
                            itemCount: Get.find<AppliedJobsController>()
                                .leadList
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                           
                                      Get.toNamed("/createLead?jobId="+ 
                                        Get.find<AppliedJobsController>()
                                            .leadList[index]
                                            .job_id
                                            .toString() );
                           
                           
                           
                                      // Get.to(CreateLead(), arguments: [
                                      //   Get.find<AppliedJobsController>()
                                      //       .leadList[index]
                                      //       .job_id
                                      //       .toString(),
                                      // ]);
                                    },
                                    child: Container(
                                      height: 80,
                                      width: double.infinity,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26
                                                  .withOpacity(0.1),
                                              offset: Offset(1, 2),
                                              blurRadius: 1,
                                              spreadRadius: 0)
                                        ],
                                      ),
                                      child: Center(
                                        child: ListTile(
                                          horizontalTitleGap: 10,
                                          leading: CircleAvatar(
                                            radius: 25,
                                            //minRadius: 30,
                                            backgroundImage: NetworkImage(
                                                Get.find<AppliedJobsController>()
                                                                .leadList[index]
                                                                .photo
                                                                .toString() !=
                                                            "null" ||
                                                        Get.find<AppliedJobsController>()
                                                                .leadList[index]
                                                                .photo
                                                                .toString() !=
                                                            ""
                                                    ? Get.find<
                                                            AppliedJobsController>()
                                                        .leadList[index]
                                                        .photo
                                                        .toString()
                                                    : ""),
                                          ),
                                          title: Text(
                                            //"Job Name",
                                            Get.find<AppliedJobsController>()
                                                            .leadList[index]
                                                            .title
                                                            .toString() !=
                                                        "null" ||
                                                    Get.find<AppliedJobsController>()
                                                            .leadList[index]
                                                            .title
                                                            .toString() !=
                                                        ""
                                                ? Get.find<
                                                        AppliedJobsController>()
                                                    .leadList[index]
                                                    .title
                                                    .toString()
                                                : "User Not Found",
                           
                                            style: GoogleFonts.cabin(
                                              fontSize: 17,
                                            ),
                                          ),
                                          trailing: Icon(
                                            Icons.arrow_forward_ios,
                                            color: kSubtitleColor,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                                                   ),
                      //  )
                      ],
                    ),
                  ),
                ],
              )));
  }

 
   void _onRefresh() async {
    
    setState(() {
      isRefresh = true;
    });

    await Get.find<AppliedJobsController>().LeadsListApi();
   
   setState(() {
     print("fnjkasnfs");
     isRefresh = false;
     
   
   });

   isRefresh = false;



  }
}
