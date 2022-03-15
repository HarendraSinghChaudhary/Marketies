// // ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_new

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:marketies/apiModule/api_client.dart';
// import 'package:http/http.dart' as http;
// import 'package:marketies/models/lead_list_model.dart';


// import 'package:shared_preferences/shared_preferences.dart';

// class ChangePasswordController extends GetxController {
//   var iSLoading = false.obs;

//   RxList leadList = [].obs;



//   Future<dynamic> searchData(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var id = prefs.getString("id");
//     print("id Print: " + id.toString());
//     print("key Print: " + key.toString());

//     String msg = "";
//     var jsonRes;
//     http.Response? res;
//     var request = http.post(
//         Uri.parse(
//           RestDatasource.JOBAPPLY_URL,
//         ),
//         body: {
       
//           "key": key.toString().trim(),
//         });

//     var jsonArray;

//     await request.then((http.Response response) {
//       res = response;
//       final JsonDecoder _decoder = new JsonDecoder();
//       jsonRes = _decoder.convert(response.body.toString());
//       print("Response: " + response.body.toString() + "_");
//       print("ResponseJSON: " + jsonRes.toString() + "_");
//       jsonArray = jsonRes['data'];
//     });

//     if (res!.statusCode == 200) {
//       if (jsonRes["status"] == true) {
//         // bannerList.clear();

//         for (var i = 0; i < jsonArray.length; i++) {
//           LeadListModel  modelAgentSearch = new LeadListModel();
//           modelAgentSearch.id = jsonArray[i]["id"].toString();
//           modelAgentSearch.user_id = jsonArray[i]["user_id"].toString();
//           modelAgentSearch.job_id = jsonArray[i]["job_id"].toString();
//           modelAgentSearch.status = jsonArray[i]["status"].toString();
//           modelAgentSearch.title = jsonArray[i]["job"]["title"].toString();
//           modelAgentSearch.photo = jsonArray[i]["job"]["photo"].toString();
//           modelAgentSearch.description = jsonArray[i]["job"]["description"].toString();
//           modelAgentSearch.job_type = jsonArray[i]["job"]["job_type"].toString();
//           // modelAgentSearch.status= jsonArray[i]["status"].toString();
//           modelAgentSearch.created_at = jsonArray[i]["job"]["created_at"].toString();

//           print("id: " + modelAgentSearch.id.toString());

//           // bannerList.add(modelSearch);
//         }

//         iSLoading(false);

//         Get.snackbar(
//           "",
//           "",
//           snackPosition: SnackPosition.TOP,
//           titleText: Text(jsonRes["message"].toString()),
//           colorText: Colors.red,
//         );
//       } else {
//         Get.snackbar(
//           "",
//           "",
//           snackPosition: SnackPosition.TOP,
//           titleText: Text("Please try later"),
//           colorText: Colors.red,
//         );
//         iSLoading(false);
//       }
//     }
//   }



// }
