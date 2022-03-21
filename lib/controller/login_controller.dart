import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/screens/otp_signup.dart';
import 'package:marketies/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  var response = "";
  var tokenId = "";

  @override
  void onInit() {
    token();
    super.onInit();
  }

  Future<dynamic> loginApi(
    String email,
    String password,
  ) async {
    isLoading(true);
    print(email);
    print(password);

    print("avialble token : " + tokenId.toString());
    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(
          RestDatasource.LOGIN_URL,
        ),
        body: {
          "email": email.toString().trim(),
          "password": password.toString().trim(),
          "deviceId": tokenId.toString()
        });

    await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      print("status: " + jsonRes["status"].toString() + "_");
      print("message: " + jsonRes["message"].toString() + "_");
      msg = jsonRes["message"].toString();
    });
    if (res!.statusCode == 200) {
      if (jsonRes["success"] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', jsonRes["data"]["Data"]["id"].toString());
        prefs.setString('name', jsonRes["data"]["Data"]["name"].toString());
        prefs.setString(
            'first_name', jsonRes["data"]["Data"]["first_name"].toString());
        prefs.setString('email', jsonRes["data"]["Data"]["email"].toString());
        prefs.setString(
            'last_name', jsonRes["data"]["Data"]["last_name"].toString());
        prefs.setString('mobile', jsonRes["data"]["Data"]["mobile"].toString());
        prefs.setString(
            'profile_pic', jsonRes["data"]["Data"]["profile_pic"].toString());
        prefs.setString(
            'ranking', jsonRes["data"]["Data"]["ranking"].toString());
        prefs.setString('email_verified_at',
            jsonRes["data"]["Data"]["email_verified_at"].toString());
        prefs.setString(
            'created_at', jsonRes["data"]["Data"]["created_at"].toString());
        prefs.setString('total_wallet_amount',
            jsonRes["data"]["Data"]["total_wallet_amount"].toString());
        prefs.setString('current_wallet_amout',
            jsonRes["data"]["Data"]["current_wallet_amout"].toString());
        prefs.setString('status', jsonRes["data"]["Data"]["status"].toString());
        // prefs.setString('kycStatus', jsonRes["data"]["kycStatus"].toString());
        prefs.commit();

        // Get.snackbar(msg.toString(), "",  snackPosition: SnackPosition.TOP,);

        // _handleRemeberme(remember);
        Get.offAllNamed("/homeNav");

        // update();

        print("hamara kyc ...." + jsonRes["data"]["kycStatus"].toString());

        isLoading(false);

        Fluttertoast.showToast(
            msg: msg.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 14.0);
      } else {
        isLoading(false);
      }
    } else {
      response = msg.toString();

      print("khdbdsbd..... " + response.toString());

      // Get.snackbar(
      //   'Please enter valid credentials', "",  snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.black,
      //   padding: const EdgeInsets.only(top: 0)

      // );

      Fluttertoast.showToast(
          msg: msg.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 14.0);

      isLoading(false);
    }
  }

  token() {
    var messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print("token: " + value.toString());
      tokenId = value.toString();

      print("new token: " + tokenId.toString());
    });
  }
}
