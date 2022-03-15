// ignore_for_file: avoid_print, prefer_const_constructors, prefer_typing_uninitialized_variables, unnecessary_new

import 'dart:convert';


import 'package:get/get.dart';


import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;

import 'package:marketies/models/get_leads_data_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GetLeadDataController extends GetxController {
  RxBool isLoading = false.obs;
  RxList getListDataList = [].obs;

  RxList oddList = [].obs;
  RxList evenList = [].obs;

  @override
  void onInit() {
    isLoading(true);
    getLeadDataApi();
    super.onInit();
  }

  Future<dynamic> getLeadDataApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("id");
    print("id Print: " + id.toString());

    isLoading(true);
    // print(email);
    // print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(
          RestDatasource.GETAPI,
        ),
        body: {
          "userId": id.toString().trim(),
        });
    var statusIs;
    var jsonArray;
    var dataLeads;

    await request.then((http.Response response) {
      res = response;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      msg = jsonRes["message"].toString();
      jsonArray = jsonRes['data']['leadsList'];
      statusIs = jsonRes['data']['status'].toString();

      print("statuys aa: "+jsonRes['data']['status'].toString());

        if (jsonRes['data']['status'].toString() == "false") {

            isLoading(false);

            update();
            
          }


    });

 

    if (res!.statusCode == 200) {
      getListDataList.clear();
      update();


      if (jsonRes["success"] == true) {

        getListDataList.clear();
        for (var i = 0; i < jsonArray.length; i++) {
          GetLeadsDataModel modelAgentSearch = new GetLeadsDataModel();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.user_id = jsonArray[i]["user_id"].toString();
          modelAgentSearch.job_id = jsonArray[i]["job_id"].toString();
          modelAgentSearch.name = jsonArray[i]["name"].toString();
          modelAgentSearch.mobile = jsonArray[i]["mobile"].toString();
          modelAgentSearch.reason = jsonArray[i]["reason"].toString();
          modelAgentSearch.points = jsonArray[i]["points"].toString();
          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();
          if(jsonArray[i]['job']!=null){
          modelAgentSearch.title = jsonArray[i]['job']["title"].toString();
          modelAgentSearch.photo = jsonArray[i]['job']["photo"].toString();
          modelAgentSearch.description =
              jsonArray[i]['job']["description"].toString();
          modelAgentSearch.job_type =
              jsonArray[i]['job']["job_type"].toString();
          modelAgentSearch.status1 = jsonArray[i]['job']["status"].toString();
        }
          modelAgentSearch.leads_data = jsonArray[i]["leads_data"].toString();

          dataLeads = jsonArray[i]["leads_data"];


        

          for (int j = 0; j < dataLeads.length; j++) {
            SubData filterModel = new SubData();
            filterModel.field_name = dataLeads[j]["field_name"].toString();
            filterModel.field_value = dataLeads[j]["field_value"].toString();

            modelAgentSearch.subLifeStyle.add(filterModel);

            print(".......even...." + dataLeads[j]["field_name"].toString());
          }

          print(".......odd...." + oddList.toString());
          if(jsonArray[i]['job']!=null){
          getListDataList.add(modelAgentSearch);
          }

           isLoading(false);

          update();

          

    


        }

       update();

       
      } else {
        isLoading(false);
         update();
        Get.snackbar(
          msg.toString(),
          "",
          snackPosition: SnackPosition.TOP,
        );
      }

      return;
    } else {
      Get.snackbar(
        'Error while fetching data',
        "",
        snackPosition: SnackPosition.TOP,
      );

      isLoading(false);
      update();
      return;
    }
  }
}
