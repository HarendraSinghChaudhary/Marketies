// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_new

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/screens/kyc_detail_1.dart';
import 'package:marketies/screens/menu.dart';
import 'package:marketies/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordController extends GetxController {



  RxBool isLoading = false.obs;

  // ignore: non_constant_identifier_names


   Future<dynamic> changePasswordApi(String oldpassword, String newpassword) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
       var id = prefs.getString("id");
       print("id Print: " +id.toString());
      isLoading(true);
    print(id.toString);
    print(oldpassword);
    print(newpassword);
    var msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(RestDatasource.CHANGEPASSWORD_URL
            // RestDatasource.SEND_OTP,
            ),
        body: {
          
          "oldpassword": oldpassword.toString(),
          "newpassword": newpassword.toString(),
          "id": id.toString(),
        });

    await request.then((http.Response response) {
      res = response;
      // msg = jsonRes["message"].toString();
      // getotp = jsonRes["otp"];
      // print(getotp.toString() + '123');
    });
    if (res!.statusCode == 200) {
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(res!.body.toString());
      print("Response: " + res!.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      print("status: " + jsonRes["status"].toString() + "_");


      msg = jsonRes["message"].toString();

      if (jsonRes["status"] == true) {

        Get.back();



       isLoading(false);

        Fluttertoast.showToast(
                                        msg: msg.toString(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: kPrimaryColor,
                                        textColor: Colors.white,
                                        fontSize: 14.0);
      
        

       
      }
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



         Fluttertoast.showToast(
                                        msg: "Please try later",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: kPrimaryColor,
                                        textColor: Colors.white,
                                        fontSize: 14.0);







    
      isLoading(false);
    }
  }





























 




}
