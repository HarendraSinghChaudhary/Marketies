// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketies/Testing/controller_data.dart';
import 'package:marketies/Testing/controller_my.dart';
import 'package:marketies/Testing/workers.dart';



class SendData extends StatefulWidget {
 
  

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<SendData> {

 MyController myController = Get.put(MyController());

  // var name = "tom".obs;

  // var count = 0.obs;

  // var student = Student(name:"tom", age: 25).obs;

  // void incriment() {
  //   count++;
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cardsnk(),
            dailogeBox(),
            bottomCard(),

            TextButton(onPressed: (){
              Get.toNamed("/getData?channel=First video&content= flutter X",
              arguments: "name from previous screen",

              
             // fullscreenDialog: true,
             
            //  curve: Curves.bounceIn

              );
              
            }, 
            child: Text("Go to Get Data Screen")),

            // Obx(() =>Text("Count is "+count.toString()),
            


            // ),


            
            TextButton(
              onPressed: () {
                // incriment();
                // print("count "+count.toString());
              }, 
              child: Text("Press!")),

               Obx(() =>Text("Name is "+myController.student.name.toString()),
            


            ),


            
            TextButton(
              onPressed: () {
               // name.value = name.value.toUpperCase();

               //student.value.name = student.value.name.toUpperCase();

              //  student.update((student) {
              //    student!.name = student.name.toString().toUpperCase();

              //  });

              myController.convertUpperCase();
               
                // print("count "+name.toString());
              }, 
              child: Text("Press!"))
          ],
        ),
      ),
      
    );
  }

  TextButton bottomCard() {
    return TextButton(onPressed: () {

            Get.bottomSheet(
              Container(
                color: Colors.white,
                height: 200,
                child: Wrap(
                  children: [
                    ListTile(
                      leading: Icon(Icons.wb_sunny_outlined),
                      title: Text("Light Theme"),
                      onTap: () {
                        Get.changeTheme(ThemeData.light());
                      
                      },
                    ),

                     ListTile(
                      leading: Icon(Icons.wb_sunny),
                      title: Text("Dark Theme"),
                      onTap: () {
                          Get.changeTheme(ThemeData.dark());
                        
                      },
                    )
                  ],
                ),
              )
            );

          }, child: Text("BottomSheet!"));
  }

  TextButton dailogeBox() {
    return TextButton(onPressed: (){
            Get.defaultDialog(
              // title: "Please select one",
              backgroundColor: Colors.orange,
              radius: 10,


              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20,),
                  Expanded(child: Text("Data Loading..."))
                ],

              ),

              textCancel: "Cancel",
              cancelTextColor: Colors.white,
              textConfirm: "Confirm",
              confirmTextColor: Colors.white,
              onCancel: () {},
              onConfirm: (){},
              barrierDismissible: false
              //for 


            );
          }, 
          child: Text("Dialogue Button!"));
  }

  TextButton cardsnk() {
    return TextButton(
            onPressed: (){
              Get.to(WorkersClass());
              Get.snackbar(
                "",
                ""
                
                ,
                snackPosition: SnackPosition.BOTTOM,
                titleText: Text("Good Morning"),
                messageText: Text("Have a nice day!"),
                colorText: Colors.red,
                borderRadius: 60,
                maxWidth: double.infinity,
                // animationDuration: Duration(seconds: ),
                duration: Duration(milliseconds: 1000),
                backgroundGradient: LinearGradient(colors: [
                  Colors.red,
                  Colors.yellow
                ]),
                icon: Icon(Icons.send, color: Colors.red,),
               onTap: (val) {
                 print("val: "+val.toString());
                 

               },
               padding: EdgeInsets.all(50),
               overlayBlur: 5,
               snackbarStatus: (Value) {
                 print(Value.toString());

               },

              //  userInputForm: Form(child: Row(
              //    children: [
              //      Expanded(child: TextField())
              //    ],
              //  ))
               

              );
            }, 
            child: Text("Press here!"));
  }
}



