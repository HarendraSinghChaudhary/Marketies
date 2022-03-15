// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class Terms extends StatelessWidget {
  const Terms({ Key? key }) : super(key: key);

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
            "Terms & Conditions",
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
                        "Terms & Conditions",
                        style: GoogleFonts.cabin(color: Colors.black, fontSize: 18, fontWeight:FontWeight.w600),
          
                            
                      ),

                       SizedBox(height: 10,),


                       Text(
                        """Introduction :
Welcome To Our  website –‘https://www.growwingssolution.in/’ ( “Website” )  or Marketies ( “App” ), are property of and managed by (“we”, “us” or “our”) Growwings Solution is a Proprietorship Firm Incorporated on 17/02/2022. By accessing and using Website/app in any way, including, without limitation, browsing the Website, using any information, using any content, any services, etc., available therein, you agree to and are bound by these Terms and Conditions. If you do not accept these Terms and Conditions  in full, please cease using this Website/app immediately.

Modification:
We reserve the right to update or modify these T&C at any time without prior notice. Your access to the Website and/or use of the services following any such change constitutes your agreement to follow and be bound by these T&C, as updated or modified. For this reason, we encourage you to review these T&C each time you access the Website and use the services.

Eligibility:
 (1) To use the Services, you agree that: (1) you must be of the “Minimum Age” (Minimum 18 Years Old) or older and (2) you will only have one Marketies account, which must be in your real name. Creating an account with false information is a violation of our terms, including accounts registered on behalf of others or persons under the age of 18.

(2) You represent and warrant that you are competent and eligible to enter into a legally binding agreement and be bound by these T&C. You shall not access the Website and use the services if you are not competent to contract under the applicable laws, rules and regulations.

(3) If you are using our app and website directly or indirectly, then you agree with our Terms and Conditions and Privacy Policy.

User Registration & Security:
You are required to register (“Registration”) on the “App” or “Website” to become a member and have access to your account. You are responsible for maintaining the confidentiality of your login credentials, your Registration details and are fully responsible for all activities that occur under your password or account. You agree to: (a) immediately notify us of any unauthorized use of your password or account or any other breach of security; and (b) ensure that you exit from your account at the end of each session. We cannot and will not be liable for any loss or damage arising. You are responsible for maintaining accurate, complete and up-to-date information in Your account at all times, all changes to your account information must be promptly updated in your account on the Website. If any information provided by you is inaccurate, not current or incomplete, we retain the right to suspend or terminate your account immediately without any further notice. You are responsible for keeping your account details and password and all other information concerning your account confidential. We are entitled to act on instructions received under your username and password. We will not be responsible for any credits or debits made to your account by someone else who uses your username or password. We will not be responsible for any losses or liabilities incurred through the use of your password by a third party. You are also responsible for reviewing your account balance on a regular basis, and for ensuring that all earnings have been properly credited to your account. If a discrepancy occurs between your purchase order with the affiliate merchant and your account, then you must contact us via our customer support within 15 days of the purchase/order date from an affiliate merchant. If you fail to contact us within the said 15 days period, such purchase/order shall be deemed to be accurate and no dispute shall be entertained.

User Communication and Obligations:
 Accepting these T&C, implies your express consent to be contacted by us, our agents, representatives, affiliates, partners or anyone calling on our behalf at any contact number, or electronic address provided by you while registering. You further agree to us contacting you in any manner, including without limitation, SMS messages (including text messages), calls using pre-recorded messages or artificial voice, calls and messages delivered using auto telephone dialing system or an automatic texting system, and notifications sent via the Website. Automated messages may be played when the telephone is answered whether by you or someone else. If an agent or representative calls, he or she may also leave a message on your answering machine, voice mail, or send one via SMS.  You certify, warrant and represent that the mobile number and email addresses and any other information that you have provided (at the time of registering on the Website and App ) to us are your own and not someone else’s and are true, accurate, current and complete. You represent that you are permitted to receive calls at the mobile number you have provided to us and email at the email address you have provided us. You agree to notify us whenever you stop using a mobile number and/or email address.

Intellectual Property Rights:
All of the content on our “Website” and “App”, including, without limitation, images, illustrations, graphics, audio clips, video clips or text, interface, reports generated, trademarks, tradenames, trade secrets ( “Website Content”), constitute our and our partners’ brand intellectual property. Copyright laws in all applicable jurisdictions protect the Website, services and the Website Content. 

Companies Rights and Roles :
(1)The Company reserves the right at any time to cancel, modify, or restrict any aspect of Users rewards programs, including any point conversion ratios, redemption offers, expiration terms, etc., and it reserves the right to apply such changes retroactively to rewards already accrued under any rewards program.

(2) The company reserves the right to hold and cancel your commission and earnings any time without giving any notice in case of any abnormality.

User Guidelines :
(1) You are responsible for any and all activities that occur in your Registration account. You agree to notify the Company immediately of any unauthorized use of the Registration account or any other breach of security. The Company shall not be liable for any loss to you or your organization owing to negligent actions or a failure on your part to inform the Company within a reasonable time, about loss or theft of your Device and/or any unauthorized access in your Registration account, either with or without your knowledge. You accept that any and all operations emanating from your Device shall be assumed to have been initiated by you.

(2) You shall be liable for losses incurred by the Company or any other party due to a third party’s use of the Registration account. You shall not use any other person’s account at any time, without the permission of the account holder and the Company. Log-in to your account shall be used by one person. Multiple people are not permitted to share the same/ single log-in.

(3) The Company shall make all reasonable efforts to ensure that your information is kept confidential. However, the Company shall not be responsible for any disclosure or leakage of confidential information and/or loss or damage of the Device due to theft, negligence or failure on your part to practice safe computing.

(4) You ensure that you will not cause any loss or damage  to the company and the name of the company will not be spoiled because of you. In this situation, the company can also take legal action against you.

(5) You ensure that the details you enter during (“Registration”) on our “App” and “Website” are your own and are accurate and active. And while doing (“Registration”) on our “App” and “Website  you were fully conscious, there was no pressure of any kind on you.

(6) You acknowledge that any and all actions and activities originating from your Device will be deemed to have been initiated by You.

Termination :
The Company may bock, restrict, disable, suspend or terminate the use of the services and your account at any time without giving any notice to you in case you are inter alia found to, be in breach of the terms of these T&C (including the Privacy Policy);  violate any applicable laws; infringing the intellectual property rights of any third party; (iv) be acting in a manner which may result into any claim against the Company.

Confidentiality :
You will not disclose any information provided to you including ideas, business model, processes, concepts etc. relating to the Company or the Website to any third party (“Confidential Information”) that has been disclosed to you or come into your knowledge at any time in accessing the Website or App.

Governing Law :
This Agreement and Privacy Policy, is governed as per the Indian Laws. You and we each submit to the non-exclusive jurisdiction of the Indian courts in relation to disputes arising in connection with this Agreement.

Contact Us:
Please feel free to contact us at +91 830681159, support@growwingssolution.in                      
                        
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