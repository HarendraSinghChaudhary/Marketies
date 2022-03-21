// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_new

import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/screens/kyc_detail_1.dart';
import 'package:marketies/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  String? code = "+91";
  bool isloading = false;
  String image = "";
  String base64Image = "";
  String fileName = "";
  File? file;
  // final file = Rx<File>("");

  final picker = ImagePicker();

  RxBool isLoading = false.obs;

  var tokenId = "";

  @override
  void onInit() {
    token();
    super.onInit();
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> signupApi(
    String first_name,
    String last_name,
    String mobile,
    String email,
    String password,
  ) async {
    print("name: " + first_name.toString());

    isLoading(true);

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        RestDatasource.SIGNUP_URL,
      ),
    );
    if (first_name.toString() != "null" || first_name.toString() != "") {
      request.fields["first_name"] = first_name.toString();
      print("first_name: " + first_name.toString());
    }

    if (last_name.toString() != "null" || last_name.toString() != "") {
      request.fields["last_name"] = last_name.toString();
      print("last_name: " + last_name.toString());
    }

    if (mobile.toString() != "null" || mobile.toString() != "") {
      request.fields["mobile"] = mobile.toString();
      print("mobile: " + mobile.toString());
    }

    if (email.toString() != "email" || email.toString() != "") {
      request.fields["email"] = email.toString();
      print("email: " + email.toString());
    }

    if (password.toString() != "null" || password.toString() != "") {
      request.fields["password"] = password.toString();
      print("password: " + password.toString());
    }

    if (tokenId.toString() != "null" || tokenId.toString() != "") {
      request.fields["deviceId"] = tokenId.toString();
      print("tokenId: " + tokenId.toString());
    }

    request.fields["profile_pic"] = "";

    var jsonRes;
    var msg;
    var res = await request.send();

    if (res.statusCode == 200) {
      var respone = await res.stream.bytesToString();
      final JsonDecoder _decoder = new JsonDecoder();

      jsonRes = _decoder.convert(respone.toString());
      print("Response: " + jsonRes.toString() + "_");
      print(jsonRes["status"]);

      msg = jsonRes["message"].toString();

      if (jsonRes["success"].toString() == "true") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', jsonRes["data"]["userData"]["id"].toString());
        prefs.setString('name', jsonRes["data"]["userData"]["name"].toString());
        prefs.setString(
            'first_name', jsonRes["data"]["userData"]["first_name"].toString());
        prefs.setString(
            'email', jsonRes["data"]["userData"]["email"].toString());
        prefs.setString(
            'last_name', jsonRes["data"]["userData"]["last_name"].toString());
        prefs.setString(
            'mobile', jsonRes["data"]["userData"]["mobile"].toString());
        prefs.setString('profile_pic',
            jsonRes["data"]["userData"]["profile_pic"].toString());
        prefs.setString(
            'ranking', jsonRes["data"]["userData"]["ranking"].toString());
        prefs.setString('email_verified_at',
            jsonRes["data"]["userData"]["email_verified_at"].toString());
        prefs.setString(
            'created_at', jsonRes["data"]["userData"]["created_at"].toString());
        prefs.setString('total_wallet_amount',
            jsonRes["data"]["userData"]["total_wallet_amount"].toString());
        prefs.setString('current_wallet_amout',
            jsonRes["data"]["userData"]["current_wallet_amout"].toString());
        prefs.setString(
            'status', jsonRes["data"]["userData"]["status"].toString());
        // prefs.setString('kycStatus', jsonRes["data"]["kycStatus"].toString());
        prefs.commit();

        Get.offAllNamed("/kyc1");

        //       Fluttertoast.showToast(
        //     msg: msg.toString(),
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor:kPrimaryColor,
        //     textColor: Colors.white,
        //     fontSize: 14.0
        // );

        isLoading(false);
        update();
      } else {
        isLoading(false);

        Fluttertoast.showToast(
            msg: msg.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 14.0);
        update();

        //       Fluttertoast.showToast(
        //      msg: msg.toString(),
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: kPrimaryColor,
        //     textColor: Colors.white,
        //     fontSize: 14.0
        // );

      }
    } else {
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

  // ignore: non_constant_identifier_names
  Future<dynamic> signupImageApi(String first_name, String last_name,
      String mobile, String email, String password, File file) async {
    print("Running SignupImage");

    isLoading(true);

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        RestDatasource.SIGNUP_URL,
      ),
    );
    if (first_name.toString() != "null" || first_name.toString() != "") {
      request.fields["first_name"] = first_name.toString();
      print("first_name: " + first_name.toString());
    }

    if (last_name.toString() != "null" || last_name.toString() != "") {
      request.fields["last_name"] = last_name.toString();
      print("last_name: " + last_name.toString());
    }

    if (mobile.toString() != "null" || mobile.toString() != "") {
      request.fields["mobile"] = mobile.toString();
      print("mobile: " + mobile.toString());
    }

    if (email.toString() != "email" || email.toString() != "") {
      request.fields["email"] = email.toString();
      print("email: " + email.toString());
    }

    if (password.toString() != "null" || password.toString() != "") {
      request.fields["password"] = password.toString();
      print("password: " + password.toString());
    }

    if (tokenId.toString() != "null" || tokenId.toString() != "") {
      request.fields["deviceId"] = tokenId.toString();
      print("tokenId: " + tokenId.toString());
    }

    request.files
        .add(await http.MultipartFile.fromPath("profile_pic", file.path));

    var jsonRes;
    var msg;
    var res = await request.send();

    if (res.statusCode == 200) {
      var respone = await res.stream.bytesToString();
      final JsonDecoder _decoder = new JsonDecoder();

      jsonRes = _decoder.convert(respone.toString());
      print("Response: " + jsonRes.toString() + "_");
      print(jsonRes["status"]);

      msg = jsonRes["message"].toString();

      if (jsonRes["success"].toString() == "true") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', jsonRes["data"]["userData"]["id"].toString());
        prefs.setString('name', jsonRes["data"]["userData"]["name"].toString());
        prefs.setString(
            'first_name', jsonRes["data"]["userData"]["first_name"].toString());
        prefs.setString(
            'email', jsonRes["data"]["userData"]["email"].toString());
        prefs.setString(
            'last_name', jsonRes["data"]["userData"]["last_name"].toString());
        prefs.setString(
            'mobile', jsonRes["data"]["userData"]["mobile"].toString());
        prefs.setString('profile_pic',
            jsonRes["data"]["userData"]["profile_pic"].toString());
        prefs.setString(
            'ranking', jsonRes["data"]["userData"]["ranking"].toString());
        prefs.setString('email_verified_at',
            jsonRes["data"]["userData"]["email_verified_at"].toString());
        prefs.setString(
            'created_at', jsonRes["data"]["userData"]["created_at"].toString());
        prefs.setString('total_wallet_amount',
            jsonRes["data"]["userData"]["total_wallet_amount"].toString());
        prefs.setString('current_wallet_amout',
            jsonRes["data"]["userData"]["current_wallet_amout"].toString());
        prefs.setString(
            'status', jsonRes["data"]["userData"]["status"].toString());
        // prefs.setString('kycStatus', jsonRes["data"]["kycStatus"].toString());
        prefs.commit();

        update();

        Get.offAllNamed("/kyc1");

        //       Fluttertoast.showToast(
        //     msg: msg.toString(),
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: kPrimaryColor,
        //     textColor: Colors.white,
        //     fontSize: 14.0
        // );

        isLoading(false);

        update();
        print(
            "ImageSignup " + prefs.getString("profile_pic").toString() + "^^");

        update();
      } else {
        isLoading(false);

        update();

        Fluttertoast.showToast(
            msg: msg.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: kPrimaryColor,
            textColor: Colors.white,
            fontSize: 14.0);
        update();

        //   Fluttertoast.showToast(
        // msg: msg.toString(),
        // toastLength: Toast.LENGTH_SHORT,
        // gravity: ToastGravity.BOTTOM,
        // timeInSecForIosWeb: 1,
        // backgroundColor: kPrimaryColor,
        // textColor: Colors.white,
        // fontSize: 14.0
        // );

      }
    } else {
      Fluttertoast.showToast(
          msg: "Error while fetching data",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 14.0);

      isLoading(false);

      update();
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
