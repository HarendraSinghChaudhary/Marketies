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
import 'package:marketies/controller/home_controller.dart';
import 'package:marketies/screens/kyc_detail_1.dart';
import 'package:marketies/screens/menu.dart';
import 'package:marketies/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  String? code = "+91";
  bool isloading = false;
  String image = "";
  String base64Image = "";
  String fileName = "";
  File? file;
  // final file = Rx<File>("");
  bool isLoading = false;
  final picker = ImagePicker();

  var iSLoading = false.obs;
 
  // ignore: non_constant_identifier_names
  
  Future<dynamic> editProfileApiwithImage(
      String first_name, String last_name, String mobile, File? file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("id");
    print("id Print: " + id.toString());
    // print("jobID Print: " + jobId.toString());

    print("name: " + first_name.toString());

    iSLoading(true);

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        RestDatasource.EDITPROFILE_URL,
      ),
    );

    request.fields["id"] = id.toString();

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


     if (file.toString() != "null" || file.toString() != "") {
      request.files.add(await http.MultipartFile.fromPath("profile_pic", file!.path));
      print("profile_pic: " + file.toString());
    } 

    
    var jsonRes;
    var res = await request.send();

    if (res.statusCode == 200) {
      var respone = await res.stream.bytesToString();
      final JsonDecoder _decoder = new JsonDecoder();

      jsonRes = _decoder.convert(respone.toString());
      print("Response: " + jsonRes.toString() + "_");
      print(jsonRes["status"]);

      if (jsonRes["status"].toString() == "true") {

        SharedPreferences prefs = await SharedPreferences.getInstance();
       
        prefs.setString('profile_pic', jsonRes["data"]["profile_pic"].toString());
     
        prefs.commit();


        image = jsonRes["data"]["profile_pic"].toString();



        print("image print: "+image.toString());


         Get.lazyPut<HomeController>(() => HomeController());

         Get.find<HomeController>().sliderUrl.clear();


         Get.find<HomeController>().getData();




      //  homeController.getData();

        iSLoading(false);
        Fluttertoast.showToast(
          msg: jsonRes["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 14.0);

      } else {
        iSLoading(false);

         Fluttertoast.showToast(
          msg: jsonRes["message"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 14.0);

       
      }
    } else {
      Fluttertoast.showToast(
          msg: "Please try later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 14.0);
    }

    iSLoading(false);
  }
}
