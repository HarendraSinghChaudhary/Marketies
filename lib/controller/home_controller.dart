// ignore_for_file: non_constant_identifier_names, unused_local_variable, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:marketies/models/job_model.dart';
import 'package:marketies/models/slider_model.dart';
import 'package:marketies/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var id = "".obs;
  var name = "";
  var image = "";
  var email = "";
  var mobile = "";
  var first_name = "";
  var last_name = "";
  var totalBalance = "".obs;
  var availableBalance = "".obs;
  var kycStatus = "";
  RxString ranking = "".obs;

  RxList<dynamic> sliderUrl = [].obs;

  String earning = "";
  String leads = "";
  String jobs = "";
  String status = "";
  String user_status = "";

  RxList sliderList = [].obs;

  List<String> linkUrl = [];

  RxBool isLoading = false.obs;
  //  RxList jobList = [].obs;

  @override
  void onInit() {
    isLoading(true);
    getData();

    super.onInit();
  }

  getData() async {
    //isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    print("id Print: " + id.toString());
    id = id.toString();
    print("idsss" + id.toString());
    var name1 = prefs.getString("name");
    var first_name1 = prefs.getString("first_name");
    var email1 = prefs.getString("email");
    var last_name1 = prefs.getString("last_name");
    var mobile1 = prefs.getString("mobile");
    image = prefs.getString("profile_pic").toString();
    var ranking = prefs.getString("ranking");
    var email_verified_at = prefs.getString("email_verified_at");
    var created_at = prefs.getString("created_at");
    var total_wallet_amount = prefs.getString("total_wallet_amount");
    var current_wallet_amout = prefs.getString("current_wallet_amout");
    var status = prefs.getString("status");
    // var kycStatus1 = prefs.getString("kycStatus");

    name = name1.toString();
    mobile = mobile1.toString();
    first_name = first_name1.toString();
    last_name = last_name1.toString();
    // kycStatus = kycStatus1.toString();
    email = email1.toString();

    print("image..." + image.toString());

    print("kyc..." + kycStatus.toString());
    print("kyc1..." + prefs.getString("kycStatus").toString());

    print("email..." + email.toString());
    sliderUrl.clear();

    update();
    await HomeSliderApi();
    update();
    //await Future.delayed(const Duration(seconds: 3));
  }

  Future<dynamic> HomeSliderApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("id");
    print("id Print: " + id.toString());

    isLoading.value = true;

    String msg = "";

    var jsonRes;
    var jsonArray;
    http.Response? res;
    var request = http.post(
        Uri.parse(
          RestDatasource.HOMESLIDER_URL,
        ),
        body: {
          "userId": id.toString().trim(),
        });

    await request.then((http.Response response) {
      res = response;
    });
    if (res!.statusCode == 200) {
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(res!.body.toString());
      print("Response: " + res!.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      print("status: " + jsonRes["status"].toString() + "_");
      print("message: " + jsonRes["message"].toString() + "_");
      msg = jsonRes["message"].toString();
      jsonArray = jsonRes['data']['banners'];
      if (jsonRes["success"] == true) {
        sliderList.clear();

        for (var i = 0; i < jsonArray.length; i++) {
          HomeSliderModel modelAgentSearch = new HomeSliderModel();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.banner_pic = jsonArray[i]["banner_pic"].toString();
          modelAgentSearch.link = jsonArray[i]["link"].toString();

          //  sliderUrl.add(jsonArray[i]["banner_pic"].toString());
          //  linkUrl.add(jsonArray[i]["link"].toString());

          sliderList.add(modelAgentSearch);

          print("object: " + jsonArray[i]["banner_pic"].toString());
        }

        ranking = jsonRes["data"]["ranking"].toString().obs;

        earning = jsonRes["data"]["earning"].toString();
        leads = jsonRes["data"]["leads"].toString();
        jobs = jsonRes["data"]["jobs"].toString();
        user_status = jsonRes["data"]["user_status"].toString();

        if (user_status.toString() == "0") {
          var prefs = await SharedPreferences.getInstance();
          prefs.setString('id', '');
          prefs.setString('name', '');
          prefs.setString('first_name', '');
          prefs.setString('email', '');
          prefs.setString('last_name', '');
          prefs.setString('mobile', '');
          prefs.setString('profile_pic', '');
          prefs.setString('ranking', '');
          prefs.setString('email_verified_at', '');
          prefs.setString('created_at', '');
          prefs.setString('total_wallet_amount', '');
          prefs.setString('current_wallet_amout', '');
          prefs.setString('status', '');

          prefs.commit();

          Get.offAllNamed("/login");

          update();
        }

        update();

        print("total amount: " + jsonRes["data"]["earning"].toString());
        print("user status: " + user_status.toString());
        print("current amount: " + jobs.toString());

        update();
        refresh();

        isLoading(false);
        update();
      } else {
        isLoading(false);
        update();
      }
    } else {
      isLoading(false);
      update();
    }
  }
}
