// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:marketies/utils/constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ExitController extends GetxController {
//   exit() {
//     Get.defaultDialog(
//         contentPadding: EdgeInsets.all(10),
//         title: "",

//         // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

//         content: Column(
//           children: [
//             Text("Do you want to exit?",
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.cabin(
//                     color: Colors.black,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500)),
//             SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               width: 140,
//               height: 40,
//               child: FlatButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 color: kPrimaryColor,
//                 onPressed: () {
//                   print('yes selected');
//                   exit();
//                 },
//                 child: Text(
//                   "Yes",
//                   style: GoogleFonts.cabin(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             SizedBox(
//               width: 140,
//               height: 40,
//               child: FlatButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 onPressed: () {
//                   Get.back();
//                 },
//                 child: Text(
//                   "Cancel",
//                   style: GoogleFonts.cabin(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }





import 'dart:io';
import 'package:flutter/material.dart';

Future<bool> showExitPopup(context) async{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to exit?"),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('yes selected');
                          exit(0);
                        },
                        child: Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade800),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {
                        print('no selected');
                        Navigator.of(context).pop();
                      },
                      child: Text("No", style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
} 