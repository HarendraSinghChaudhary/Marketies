// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:marketies/components/new_testting.dart';
import 'package:marketies/controller/exit_controller.dart';
import 'package:marketies/controller/home_controller.dart';
import 'package:marketies/models/home_model.dart';
import 'package:marketies/screens/home.dart';
import 'package:marketies/screens/jobs.dart';
import 'package:marketies/screens/leads.dart';
import 'package:marketies/screens/login.dart';
import 'package:marketies/screens/menu.dart';
import 'package:marketies/screens/wallet.dart';
import 'package:marketies/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:marketies/models/slider_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeNav extends StatefulWidget {
  var index;

  HomeNav({required this.index});

  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  HomeController homeController = Get.put(HomeController());

  var user_status = "";
  bool isLoading = false;

  List<HomeModel> sliderList = [];

  int _index = 0;
  List widgets = <Widget>[
    Home(),
    //Scaffold(),
    Jobs(),
    Leads(), Wallet(),
    MoreMenu()
  ];

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _index = widget.index;

      homeController.HomeSliderApi();

      // runApi();
    }
  }

  // runApi() async {
  //   setState(() {});
  //   print("object>>>001");

  //   print("user status>>>>" + homeController.user_status.toString());

  //   if (user_status.toString() == "0") {
  //     await Get.offAll(Login());

  //     setState(() {});
  //   }
  // }

  //LanguageChange languageChange = new LanguageChange();
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

  @override
  Widget build(BuildContext context) {
    print("user status++++" + homeController.user_status.toString());

    var queryData = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: widgets.elementAt(_index),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            backgroundColor: Colors.white,
            currentIndex: _index,
            type: BottomNavigationBarType.fixed,
            // showSelectedLabels: true,
            selectedIconTheme: IconThemeData(color: kPrimaryColor),
            unselectedIconTheme: IconThemeData(color: Color(0xFF7A7A7A)),
            selectedLabelStyle: TextStyle(fontSize: 12, color: kPrimaryColor),
            unselectedLabelStyle:
                TextStyle(fontSize: 12, color: Color(0xFF7A7A7A)),
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: Color(0xFF7A7A7A),
            onTap: (page) {
              setState(() {
                _index = page;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  width: 23,
                  color: _index == 0 ? kPrimaryColor : kIconBackgroundColor,
                ),
                //dashboard
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/job.svg',
                    width: 25,
                    color: _index == 1 ? kPrimaryColor : kIconBackgroundColor,
                  ),

                  //Enquiry
                  label: "Jobs"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/recruitment.svg',
                    width: 23,
                    color: _index == 2 ? kPrimaryColor : kIconBackgroundColor,
                  ),

                  //Property
                  label: "Leads"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/wallet.svg',
                    width: 22,
                    color: _index == 3 ? kPrimaryColor : kIconBackgroundColor,
                  ),

                  //Menu
                  label: "Wallet"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/category.svg',
                    width: 20,
                    color: _index == 4 ? kPrimaryColor : kIconBackgroundColor,
                  ),

                  //Menu
                  label: "More")
            ]),
      ),
    );
  }


}
