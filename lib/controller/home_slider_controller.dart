


// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:marketies/apiModule/api_client.dart';
// import 'package:marketies/models/slider_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class HomeSliderController extends GetxController {
//   var isLoading = false.obs;
//   RxString ranking = "".obs;

//   RxList <dynamic> sliderUrl = [].obs;


//   String earning = "";
//   String leads = "";
//   String jobs = "";
//   String status = "";

//    RxList <dynamic> sliderList = [].obs;

//   List <String> linkUrl = [];

//    @override
//   void onInit() {
//     HomeSliderApi();
//     super.onInit();
//   }


  

//   Future<dynamic> HomeSliderApi(

//   ) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     var id = prefs.getString("id");
//     print("id Print: " + id.toString());
  

//     isLoading.value = true;
   
//     String msg = "";
    
//     var jsonRes;
//     var jsonArray;
//     http.Response? res;
//     var request = http.post(
//         Uri.parse(
//           RestDatasource.HOMESLIDER_URL,
//         ),
//         body: {
//           "userId": id.toString().trim(),
          
//         });

//     await request.then((http.Response response) {
//       res = response;
//       final JsonDecoder _decoder = new JsonDecoder();
//       jsonRes = _decoder.convert(response.body.toString());
//       print("Response: " + response.body.toString() + "_");
//       print("ResponseJSON: " + jsonRes.toString() + "_");
//       print("status: " + jsonRes["status"].toString() + "_");
//       print("message: " + jsonRes["message"].toString() + "_");
//       msg = jsonRes["message"].toString();
//       jsonArray = jsonRes['data']['banners'];

//     });
//     if (res!.statusCode == 200) {
//       if (jsonRes["success"] == true) {

//           for (var i = 0; i < jsonArray.length; i++) {
//           HomeSliderModel modelAgentSearch = new HomeSliderModel();
//           modelAgentSearch.id = jsonArray[i]["id"].toString();
//           modelAgentSearch.banner_pic = jsonArray[i]["banner_pic"].toString();
//           modelAgentSearch.link = jsonArray[i]["link"].toString();
         


              

//          sliderUrl.add(jsonArray[i]["banner_pic"].toString());
//          linkUrl.add(jsonArray[i]["link"].toString());
      

//           sliderList.add(modelAgentSearch);

//           print("object: "+ jsonArray[i]["banner_pic"].toString());

        
//         }





       

//       ranking = jsonRes["data"]["ranking"].toString().obs;

 
//       earning = jsonRes["data"]["earning"].toString();
//       leads= jsonRes["data"]["leads"].toString();
//       jobs = jsonRes["data"]["jobs"].toString();
       

     



//         //  print("total amount: "+jsonRes["data"]["earning"].toString());
//         //  print("current amount: "+jobs.toString());
    
       


       
      

//        isLoading(false);
//       } else {
//         isLoading(false);
       

        
//       }
//     } else {
    

//       isLoading(false);
//     }
//   }

 
// }
