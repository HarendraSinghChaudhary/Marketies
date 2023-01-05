// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:marketies/Testing/binding_class.dart';
import 'package:marketies/Testing/controller_my.dart';
import 'package:marketies/Testing/get_data.dart';
import 'package:marketies/Testing/send_data.dart';
import 'package:marketies/notificationService/local_notification_service.dart';
import 'package:marketies/screens/bank_details.dart';
import 'package:marketies/screens/change_password.dart';
import 'package:marketies/screens/create_lead.dart';
import 'package:marketies/screens/edit_profile.dart';
import 'package:marketies/screens/forgot_password.dart';
import 'package:marketies/screens/help.dart';
import 'package:marketies/screens/home.dart';
import 'package:marketies/screens/homenav.dart';
import 'package:marketies/screens/id_card.dart';
import 'package:marketies/screens/introduction.dart';
import 'package:marketies/screens/job_details.dart';
import 'package:marketies/screens/jobs.dart';
import 'package:marketies/screens/kyc_detail_1.dart';
import 'package:marketies/screens/lead_Details.dart';
import 'package:marketies/screens/appliedJobs.dart';
import 'package:marketies/screens/leads.dart';
import 'package:marketies/screens/login.dart';
import 'package:marketies/screens/menu.dart';
import 'package:marketies/screens/notification.dart';
import 'package:marketies/screens/onboarding/p_login.dart';
import 'package:marketies/screens/otp.dart';
import 'package:marketies/screens/otp_signup.dart';
import 'package:marketies/screens/privacy.dart';
import 'package:marketies/screens/reset_password.dart';
import 'package:marketies/screens/signup.dart';
import 'package:marketies/screens/splash.dart';
import 'package:marketies/screens/termsandcondition.dart';
import 'package:marketies/screens/wallet.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("handlor data: " + message.data.toString());
  print("handlor notification: " + message.notification!.title.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();

  runApp(const Marketies());
}

class Marketies extends StatefulWidget {
  const Marketies({Key? key}) : super(key: key);

  @override
  _MarketiesState createState() => _MarketiesState();
}

class _MarketiesState extends State<Marketies> {
  var title = "";

  List<String> notificationList = [];

  @override
  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("fist Type" +
            FirebaseMessaging.instance.getInitialMessage.toString());
        if (message != null) {
          print("fist Type" +
              FirebaseMessaging.instance.getInitialMessage.toString());
          print("New Notification");

          if (message.notification != null) {
            Map<String, dynamic> map = Map();
            map["title"] = message.notification!.title.toString();
            map["body"] = message.notification!.body.toString();
            createListMap(map);
          } else if (message.data != null) {
            createListMap(message.data);
          }

          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("second Type " + FirebaseMessaging.onMessage.listen.toString());
        if (message.notification != null) {
          print("second Type " + FirebaseMessaging.onMessage.listen.toString());
          print(message.notification!.title);

          print(message.notification!.body);
          notificationList.add(message.notification!.title.toString());
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

          if (message.notification != null) {
            Map<String, dynamic> map = Map();
            map["title"] = message.notification!.title.toString();
            map["body"] = message.notification!.body.toString();
            createListMap(map);
          } else if (message.data != null) {
            createListMap(message.data);
          }
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("third Type " +
            FirebaseMessaging.onMessageOpenedApp.listen.toString());
        if (message.notification != null) {
          print("third Type" +
              FirebaseMessaging.onMessageOpenedApp.listen.toString());
          print(message.notification!.title);
          title = message.notification!.title.toString();
          print(message.notification!.body);
          notificationList.add(message.notification!.title.toString());
          print("message.data22 ${message.data['_id']}");

          print("title three: " + title.toString());

          if (message.notification != null) {
            Map<String, dynamic> map = Map();
            map["title"] = message.notification!.title.toString();
            map["body"] = message.notification!.body.toString();
            createListMap(map);
          } else if (message.data != null) {
            createListMap(message.data);
          }
        }
      },
    );

