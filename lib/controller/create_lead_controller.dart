// ignore_for_file: avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables, unnecessary_new

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/components/default_button.dart';
import 'package:marketies/controller/get_lead_data_controller.dart';
import 'package:marketies/models/add_lead_model.dart';
import 'package:marketies/screens/homenav.dart';
import 'package:marketies/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_lead_fields_controller.dart';

class CreateLeadController extends GetxController {
  RxBool isLoading = false.obs;
  var count = "".obs;

  Future<dynamic> createLeadImageApi(String jobId, String name, String mobile,Map leads_data, File? file) async {
  
   print("map " + leads_data.toString());

    var json = jsonEncode(leads_data);
    print(json);
    SharedPreferences prefs = await SharedPreferences.getInstance();



    var id = prefs.getString("id");

    
    print("id Print: " + id.toString());
    print("jobID Print: " + jobId.toString());
    print("name Print: " + name.toString());
    print("mobile Print: " + mobile.toString());
    print("leads_data length: " + json.toString());

    print("file: " + file.toString());

    isLoading(true);

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        RestDatasource.CREATELEAD_URL,
      ),
    );

    request.fields["userId"] = id.toString();

    if (jobId.toString() != "null" || jobId.toString() != "") {
      request.fields["jobId"] = jobId.toString();
      print("jobId: " + jobId.toString());
    }

    if (name.toString() != "null" || name.toString() != "") {
      request.fields["name"] = name.toString();
      print("name: " + name.toString());
    }

    if (mobile.toString() != "null" || mobile.toString() != "") {
      request.fields["mobile"] = mobile.toString();
      print("mobile: " + mobile.toString());
    }

    if (leads_data.toString() != "null" || leads_data.toString() != "") {
      request.fields["leads_data"] = json;
      print("leads_data: " + json.toString());
    }

    request.files.add(await http.MultipartFile.fromPath("image", file!.path));

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
        Get.to(HomeNav(index: 2));

        Get.lazyPut<GetLeadDataController>(() => GetLeadDataController());

        Get.find<GetLeadDataController>().getListDataList.clear();

        Get.find<GetLeadDataController>().getLeadDataApi();
        Get.lazyPut<CreateLeadFieldsController>(
            () => CreateLeadFieldsController());
        Get.find<CreateLeadFieldsController>().createLeadFiledsList.clear();

        Get.defaultDialog(
          title: "",
          content: Column(
            children: [
              Image.asset(
                "assets/images/right.gif",
                width: 100,
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              Text(
                "Your lead has been submitted successfully",
                style: GoogleFonts.cabin(color: Colors.black, fontSize: 16),
              ),
              // ignore: prefer_const_constructors

              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              DefaultButton(
                  width: 70,
                  height: 30,
                  text: "ok",
                  press: () {
                    Get.back();
                  })
            ],
          ),
        );

        isLoading(false);
        update();
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
        update();
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
      update();
    }
  }

  Future<dynamic> createLeadApi(
    String jobId,
    String name,
    String mobile,
    Map leads_data,
  ) async {
    print("map " + leads_data.toString());

    var json = jsonEncode(leads_data);
    print(json);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("id");
    print("id Print: " + id.toString());
    print("jobID Print: " + jobId.toString());
    print("name Print: " + name.toString());
    print("mobile Print: " + mobile.toString());
    print("leads_data length: " + json.toString());

    isLoading(true);

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        RestDatasource.CREATELEAD_URL,
      ),
    );

    request.fields["userId"] = id.toString();

    if (jobId.toString() != "null" || jobId.toString() != "") {
      request.fields["jobId"] = jobId.toString();
      print("jobId: " + jobId.toString());
    }

    if (name.toString() != "null" || name.toString() != "") {
      request.fields["name"] = name.toString();
      print("name: " + name.toString());
    }

    if (mobile.toString() != "null" || mobile.toString() != "") {
      request.fields["mobile"] = mobile.toString();
      print("mobile: " + mobile.toString());
    }

    if (leads_data.toString() != "null" || leads_data.toString() != "") {
      request.fields["leads_data"] = json;
      print("leads_data.....: " + json.toString());
    }

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
        Get.to(HomeNav(index: 2));

        Get.lazyPut<GetLeadDataController>(() => GetLeadDataController());

        Get.lazyPut<CreateLeadFieldsController>(
            () => CreateLeadFieldsController());
        Get.find<GetLeadDataController>().getListDataList.clear();

        Get.find<GetLeadDataController>().getLeadDataApi();

        Get.find<CreateLeadFieldsController>().createLeadFiledsList.clear();
        update();

        Get.defaultDialog(
          title: "",
          content: Column(
            children: [
              Image.asset(
                "assets/images/right.gif",
                width: 100,
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              Text(
                "Your lead has been submitted successfully",
                style: GoogleFonts.cabin(color: Colors.black, fontSize: 16),
              ),
              // ignore: prefer_const_constructors

              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              DefaultButton(
                  width: 70,
                  height: 30,
                  text: "ok",
                  press: () {
                    Get.back();
                  })
            ],
          ),
        );

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
         fontSize: 14.0
     );
     update();
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
      update();
    }
  }

  // Future<dynamic> createLeadApi(String jobId, String name, String mobile, Map leads_data   ) async {

  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   var id = prefs.getString("id");
  //   print("id Print: " + id.toString());
  //   print("jobID Print: " + jobId.toString());
  //   print("name Print: " + name.toString());
  //   print("mobile Print: " + mobile.toString());
  //    print("leads_data length: " + jsonEncode(leads_data));

  //   isLoading(true);
  //   // print(email);
  //   // print(password);
  //   String msg = "";
  //   var jsonRes;
  //   http.Response? res;

  //   var request = http.post(
  //       Uri.parse(
  //         RestDatasource.CREATELEAD_URL,
  //       ),
  //       body: {
  //         "userId": id.toString().trim(),
  //         "jobId": jobId.toString().trim(),
  //         "name" : name.toString(),
  //         "mobile" : mobile.toString(),
  //         "leads_data": jsonEncode(leads_data),
  //       });

  //   await request.then((http.Response response) {
  //     res = response;
  //     final JsonDecoder _decoder = new JsonDecoder();
  //     jsonRes = _decoder.convert(response.body.toString());
  //     print("Response: " + response.body.toString() + "_");
  //     print("ResponseJSON: " + jsonRes.toString() + "_");
  //     print("status: " + jsonRes["status"].toString() + "_");
  //     print("message: " + jsonRes["message"].toString() + "_");
  //     msg = jsonRes["message"].toString();
  //   }
  //   );
  //   if (res!.statusCode == 200) {
  //     if (jsonRes["success"] == true) {

  //       Get.to(HomeNav(index:2));

  //           Get.lazyPut<GetLeadDataController>(() => GetLeadDataController());

  //       Get.find<GetLeadDataController>().getListDataList.clear();

  //       Get.find<GetLeadDataController>().getLeadDataApi();

  //       Get.defaultDialog(
  //         title: "",
  //         content: Column(
  //           children: [
  //             Image.asset(
  //               "assets/images/right.gif",
  //               width: 100,
  //             ),
  //             // ignore: prefer_const_constructors
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               "Your lead has been submitted successfully",
  //               style: GoogleFonts.cabin(color: Colors.black, fontSize: 16),
  //             ),
  //             // ignore: prefer_const_constructors

  //             // ignore: prefer_const_constructors
  //             SizedBox(
  //               height: 20,
  //             ),
  //             DefaultButton(
  //                 width: 70,
  //                 height: 30,
  //                 text: "ok",
  //                 press: () {
  //                   Get.back();
  //                 })
  //           ],
  //         ),
  //       );

  //       isLoading(false);
  //     } else {
  //       isLoading(false);

  //     }
  //   } else {

  //     isLoading(false);
  //   }
  // }

}
