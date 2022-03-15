

// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_this

import 'dart:ui';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:marketies/Testing/controller_data.dart';


class MyController extends GetxController {

  var student = Student();

  convertUpperCase () {
    student.name.value = student.name.value.toUpperCase();
  }



}

class MyIncrementController extends GetxController {

  var count = 0.obs;

  void increment () {
    count++;
    update(["1"]);
  }

  // @override
  // void onInit() {
  //   debounce(count, (_) => print("new count: "+count.toString()), time: Duration(seconds: 5));
  //   super.onInit();
  // }

//   var count = 0.obs;
//   var name = "roport";

//   void increment () async{

//    await Future.delayed(Duration(seconds: 2));

//   //  this.count+1;
//   this.name = "reported";
//    update();

//   }



//   void cleanupTask() {
//     print("Clean Up Task Successfully");
//   }



// //better approch

//   @override
//   void onInit() {
//   print("Method Start");
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     print("Method close");
 
//     super.onClose();
//   }
 changeLanguage( var param1, var param2){

   var locale = Locale(param1, param2);
   Get.updateLocale(locale);

 }


  



}



class Message extends Translations {
  @override

  Map<String, Map<String, String>> get keys => {
    'en_US': {'hello' : 'Hello'},
    'hi_IN': {'hello' : 'नमस्कार'},
    'fr_FR': {'hello' : 'Bonjour'},
  };
  
}