    print("title one: " + title.toString());

    print("list: " + notificationList.toString());
  }

  Future<void> createListMap(Map<String, dynamic> map) async {
    print("ListSaveMap");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? titleList = preferences.getStringList('titleList');
    List<String>? bodyList = preferences.getStringList('bodyList');
    List<String>? isReadList = preferences.getStringList('isRead');
    // List<String>? idList = preferences.getStringList('idList');

    // List<String> timeList = preferences.getStringList('timeList');
    if (titleList != null && bodyList != null && isReadList != null
        // && idList!=null
        ) {
      titleList.add(map["title"].toString());
      bodyList.add(map["body"].toString());

      isReadList.add("false");
      preferences.setStringList("titleList", titleList);
      preferences.setStringList("bodyList", bodyList);

      // preferences.setStringList("idList", idList);

      //  preferences.setStringList("timeList", timeList);
      preferences.commit();
    } else {
      List<String> titleListNew = [];
      List<String> bodyListNew = [];
      List<String> isReadListNew = [];
      List<String> idList = [];

      titleListNew.add(map["title"].toString());
      bodyListNew.add(map["body"].toString());

      // if(map.containsKey("id")) {
      //   idList.add(map["id"].toString());
      // }else{
      //   idList.add("");

      // }

      isReadListNew.add("false");

      preferences.setStringList("titleList", titleListNew);
      preferences.setStringList("bodyList", bodyListNew);
      preferences.setStringList("isRead", isReadListNew);

      // preferences.setStringList("idList", idList);

      preferences.commit();
    }
    print("title: " + preferences.getStringList("titleList").toString());
    print("body: " + preferences.getStringList("bodyList").toString());

    // getNotify();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialBinding: AllControllerBinding(),

      locale: Locale('en', 'US'),
      fallbackLocale: Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: pBackgroundColor),
      title: "Marketies",
      initialRoute: "/",
      home: Plogin(),

      getPages: [
        GetPage(name: "/", page: () => Marketies()),
        GetPage(
            name: "/homeNav",
            page: () => HomeNav(
                  index: 0,
                )),
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/jobs", page: () => Jobs()),
        GetPage(
            name: "/leads",
            page: () => Leads(),
            transition: Transition.leftToRight),
        GetPage(name: "/wallet", page: () => Wallet()),
        GetPage(name: "/more", page: () => MoreMenu()),
        GetPage(name: "/privacy", page: () => Privacy()),
        GetPage(name: "/terms", page: () => Terms()),
        GetPage(name: "/help", page: () => Help()),
        GetPage(name: "/changePassword", page: () => ChangePassword()),
        GetPage(name: "/notifications", page: () => Notifications()),
        GetPage(name: "/jobDetails", page: () => JobDetails()),
        GetPage(name: "/appliedJobs", page: () => AppliedJobs()),
        GetPage(name: "/leads", page: () => Leads()),
        GetPage(name: "/createLead", page: () => CreateLead()),
        GetPage(name: "/leadDetails", page: () => LeadDetails()),
        GetPage(name: "/editProfile", page: () => EditProfile()),
        GetPage(name: "/idCard", page: () => IdCard()),
        GetPage(name: "/kyc1", page: () => KYCDetails1()),
        GetPage(name: "/bankDetails", page: () => BankDetails()),
        GetPage(name: "/introduction", page: () => Introduction()),
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/signup", page: () => SignUp()),
        GetPage(name: "/forgotPassword", page: () => ForgotPassword()),
        GetPage(name: "/otp", page: () => Otp()),
        GetPage(name: "/resetPassword", page: () => ResetPassword()),
        GetPage(name: "/otpSignup", page: () => OtpSignup()),
        GetPage(
            name: "/getData",
            page: () => GetData(),
            transition: Transition.topLevel),
        GetPage(
            name: "/sendData",
            page: () => SendData(),
            transition: Transition.upToDown),
      ],
    );
  }
}

class messageClass {
  var id = "";
  var title = "";
  var description = "";
}
