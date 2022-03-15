import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/models/create_lead_fields_model.dart';

import 'package:marketies/models/lead_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CreateLeadFieldsController extends GetxController {

  RxBool isLoading = false.obs;
  RxList createLeadFiledsList = [].obs;
  var jobId = "";

  int? image;

  var textImage = "";

  @override
  void onInit() {
    // TODO: implement onInit
    createLeadFieldsApi(); 
    super.onInit();
  }

 
updateID(var postID) {
  jobId= postID;
  print('im print ${jobId}');
  
}



  var jobIdd = "";

  Future<dynamic> createLeadFieldsApi() async {
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
          RestDatasource.CREATELEADFIELDS_URL,
        ),
        body: {
          "userId": id.toString().trim(),
          "jobId": jobId
        });

    await request.then((http.Response response) {
      res = response;
      
    });

    if (res!.statusCode == 200) {
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(res!.body.toString());
      print("Response: " + res!.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      msg = jsonRes["message"].toString();
      jsonArray = jsonRes['data']['Leadfields'];
      print(jsonRes["status"]);

      // image = jsonRes['data']["isImage"];
      print("image is coming ...."+jsonRes['data']["isImage"].toString());

      var image1 = jsonRes['data']["isImage"];
      var textImage1 = jsonRes['data']["imageText"].toString();

      textImage = textImage1;

      image = image1;

      print("rest: "+image.toString());

      if (jsonRes['data']["status"].toString() == "true") {
        createLeadFiledsList.clear();
        for (var i = 0; i < jsonArray.length; i++) {
          CreateLeadFieldModel modelAgentSearch = new CreateLeadFieldModel();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.field = jsonArray[i]["field"].toString();
          modelAgentSearch.value = jsonArray[i]["value"].toString();
          modelAgentSearch.job_id = jsonArray[i]["job_id"].toString();

          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          

          createLeadFiledsList.add(modelAgentSearch);

          print("object: " + jsonArray[i]["field"].toString());
        }

        isLoading(false);
        // Get.snackbar(
        //   "",
        //   "",
        //   snackPosition: SnackPosition.TOP,
        //   titleText: Text(jsonRes["message"].toString()),
        //   messageText: Text(""),
        //   colorText: Colors.red,
        // );
      } else {
       

        isLoading(false);
      }
    } else {
    
      isLoading(false);
    }
  }











  

}