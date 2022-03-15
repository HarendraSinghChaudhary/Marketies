// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketies/Testing/controller_my.dart';



class GetData extends StatelessWidget {


  MyIncrementController myController = Get.put(MyIncrementController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Get Data"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${Get.arguments}"),
            Text("channel name is ${Get.parameters['channel']} and video is ${Get.parameters['content']}"),

            SizedBox(height: 10),

          //  GetX<MyIncrementController>(
          //    init: MyIncrementController(),
          //    builder: (controller) {
          //      return Text("Count is "+ controller.count.toString());

          //    }),


          //    SizedBox(height: 20),


          //    TextButton(onPressed: () {
          //      Get.find<MyIncrementController>().increment();
          //    }, child: Text("Press here!")),





               SizedBox(height: 30),

           GetBuilder<MyIncrementController>(
             id: "1",
            // initState:(data) => myController.increment(),
            //  dispose: (_) => myController.cleanupTask(),
             builder: (controller) {
               return Text("Count is "+ controller.count.toString());

             }),


             SizedBox(height: 20),

              GetBuilder<MyIncrementController>(
             
            // initState:(data) => myController.increment(),
            //  dispose: (_) => myController.cleanupTask(),
             builder: (controller) {
               return Text("Count is "+ controller.count.toString());

             }),


             TextButton(onPressed: () {
               myController.increment();
             }, child: Text("Press here!")),
          ],
        ),
      ),
      
    );
  }
}




// class Leadss extends StatefulWidget {
//   const Leadss({ Key? key }) : super(key: key);

//   @override
//   _LeadsState createState() => _LeadsState();
// }

// class _LeadsState extends State<Leadss> {
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }