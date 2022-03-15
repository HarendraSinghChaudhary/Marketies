// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/controller/job_apply_controller.dart';
import 'package:marketies/utils/constant.dart';

class JobDetails extends StatelessWidget {

  var count = 0.obs;
//  var image, name, jobType;

//  JobDetails({required this.image, required this.name, required this.jobType});

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut<JobApplyController>(() => JobApplyController());
    print("jobOneId: "+Get.parameters['jobId'].toString());

     Get.lazyPut<JobApplyController>(() => JobApplyController());

    
    
   var one = Get.parameters;
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
          "Job Details",
          style: GoogleFonts.cabin(color: Colors.black),
        ),
      ),
      body: 

      Stack(
        children: [

             Container(
               
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        
            image: DecorationImage(image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover
            )
          ),),

           SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
              
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 40,
                    //minRadius: 30,
                    backgroundImage: NetworkImage(
                      //"assets/images/profilepic.jpeg"
                      one['image'].toString()
                      ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    // "Job Name",
                    one['name'].toString(),
                     
                      style: GoogleFonts.cabin(
                        color: Colors.black,
                        fontSize: 17,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                   // "Full Time",
                   one['jobType'].toString(),
                    style: GoogleFonts.cabin(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),


                  
                ],
              ),
            ),
         
       

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(

                    one['description'].toString(),
                     textAlign: TextAlign.start,
                       style: GoogleFonts.cabin(
                           height: 1.5, // the height between text, default is 1.0
                           letterSpacing: 1.0,
                           color: Colors.grey,
                           fontWeight: FontWeight.bold,
                           fontSize: 16),
                     ),
          ),


          SizedBox(height: 100,)



          ],
        ),

      ),

        ],
      ),
      
      
      
      
     
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton: InkWell(
         onTap: () {



   

            




           Get.find<JobApplyController>().jobApplyApi(one['jobId'].toString());
         },
         child: Container(
           color: kPrimaryColor,
          height: 65.0,
          width: double.infinity,
          child: Center(
            child: Text("Apply Now",
            style: GoogleFonts.cabin(
                         
                          color: Colors.white,
                          fontSize: 18),
            ),
          )
             ),
       ),

      
    );
  }
}
