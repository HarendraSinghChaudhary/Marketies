// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class Privacy extends StatelessWidget {
  const Privacy({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
         
          iconTheme: IconThemeData(
          color: Colors.black, 
        ),
          title: Text(
            "Privacy Policy",
            style: GoogleFonts.cabin(color: Colors.black,),
                
          ),),


          body: Stack(
            children: [
                Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Colors.white,
            image: DecorationImage(image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover
            )
          ),),

             SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        """Privacy Policy""",
                        style: GoogleFonts.cabin(color: Colors.black, fontSize: 18, fontWeight:FontWeight.w600),
          
                            
                      ),

                       SizedBox(height: 10,),


                       Text(
                        """Growwings Solution (“we”/ “us”/ “our”/ “company”) operates this platforms website and app (marketies app) ( www.marketies.in ) which connects businesses to gig workers across pan India. 

If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.

Information Collection Purpose

For a better experience, while 
using our Service, we may require you to provide us with certain personally identifiable information. 

Information we collect:
Your Personal Information including your name, address, email id, phone number, date of birth, gender, job position, occupation, financial information, any other sensitive personal data or information etc

Non-personal information which may include your , IP address, your system details like OS version, internet browser & your telecom service provider etc.

Cookies

Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.
This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.

Service Providers

We may employ third-party companies and individuals due to the following reasons:
To facilitate our Service;
To provide the Service on our behalf;
To perform Service-related services; or
To assist us in analyzing how our Service is used.

Security

We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.

Children’s Privacy

These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.

Changes to This Privacy Policy

We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately after they are posted on this page.

If you have any concern related to this Privacy Policy or collection, storage, retention or disclosure of your information under the terms of this Privacy Policy or Terms of Use or any other terms and conditions of Marketies including any queries or grievances, you can contact to GROWWINGS SOLUTION below given details:
                                                                                                                                                                                                                                      
Contact No: +918302433923
E-mail: support@growwingssolution.in
Working Days: Monday to Saturday
Working Hours: 10:00 am to 7:00 pm                       
                        
                        """,
                        style: GoogleFonts.cabin(color: Colors.black54, fontSize: 14, height: 1.5, letterSpacing: 1 ),
          
                            
                      ),
                    ],
                  ),

                   
                ),
              ],
            ),
          ),

            ],
          )
          
        

      
    );
  }
}