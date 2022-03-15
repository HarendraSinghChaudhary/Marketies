import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/models/job_model.dart';
import 'package:marketies/models/lead_list_model.dart';
import 'package:marketies/models/search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppliedJobsController extends GetxController {
  RxBool isLoading = false.obs;
  RxList leadList = [].obs;

  @override
  void onInit() {
    isLoading(true);
    LeadsListApi();
    super.onInit();
  }

  Future<dynamic> LeadsListApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("id");
    print("id Print: " + id.toString());
    // print("jobID Print: " + jobId.toString());

    isLoading(true);
    // print(email);
    // print(password);
    String msg = "";
    var jsonRes;

    var jsonArray;

    http.Response? res;
    var request = http.post(
        Uri.parse(
          RestDatasource.LEADLIST_URL,
        ),
        body: {
          "userId": id.toString().trim(),
        });

    await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      msg = jsonRes["message"].toString();
      jsonArray = jsonRes['data']['leadsList'];
    });

    if (res!.statusCode == 200) {
      leadList.clear();
      update();

      print(jsonRes["status"]);

      if (jsonRes['data']["status"].toString() == "true") {
        leadList.clear();
        for (var i = 0; i < jsonArray.length; i++) {
          AppliedJobsModel modelAgentSearch = new AppliedJobsModel();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.user_id = jsonArray[i]["user_id"].toString();
          modelAgentSearch.job_id = jsonArray[i]["job_id"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();

          if (jsonArray[i]['job'] != null) {
            modelAgentSearch.title = jsonArray[i]["job"]["title"].toString();
            modelAgentSearch.photo = jsonArray[i]["job"]["photo"].toString();
            modelAgentSearch.description =
                jsonArray[i]["job"]["description"].toString();
            modelAgentSearch.job_type =
                jsonArray[i]["job"]["job_type"].toString();
            // modelAgentSearch.status= jsonArray[i]["status"].toString();
            modelAgentSearch.created_at =
                jsonArray[i]["job"]["created_at"].toString();
          }

          if (jsonArray[i]['job'] != null) {
            leadList.add(modelAgentSearch);
            update();
          }

          // print("object: "+ jsonArray[i]["job"]["title"].toString());

        }

        isLoading(false);
        update();
      } else {
        isLoading(false);
        update();
      }
      update();
      return;
    } else {
      isLoading(false);
      update();

      return;
    }
  }

 
 
 
 
 
 
 
 
 
  Future<dynamic> searchData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    print("id Print: " + id.toString());
    print("key Print: " + key.toString());

    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(
          RestDatasource.SEARCHIMPORTJOB_URL,
        ),
        body: {
          "userId": id.toString(),
          "key": key.toString().trim(),
        });

    var jsonArray;

    await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      jsonArray = jsonRes['data'];
    });

    if (res!.statusCode == 200) {
      if (jsonRes["status"] == true) {
        leadList.clear();
        update();

        for (var i = 0; i < jsonArray.length; i++) {
          SearchModel modelAgentSearch = new SearchModel();
          modelAgentSearch.jobname = jsonArray[i]["jobname"].toString();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.title = jsonArray[i]["title"].toString();
          modelAgentSearch.photo = jsonArray[i]["photo"].toString();
          modelAgentSearch.description = jsonArray[i]["description"].toString();
          modelAgentSearch.job_type = jsonArray[i]["job_type"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          modelAgentSearch.user_id = jsonArray[i]["user_id"].toString();
          modelAgentSearch.job_id = jsonArray[i]["job_id"].toString();

          print("id: " + modelAgentSearch.id.toString());

          leadList.add(modelAgentSearch);

          update();
        }

        isLoading(false);
        update();

        // Get.snackbar(
        //   "",
        //   "",
        //   snackPosition: SnackPosition.TOP,
        //   titleText: Text(jsonRes["message"].toString()),
        //   colorText: Colors.red,
        // );
      } else {
        Get.snackbar(
          "",
          "",
          snackPosition: SnackPosition.TOP,
          titleText: Text("Please try leter"),
          colorText: Colors.red,
        );
        isLoading(false);
        update();
      }
    }
  }
}
