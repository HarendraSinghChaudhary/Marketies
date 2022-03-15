



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketies/Testing/controller_my.dart';
import 'package:marketies/controller/job_controller.dart';



class AllControllerBinding implements Bindings {
  @override
  void dependencies() {

    Get.lazyPut<MyIncrementController>(() => MyIncrementController());
    Get.lazyPut<MyController>(() => MyController());
    JobController jobController = Get.put(JobController());
   
   
  }
  
}