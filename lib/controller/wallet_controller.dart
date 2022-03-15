




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http; 
import 'package:get/get.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:marketies/controller/wallet_history_controller.dart';
import 'package:marketies/models/wallet_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class WalletController extends GetxController {
  RxBool isLoading = false.obs;
  RxString totalAmount = "".obs;
//  var totalAmount =Rx<String> ('');
  RxString currentAmount = "".obs;
  RxString status = "".obs;
  RxList walletHistoryList = [].obs;

  var kycStatus = "";

  RxList creditHistoryList = [].obs;

   @override
  void onInit() {

    isLoading(true);
    walletApi();

 creditHistoryApi();
    walletHistoryApi();
  
    
    super.onInit();
  }


  

  Future<dynamic> walletApi( ) async {

    print("Api Running");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("id");
    print("id Print: " + id.toString());
  

    isLoading(true);
   
    String msg = "";
    
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(
          RestDatasource.WALLET_URL,
        ),
        body: {
          "userId": id.toString().trim(),
          
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
   
      if (jsonRes["success"] == true) {

         SharedPreferences prefs = await SharedPreferences.getInstance();





       

         if (jsonRes["data"]["kycStatus"] == null) {

           prefs.setString('kycStatus', "0");
           
         } else {
            prefs.setString('kycStatus', jsonRes["data"]["kycStatus"]["kycStatus"].toString());
              kycStatus = jsonRes["data"]["kycStatus"]["kycStatus"].toString();
     
         }
       
       
        prefs.commit();


        print("update kyc: "+kycStatus.toString());




       

      //  totalAmount= 
      totalAmount= jsonRes["data"]["myWallet"]["total_wallet_amount"].toString().obs;

   
       //currentAmount = 
      currentAmount= jsonRes["data"]["myWallet"]["current_wallet_amout"].toString().obs;
        //  status = jsonRes["data"]["myWallet"]["status"].RxString();

     



         print("total amount: "+jsonRes["data"]["myWallet"]["total_wallet_amount"]. toString());
         print("current amount: "+currentAmount.toString());


         update();
    
       

        // Get.snackbar(
        //   msg.toString(),
        //   "",
        //   snackPosition: SnackPosition.TOP,
        // );

       
        // Get.offAllNamed("/homeNav");

        isLoading(false);

        update();
        update();
        return;
        print("endofapi");
      } else {
        isLoading(false);
        update();
        Get.snackbar(
          msg.toString(),
          "",
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
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

 



  Future<dynamic> withdrawalApi(String amount, ) async {

         SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("id");
    print("id Print: " + id.toString());
   
     isLoading(true);
    print(amount);
    // print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(

          RestDatasource.WITHDRAWAL_URL,
         
        ),
        body: {
          "userId": id.toString(),
          "amount": amount.toString(),
          
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
      if (jsonRes["success"] == true) {

       walletApi();

        walletHistoryApi();

        update();

       
   

  

       

       isLoading(false);

       update();
      }else{
         isLoading(false);
         update();
     

      }
    } else {

      




     isLoading(false);

     update();
    }
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
    
    });

    if (res!.statusCode == 200) {
        final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(res!.body.toString());
      print("Response: " + res!.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      msg = jsonRes["message"].toString();
      jsonArray = jsonRes['data']['data'];
      print(jsonRes["status"]);

      if (jsonRes['data']["status"].toString() == "true") {
        for (var i = 0; i < jsonArray.length; i++) {
          WalletHistoryModel modelAgentSearch = new WalletHistoryModel();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.user_id = jsonArray[i]["user_id"].toString();
          modelAgentSearch.amount = jsonArray[i]["amount"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();

          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          

          walletHistoryList.add(modelAgentSearch);

          print("object: " + jsonArray[i]["amount"].toString());
        }

        update();

        isLoading(false);
        update();
        // Get.snackbar(
        //   "",
        //   "",
        //   snackPosition: SnackPosition.TOP,
        //   titleText: Text(jsonRes["message"].toString()),
        //   messageText: Text(""),
        //   colorText: Colors.red,
        // );
      } else {
        // Get.snackbar(
        //   "",
        //   "",
        //   snackPosition: SnackPosition.TOP,
        //   titleText: Text(jsonRes["message"].toString()),
        //   messageText: Text(""),
        //   colorText: Colors.red,
        // );

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




 Future<dynamic> creditHistoryApi() async {
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
      jsonArray = jsonRes['data']['creditedrequests'];
    });

    if (res!.statusCode == 200) {
      print(jsonRes["status"]);

      if (jsonRes['data']["status"].toString() == "true") {
        for (var i = 0; i < jsonArray.length; i++) {
          WalletHistoryModel modelAgentSearch = new WalletHistoryModel();
          modelAgentSearch.id = jsonArray[i]["id"].toString();
          modelAgentSearch.user_id = jsonArray[i]["user_id"].toString();
          modelAgentSearch.amount = jsonArray[i]["amount"].toString();
          modelAgentSearch.status = jsonArray[i]["status"].toString();

          modelAgentSearch.created_at = jsonArray[i]["created_at"].toString();
          

          creditHistoryList.add(modelAgentSearch);

          print("object: " + jsonArray[i]["amount"].toString());
        }


        update();

        isLoading(false);
        update();
        // Get.snackbar(
        //   "",
        //   "",
        //   snackPosition: SnackPosition.TOP,
        //   titleText: Text(jsonRes["message"].toString()),
        //   messageText: Text(""),
        //   colorText: Colors.red,
        // );
      } else {
        // Get.snackbar(
        //   "",
        //   "",
        //   snackPosition: SnackPosition.TOP,
        //   titleText: Text(jsonRes["message"].toString()),
        //   messageText: Text(""),
        //   colorText: Colors.red,
        // );

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








}
