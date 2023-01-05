import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:marketies/screens/home/p_home.dart';
import 'package:marketies/utils/constant.dart';
import 'package:marketies/utils/endpoint_url.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  var response = "";
  var tokenId = "";

  Future<dynamic> loginApi(
    String email,
    String password,
  ) async {
    isLoading(true);
    print(email);
    print(password);

    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(Uri.parse(login_url), body: {
      "email": email.toString().trim(),
      "password": password.toString().trim(),
      // "deviceId": tokenId.toString()
    });

    await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      print("status: " + jsonRes["success"].toString() + "_");
      print("message: " + jsonRes["message"].toString() + "_");
      msg = jsonRes["message"].toString();
    });
    if (res!.statusCode == 200) {
      if (jsonRes["success"] == true) {
        Get.to(() => PHome());

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
