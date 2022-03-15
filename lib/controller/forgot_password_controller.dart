import 'dart:convert';


import 'package:get/get.dart';

import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/controller/wallet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';





class ForgotPasswordController extends GetxController {

var isLoading = false.obs;






    Future<dynamic> forgotPasswordApi(String email, ) async {

         SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("id");
    print("id Print: " + id.toString());
   
     isLoading(true);
    print(email);
    // print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(

          RestDatasource.FORGOTPASSWORD_URL,
         
        ),
        body: {
          "emailAddress": email.toString(),
         
          
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
    });
    if (res!.statusCode == 200) {
      if (jsonRes["success"] == true) {

        Get.toNamed("/login");

        
   

    // Get.snackbar(msg.toString(), "",  snackPosition: SnackPosition.TOP,);

       

       isLoading(false);
      }else{
         isLoading(false);
     

      }
    } else {

  




     isLoading(false);
    }
  }






}