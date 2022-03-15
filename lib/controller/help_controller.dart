



import 'dart:convert';
import 'package:http/http.dart' as http; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:marketies/models/job_model.dart';

import '../models/help_model.dart';

class HelpController extends GetxController{



  var isLoading = false.obs;
   RxList helpList = [].obs;

  @override
  void onInit() {
    helpApi();
    super.onInit();
  }






   Future<dynamic> helpApi() async {
  

    var request = http.get(Uri.parse(RestDatasource.HELP_URL));

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
      jsonArray = jsonRes['data']['data'];
    });

    if (res.statusCode == 200) {
      print(jsonRes["status"]);

      if (jsonRes['data']["status"].toString() == "true") {
        for (var i = 0; i < jsonArray.length; i++) {
          HelpModel modelAgentSearch = new HelpModel();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.title = jsonArray[i]["title"].toString();
          modelAgentSearch.content = jsonArray[i]["content"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();


              

 

          helpList.add(modelAgentSearch);

          print("object: "+ jsonArray[i]["title"].toString());

        
        }

        isLoading(false);
        // Get.snackbar(
        //         "",
        //         ""
                
        //         ,
        //         snackPosition: SnackPosition.TOP,
        //         titleText: Text(jsonRes["message"].toString()),
        //         messageText: Text(""),
        //         colorText: Colors.red,);

       

      } else {


        Get.snackbar(
                "",
                ""
                
                ,
                snackPosition: SnackPosition.TOP,
                titleText: Text(jsonRes["message"].toString()),
                messageText: Text(""),
                colorText: Colors.red,);

                isLoading(false);
      
      }
    } else {

      Get.snackbar(
                "",
                ""
                
                ,
                snackPosition: SnackPosition.TOP,
                titleText: Text("Please try later"),
                messageText: Text(""),
                colorText: Colors.red,);

                isLoading(false);



    
    }
  }








}