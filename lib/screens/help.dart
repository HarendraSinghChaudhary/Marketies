// ignore_for_file: prefer_const_constructors

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/controller/help_controller.dart';
import 'package:marketies/controller/home_controller.dart';
import 'package:marketies/utils/constant.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();

    List<Map<String, String>> splashData = [
      {
        "title": "How To Complete KYC?",
        "subtitle":
            "First go to the more section and then click on kyc. Fill your kyc details like Adhaar and bank details, then click on the submit button."
      },
      {
        "title": "How to apply for a job? ",
        "subtitle":
            " Go to the jobs section and click on your favorite job, then click on the apply button at the bottom."
      },
      {
        "title": "How to create leads?  ",
        "subtitle":
            "First apply for jobs, then go to the leads section and then click on + icon, select one of your applied jobs, then fill out all details and create leads."
      },
      {
        "title": " How To Get Brand Referral Links? ",
        "subtitle":
            " To get brand referral links, first apply to your favorite job, then relax. Our team will call you and provide you with all the brand details and referral link."
      },
      {
        "title": "How To Change Bank Details? ",
        "subtitle":
            "You can't change your bank details from Marketies app but if you want to change bank details then contact our support team in our working hours."
      },
      {
        "title": "How To Change Password? ",
        "subtitle":
            "Go to more section and then click on the change password tab, enter your old password and create a new password."
      },
    ];

    final HelpController helpController = Get.put(HelpController());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Help & Support",
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
           
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Contact:",
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cabin(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Phone Number: +91 8302433923",
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cabin(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Email: support@growwingssolution.in",
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cabin(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(height: 24,),


                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                              "FAQs: ",
                              softWrap: true,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cabin(
                                  color: kPrimaryColor,
                                    decoration:
                                                TextDecoration.underline,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ),
                    ),




                    ListView.builder(
                      shrinkWrap: true,
                      controller: _controller,
                      itemCount: splashData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpandableNotifier(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            elevation: 0,
                            color: Colors.white,
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              children: <Widget>[
                                ScrollOnExpand(
                                  scrollOnExpand: true,
                                  scrollOnCollapse: false,
                                  child: ExpandablePanel(
                                    theme: const ExpandableThemeData(
                                      useInkWell: true,
                                      iconColor: kmenuColor,
                                      iconSize: 30,
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      tapBodyToCollapse: true,
                                    ),
                                    header: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          // "Lorem ipsum dolor sit amet?",
                                          splashData[index]["title"]
                                              .toString(),
                                          // faqList[index].question.toString(),
                                          style: GoogleFonts.cabin(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    collapsed: Text(
                                      //"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                      //faqList[index].answers.toString(),
                                        splashData[index]["subtitle"]
                                              .toString(),
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.cabin(
                                        color: Colors.black54,
                                        fontSize: 14,
                                      ),
                                    ),
                                    expanded: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        for (var _ in Iterable.generate(1))
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                  // "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",

                                                  // faqList[index].answers.toString(),
                                                    splashData[index]["subtitle"]
                                              .toString(),
                                                  softWrap: true,
                                                  overflow: TextOverflow.fade,
                                                  style: GoogleFonts.cabin(
                                                      color: Colors.black54,
                                                      fontSize: 14,
                                                      height: 1.5,
                                                      letterSpacing: 1))),
                                      ],
                                    ),
                                    builder: (_, collapsed, expanded) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: 12, right: 3, bottom: 5),
                                        child: Expandable(
                                          collapsed: collapsed,
                                          expanded: expanded,
                                          theme: const ExpandableThemeData(
                                              crossFadePoint: 0),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                      },
                    ),

                    SizedBox(height: 20,)
                  ],
                ),
              ),
            
          ],
        ));
  }
}
