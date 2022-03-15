// ignore_for_file: avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/components/default_button.dart';
import 'package:marketies/controller/get_lead_data_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobApplyController extends GetxController {
  var isLoading = false.obs;
  var count = "".obs;

  Future<dynamic> jobApplyApi(
    String jobId,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("id");
    print("id Print: " + id.toString());
    print("jobID Print: " + jobId.toString());

    isLoading(false);
    // print(email);
    // print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(
          RestDatasource.JOBAPPLY_URL,
        ),
        body: {
          "userId": id.toString().trim(),
          "jobId": jobId.toString().trim(),
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
    }
    );
    if (res!.statusCode == 200) {
      if (jsonRes["success"] == true) {

        //  Get.lazyPut<GetLeadDataController>(() => GetLeadDataController());

        // Get.find<GetLeadDataController>().getLeadDataApi();


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
                msg.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.cabin(color: Colors.black, fontSize: 16),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              // Text(
              //   "We will contact you within 7 - 14 hours",
              //   style: GoogleFonts.cabin(color: Colors.black54, fontSize: 15),
              // ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              DefaultButton(
                  width: 70,
                  height: 30,
                  text: "OK",
                  press: () {
                    Get.back();
                  })
            ],
          ),
        );

       

        // Get.snackbar(
        //   msg.toString(),
        //   "",
        //   snackPosition: SnackPosition.TOP,
        // );

       
        // Get.offAllNamed("/homeNav");

        isLoading(false);
      } else {


       

       







        isLoading(false);
        Get.snackbar(
          msg.toString(),
          "",
          snackPosition: SnackPosition.TOP,
        );
      }
    } else {
      Get.snackbar(
        'Error while fetching data',
        "",
        snackPosition: SnackPosition.TOP,
      );

      isLoading(false);
    }
  }

  // @override
  // void onInit() {
  //  once(count, callback)
  //   super.onInit();
  // }
}
