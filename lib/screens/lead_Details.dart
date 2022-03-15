// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/utils/constant.dart';

class LeadDetails extends StatefulWidget {
  const LeadDetails({Key? key}) : super(key: key);

  @override
  State<LeadDetails> createState() => _LeadDetailsState();
}

class _LeadDetailsState extends State<LeadDetails> {
 final ScrollController _controller = new ScrollController();


  var leads ="";



  @override
  Widget build(BuildContext context) {

    // leads = Get.arguments;

    // print("new "+leads[0].toString());




  


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Lead Details",
          style: GoogleFonts.cabin(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 28,
            ),
            Container(width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        //minRadius: 30,
                        backgroundImage:
                            NetworkImage(Get.arguments[10].toString(),),
                      ),

                      SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        //"Job Name",

                         Get.arguments[9].toString(),

                        style: GoogleFonts.cabin(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        //"Full Time",

                        Get.arguments[12].toString(),
                        style: GoogleFonts.cabin(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                 
                
                 




                    ],
                  ),


                   Padding(
                    padding: EdgeInsets.only( top: 25),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: kRedColor, shape: BoxShape.circle),
                        ),
                        SizedBox(
                          width: 5,
                        ),



                          Get.arguments[8].toString() == "1" ?   Text(
                            
                            "Pending",
                            
                            style: GoogleFonts.cabin(
                                fontSize: 16,
                                color: Colors.orange,
                                ),) : 

                                 Get.arguments[8].toString() == "2" ?   Text(
                            
                            "Approved",
                            
                            style: GoogleFonts.cabin(
                                fontSize: 16,
                                color: kApprovedColor,
                                ),) : 

                                Get.arguments[8].toString() == "3" ?   Text(
                            
                            "Rejected",
                            
                            style: GoogleFonts.cabin(
                                fontSize: 16,
                                color: kRedColor,
                                ),)  : 
                                 Text(
                            
                            "Send for Audit",
                            
                            style: GoogleFonts.cabin(
                                fontSize: 16,
                                color: kApprovedColor,
                                ),) 




                       
                      ],
                    ),
                  )
                  
                 
                 
                 
                  
                
                
                ],
              ),
            ),


            SizedBox(height: 50,),


            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                   Text(
                        "Created Date",
                        style: GoogleFonts.cabin(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                       Text(
                        //"20-02-2021",

                        Get.arguments[7].toString().substring(0,10),
                        style: GoogleFonts.cabin(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),


                ],
              ),
            ),



            SizedBox(height: 12,),


            Divider(
              height: 5,
              thickness: 1,

            ),

             SizedBox(height: 12,),



            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                   Text(
                        "Name",
                        style: GoogleFonts.cabin(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                       Text(
                       // "John Doe",

                       Get.arguments[3].toString(),
                        style: GoogleFonts.cabin(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),


                ],
              ),
            ),



            SizedBox(height: 12,),


            Divider(
              height: 5,
              thickness: 1,

            ),

            SizedBox(height: 12,),



            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                   Text(
                        "Mobile",
                        style: GoogleFonts.cabin(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                       Text(
                       // "+1 23456789",

                       Get.arguments[4].toString(),
                        style: GoogleFonts.cabin(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),


                ],
              ),
            ),



            SizedBox(height: 12,),


            Divider(
              height: 5,
              thickness: 1,

            ),

            SizedBox(height: 12,),




            ListView.builder(
              itemCount: Get.arguments[14].length,

              shrinkWrap: true,
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [

                    Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                   Text(
                        Get.arguments[14][index].field_name.toString(),
                        style: GoogleFonts.cabin(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                       Text(
                        //"New York",
                         Get.arguments[14][index].field_value.toString(),
                        style: GoogleFonts.cabin(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),


                ],
              ),
            ),



             SizedBox(height: 12,),


            Divider(
              height: 5,
              thickness: 1,

            ),

            SizedBox(height: 12,),

                  ],
                );
              },
            ),



            



           

             SizedBox(height: 20,),

             Visibility(
               visible: Get.arguments[8].toString() == "2"  || Get.arguments[8].toString() == "3" ? true : false,
               child: Text(
                          "Remark",
                          style: GoogleFonts.cabin(
                              fontSize: 18, fontWeight: FontWeight.w700,
                              color: kRedColor),
                        ),
             ),

                      SizedBox(height: 10,),



                      Visibility(
                         visible: Get.arguments[8].toString() == "2"  || Get.arguments[8].toString() == "3" ? true : false,
                        child: Text(
                        //   "Lorem Ipsum is simply dummy text of the printing "
                        //  " \nand typesetting industry.",
                        Get.arguments[5].toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cabin(
                            height:1.5,
                              fontSize: 16, 
                              color: kRedColor),
                        ),
                      ),


          ],
        ),
      ),
    );
  }
}
