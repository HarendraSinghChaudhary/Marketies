import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/controller/wallet_controller.dart';
import 'package:marketies/controller/wallet_history_controller.dart';
import 'package:marketies/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawalController extends GetxController {
  RxBool isLoading = false.obs;

  // @override
  // void onInit() {

  //   isLoading(true);

  //   super.onInit();
  // }

  Future<dynamic> withdrawalApi(
    String amount,
  ) async {
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
      print("status: " + jsonRes["success"].toString() + "_");
      print("message: " + jsonRes["message"].toString() + "_");
      msg = jsonRes["message"].toString();
      print("printing");
      if (jsonRes["success"] == true) {
        Get.lazyPut<WalletController>(() => WalletController());

        Get.find<WalletController>().walletApi();

        Get.lazyPut<WalletHistoryController>(() => WalletHistoryController());

        Get.defaultDialog(
            contentPadding: EdgeInsets.all(10),
            title: "",

            // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

            content: Column(
              children: [
                SvgPicture.asset(
                  "assets/icons/success.svg",
                  width: 200,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("your withdrawal request has been successfully submitted",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cabin(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 140,
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Ok",
                      style: GoogleFonts.cabin(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ));

        print("run1");
        isLoading(false);
        update();

        Get.find<WalletHistoryController>().walletHistoryList.clear();
        Get.find<WalletHistoryController>().walletHistoryApi();
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
