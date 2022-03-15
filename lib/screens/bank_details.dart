// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/apiModule/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:marketies/screens/homenav.dart';
import 'package:marketies/screens/menu.dart';
import 'package:marketies/screens/otp_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/controller/kyc_controller.dart';
import 'package:marketies/utils/constant.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  _BankDetailsState createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  @override
  void initState() {
    super.initState();
  }

  String image = "";
  String base64Image = "";

  File? file;
  File? panFile;
  File? adharFrontFile;
  File? adharBackFile;
  File? bankFile;
  bool isLoading = false;
  final picker = ImagePicker();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // print("jobOneId: "+Get.parameters['panCard'].toString());
    // print("panId: " + Get.arguments[0].toString());
    Get.lazyPut<KycController>(() => KycController());
    var kyc = Get.parameters;
    //  var imageKyc = Get.arguments;
    //  panFile = imageKyc[1];
    //  adharFrontFile = imageKyc[3];
    //  adharBackFile = imageKyc[4];
    print("panfile" + Get.arguments[1].toString());
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Bank Details",
            style: GoogleFonts.cabin(color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/bg.png"),
                      fit: BoxFit.cover)),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bank Name",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: bankNameController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter bank name';
                              }

                              return null;
                            },
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter Bank Name",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Account Holder Name",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: nameController,

                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter account holder name';
                              }

                              return null;
                            },

                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            //  keyboardType: TextInputType.number,

                            decoration: InputDecoration(
                              hintText: "Enter Account Holder Name",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Account Number",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter account number';
                              }

                              return null;
                            },
                            controller: accountNumberController,
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter Account Number",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "IFSC Code",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: ifscController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter IFSC code';
                              }

                              return null;
                            },
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter IFSC Code",
                              hintStyle: TextStyle(
                                  color: kTextFieldColor, fontSize: 14),
                              focusColor: kTextFieldColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              fillColor: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Upload Bank passbook photo",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              getBankImage();
                            },
                            child: file == null
                                ? Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kkycPrimeColor,
                                        border: Border.all(
                                            color: kkycSecondaryColor)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/upload.png",
                                          width: 80,
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          "Bank passbook photo",
                                          style: GoogleFonts.cabin(
                                              color: kkycSecondaryColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ))
                                : Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kkycPrimeColor,
                                      border:
                                          Border.all(color: kkycSecondaryColor),
                                      image: DecorationImage(
                                          image: FileImage(
                                        File(file!.path),
                                      )),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          isLoading
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Platform.isAndroid
                                      ? CircularProgressIndicator()
                                      : CupertinoActivityIndicator())
                              : DefaultButton(
                                  width: double.infinity,
                                  height: 50,
                                  text: "Submit",
                                  press: () async{
                                   
                                    
                                    
                                    if (validateForm(_formKey) == true) {
                                      if (bankFile != null) {
                                         setState(() {
                                      isLoading = true;
                                    });
                               
                                       await kycApi(
                                          Get.arguments.first.toString(),
                                          Get.arguments[2].toString(),
                                          bankNameController.text.toString(),
                                          nameController.text.toString(),
                                          accountNumberController.text
                                              .toString(),
                                          ifscController.text.toString(),
                                        );
                                         setState(() {
                                      isLoading = false;
                                    });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please upload Bank passbook photo",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: kPrimaryColor,
                                            textColor: Colors.white,
                                            fontSize: 14.0);

                                                setState(() {
                                      isLoading = false;
                                    });
                                      }

                                      print('validated');
                                    }


                                    // kycApi(
                                    //   Get.arguments[0].toString(),
                                    //   Get.arguments[2].toString(),
                                    //   bankNameController.text.toString(),
                                    //   nameController.text.toString(),
                                    //   accountNumberController.text.toString(),
                                    //   ifscController.text.toString(),
                                    // );

                                   

                                    // Get.find<KycController>().kycApi(
                                    //   kyc['panCard'].toString(),
                                    //   kyc['aadharNumber'].toString(),
                                    //   bankNameController.text.toString(),
                                    //   nameController.text.toString(),
                                    //   accountNumberController.text.toString(),
                                    //   ifscController.text.toString(),

                                    //   );
                                  })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future<dynamic> kycApi(
    String pen_card,
    String aadhar_card,
    String bank_name,
    String account_holder_name,
    String account_numbers,
    String ifsc_code,
    // File panFile,
    // File aadharFrontFile,
    // File aadharBackFile,
    //  File bankImage
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var id = prefs.getString("id");
    print("id Print: " + id.toString());
    // print("jobID Print: " + jobId.toString());

    print("name: " + pen_card.toString());

    isLoading = true;

    var request = http.MultipartRequest(
      "POST",
      Uri.parse(
        RestDatasource.KYC_URL,
      ),
    );
    if (pen_card.toString() != "null" || pen_card.toString() != "") {
      request.fields["pen_card"] = pen_card.toString();
      print("pen_card: " + pen_card.toString());
    }

    if (aadhar_card.toString() != "null" || aadhar_card.toString() != "") {
      request.fields["aadhar_card"] = aadhar_card.toString();
      print("aadhar_card: " + aadhar_card.toString());
    }

    if (bank_name.toString() != "null" || bank_name.toString() != "") {
      request.fields["bank_name"] = bank_name.toString();
      print("bank_name: " + bank_name.toString());
    }

    if (account_holder_name.toString() != "account_holder_name" ||
        account_holder_name.toString() != "") {
      request.fields["account_holder_name"] = account_holder_name.toString();
      print("account_holder_name: " + account_holder_name.toString());
    }

    if (account_numbers.toString() != "null" ||
        account_numbers.toString() != "") {
      request.fields["account_numbers"] = account_numbers.toString();
      print("account_numbers: " + account_numbers.toString());
    }

    if (ifsc_code.toString() != "null" || ifsc_code.toString() != "") {
      request.fields["ifsc_code"] = ifsc_code.toString();
      print("ifsc_code: " + ifsc_code.toString());
    }

    request.fields["userId"] = id.toString();

    request.files.add(await http.MultipartFile.fromPath(
        "pen_card_image", Get.arguments[1]!.path));

        print("pen card"+ Get.arguments[1]!.path.toString());

    request.files.add(await http.MultipartFile.fromPath(
        "aadhar_card_front", Get.arguments[3]!.path));
        print("aadhar_card"+ Get.arguments[3]!.path.toString());

    request.files.add(await http.MultipartFile.fromPath(
        "aadhar_card_back", Get.arguments[4]!.path));

        print("aadhar_card_back"+ Get.arguments[4]!.path.toString());
        

    request.files
        .add(await http.MultipartFile.fromPath("bank_photo", bankFile!.path));

          print("bank_photo"+  bankFile!.path.toString());

    var jsonRes;
    var res = await request.send();

    if (res.statusCode == 200) {
      var respone = await res.stream.bytesToString();
      final JsonDecoder _decoder = new JsonDecoder();

      jsonRes = _decoder.convert(respone.toString());
      print("Response: " + jsonRes.toString() + "_");
      print(jsonRes["status"]);

      if (jsonRes["success"].toString() == "true") {
        Get.to(HomeNav(
          index: 0,
        ));

        //iSLoading(false);
        // Get.snackbar(
        //   jsonRes["message"].toString(),
        //   "",
        //   snackPosition: SnackPosition.BOTTOM,

        // );

        isLoading = false;
      } else {
        // iSLoading(false);

        Get.snackbar(
          "",
          "",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(jsonRes["message"].toString()),
          colorText: Colors.red,
        );

        isLoading = true;
      }
      return;
    } else {
      Get.snackbar(
        "",
        "",
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text("Please try later"),
        colorText: Colors.red,
      );

      isLoading = false;
      return;
      // iSLoading(false);
    }
  }

  Future getBankImage() async {
  
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    var bankfilee;

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
      base64Image = base64Encode(file!.readAsBytesSync());
    } else {
      print('No image selected.');
    }

    bankFile = file;

    bankfilee = file!.path.split("/").last;
    print("ImageName: " + bankFile.toString() + "_");
    print("Image: " + base64Image.toString() + "_");
    setState(() {
        isLoading = false;
    });
  }
}
