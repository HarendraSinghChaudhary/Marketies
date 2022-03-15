import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:marketies/models/job_model.dart';

class JobController extends GetxController {
  RxBool isLoading = false.obs;
  RxList jobList = [].obs;

  @override
  void onInit() {
    jobApi();
    super.onInit();
  }

  Future<dynamic> jobApi() async {
    var request = http.get(Uri.parse(RestDatasource.JOB_URL));
    isLoading(true);

    String msg = "";
    var jsonArray;
    var jsonRes;
    var res;

    await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      msg = jsonRes["message"].toString();
      jsonArray = jsonRes['data']['jobs'];
    });

    if (res.statusCode == 200) {
      print(jsonRes["status"]);
      jobList.clear();
      update();

      if (jsonRes['data']["status"].toString() == "true") {
        for (var i = 0; i < jsonArray.length; i++) {
          JobModel modelAgentSearch = new JobModel();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.title = jsonArray[i]["title"].toString();
          modelAgentSearch.photo = jsonArray[i]["photo"].toString();
          modelAgentSearch.description = jsonArray[i]["description"].toString();
          modelAgentSearch.job_type = jsonArray[i]["job_type"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();

          jobList.add(modelAgentSearch);

          print("object: " + jsonArray[i]["title"].toString());

          update();

          
        }

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
