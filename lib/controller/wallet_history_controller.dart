import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/models/create_lead_fields_model.dart';

import 'package:marketies/models/lead_list_model.dart';
import 'package:marketies/models/wallet_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class WalletHistoryController extends GetxController {

 RxBool isLoading = false.obs;
  RxList walletHistoryList = [].obs;

  RxList creditHistoryList = [].obs;
  

  @override
  void onInit() {

    isLoading(true);
    walletHistoryApi(); 
   

    
  
    super.onInit();
  }

 






  Future<dynamic> walletHistoryApi() async {
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
    var creditinfo;

    http.Response? res;
    var request = http.post(
        Uri.parse(
          RestDatasource.WALLETHISTORY_URL,
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
      jsonArray = jsonRes['data']['data'];
      creditinfo = jsonRes['data']['creditedrequests'];
    });

    if (res!.statusCode == 200) {
      print(jsonRes["status"]);

      if (jsonRes['data']["status"].toString() == "true") {
        walletHistoryList.clear();
        creditHistoryList.clear();










        for (var i = 0; i < jsonArray.length; i++) {
          WalletHistoryModel modelAgentSearch = new WalletHistoryModel();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.user_id = jsonArray[i]["user_id"].toString();
          modelAgentSearch.amount = jsonArray[i]["amount"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          modelAgentSearch.transaction_id = jsonArray[i]["transaction_id"].toString();

          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          

          walletHistoryList.add(modelAgentSearch);

          print("object: " + jsonArray[i]["amount"].toString());


            print("printing11111");
        }

        update();

        isLoading(false);

        update();


           for (var i = 0; i < creditinfo.length; i++) {
          WalletHistoryModel modelAgentSearch = new WalletHistoryModel();
          modelAgentSearch.id = creditinfo[i]["id"].toString();
          modelAgentSearch.user_id = creditinfo[i]["user_id"].toString();
          modelAgentSearch.amount = creditinfo[i]["amount"].toString();
          modelAgentSearch.status = creditinfo[i]["status"].toString();
          modelAgentSearch.transaction_id = creditinfo[i]["transaction_id"].toString();

          modelAgentSearch.created_at = creditinfo[i]["created_at"].toString();

         
            creditHistoryList.add(modelAgentSearch);
            
        



          // print("object: " + jsonArray[i]["transaction_id"].toString());
        }
     
      } else {
     

        isLoading(false);
        update();
      }
    } else {
      Get.snackbar(
        "",
        "",
        snackPosition: SnackPosition.TOP,
        titleText: Text("Please try later"),
        messageText: Text(""),
        colorText: Colors.red,
      );

      isLoading(false);
      update();
    }



  }




//  Future<dynamic> creditHistoryApi() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     var id = prefs.getString("id");
//     print("id Print: " + id.toString());
//     // print("jobID Print: " + jobId.toString());

//     isLoading(true);
//     // print(email);
//     // print(password);
//     String msg = "";
//     var jsonRes;

//     var jsonArray;

//     http.Response? res;
//     var request = http.post(
//         Uri.parse(
//           RestDatasource.WALLETHISTORY_URL,
//         ),
//         body: {
//           "userId": id.toString().trim(),
         
//         });

//     await request.then((http.Response response) {
//       res = response;
//       final JsonDecoder _decoder = new JsonDecoder();
//       jsonRes = _decoder.convert(response.body.toString());
//       print("Response: " + response.body.toString() + "_");
//       print("ResponseJSON: " + jsonRes.toString() + "_");
//       msg = jsonRes["message"].toString();
//       jsonArray = jsonRes['data']['creditedrequests'];
//     });

//     if (res!.statusCode == 200) {
//       print(jsonRes["status"]);

//       if (jsonRes['data']["status"].toString() == "true") {
//         for (var i = 0; i < jsonArray.length; i++) {
//           WalletHistoryModel modelAgentSearch = new WalletHistoryModel();
//           modelAgentSearch.id = jsonArray[i]["id"].toString();
//           modelAgentSearch.user_id = jsonArray[i]["user_id"].toString();
//           modelAgentSearch.amount = jsonArray[i]["amount"].toString();
//           modelAgentSearch.status = jsonArray[i]["status"].toString();
//           modelAgentSearch.transaction_id = jsonArray[i]["transaction_id"].toString();

//           modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();

         
//             creditHistoryList.add(modelAgentSearch);
            
        



//           // print("object: " + jsonArray[i]["transaction_id"].toString());
//         }

//         update();

//         isLoading(false);

//         update();
//         // Get.snackbar(
//         //   "",
//         //   "",
//         //   snackPosition: SnackPosition.TOP,
//         //   titleText: Text(jsonRes["message"].toString()),
//         //   messageText: Text(""),
//         //   colorText: Colors.red,
//         // );
//       } else {
//         // Get.snackbar(
//         //   "",
//         //   "",
//         //   snackPosition: SnackPosition.TOP,
//         //   titleText: Text(jsonRes["message"].toString()),
//         //   messageText: Text(""),
//         //   colorText: Colors.red,
//         // );

//         isLoading(false);
//         update();
//       }
//     } else {
//       Get.snackbar(
//         "",
//         "",
//         snackPosition: SnackPosition.TOP,
//         titleText: Text("Please try later"),
//         messageText: Text(""),
//         colorText: Colors.red,
//       );

//       isLoading(false);
//       update();
//     }



//   }











  

}