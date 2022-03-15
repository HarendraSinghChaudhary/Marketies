// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketies/Testing/controller_my.dart';



class WorkersClass extends StatelessWidget {
  // MyIncrementController myController = Get.put(MyIncrementController(), );



  


  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      appBar: AppBar(title: Text("Workers"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: () {
           // myController.increment();

          }, 
          child: Text("Increment")),

          SizedBox(height: 40,),



          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) {
                // myController.increment();

                Get.find<MyIncrementController>().increment();

              },
            ),
          ),


          Text('hello'.tr),

          SizedBox(height: 10,),

          TextButton(
            onPressed: (){
              // myController.changeLanguage('hi', 'IN');

              Get.find<MyIncrementController>().changeLanguage('hi', 'IN');
            },
             child: Text("Hindi")),

             SizedBox(height: 10,),

          TextButton(
            onPressed: (){
              // myController.changeLanguage('en', 'US');
              Get.find<MyIncrementController>().changeLanguage('en', 'US');
            },
             child: Text("English")),

             SizedBox(height: 10,),

          TextButton(
            onPressed: (){
              // myController.changeLanguage('fr', 'FR');

              Get.find<MyIncrementController>().changeLanguage('fr', 'FR');
              

             Get.find<MyIncrementController>();
            },
             child: Text("French")),
        ],
      ),
      
    );
  }
}