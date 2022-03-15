// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/controller/create_lead_controller.dart';
import 'package:marketies/controller/create_lead_fields_controller.dart';
import 'package:marketies/models/add_lead_model.dart';
import 'package:marketies/utils/constant.dart';

class CreateLead extends StatefulWidget {
  const CreateLead({Key? key}) : super(key: key);

  @override
  State<CreateLead> createState() => _CreateLeadState();
}

class _CreateLeadState extends State<CreateLead> {
  bool isloading = false;
  String image = "";
  String base64Image = "";
  String fileName = "";
  File? file;
  bool isLoading = false;
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ScrollController scrollController = new ScrollController();

  TextEditingController nameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();

  List<AddFields> _leadDatalist = List.empty(growable: true);

  var jobId = "";
  Map<String, String> map = HashMap();
 

      


      @override
      void initState() {
        super.initState();
         Get.lazyPut<CreateLeadFieldsController>(() => CreateLeadFieldsController());
        runApi();
      }

      void runApi()async{
        await Get.find<CreateLeadFieldsController>().createLeadFieldsApi();
        setState(() {
          
        });
      }

  @override
  Widget build(BuildContext context) {
    //jobId = Get.arguments.first.toString();

    var one = Get.parameters;

    jobId = one["jobId"].toString();

    print("...." + Get.parameters["jobId"].toString());

     Get.find<CreateLeadFieldsController>().updateID(jobId);

    Get.lazyPut<CreateLeadController>(() => CreateLeadController());

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            "Create Lead",
            style: GoogleFonts.cabin(color: Colors.black),
          ),
        ),
        body: Obx(() => 


         Get.find<CreateLeadFieldsController>().isLoading.value
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Platform.isAndroid
                                              ? CircularProgressIndicator()
                                              : CupertinoActivityIndicator())
                                      :

         Stack(
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
                            "Full Name",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: nameController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter full name';
                              }

                              return null;
                            },
                            maxLines: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[a-zA-Z]+|\s"))
                            ],
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              hintText: "Enter Full Name",
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
                            "Mobile Number",
                            style: GoogleFonts.cabin(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          TextFormField(
                            controller: mobileController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter phone number.';
                              }

                              if (val.length != 10) {
                                return 'Please enter valid phone number.';
                              }
                              return null;
                            },
                            maxLength: 10,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            style:
                                TextStyle(color: kTextFieldColor, fontSize: 14),
                            cursorColor: Colors.grey,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Enter Mobile Number",
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
                         ListView.builder(
                              controller: scrollController,
                              shrinkWrap: true,
                              itemCount:
                                  Get.find<CreateLeadFieldsController>().createLeadFiledsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Visibility(
                                  visible:  Get.find<CreateLeadFieldsController>()
                                          .createLeadFiledsList[index].field
                                          .toString() != "null" ? true : false,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // "City",
                                  
                                       Get.find<CreateLeadFieldsController>()
                                            .createLeadFiledsList[index].field
                                            .toString(),
                                        style: GoogleFonts.cabin(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      TextFormField(
                                        controller:  Get.find<CreateLeadFieldsController>()
                                            .createLeadFiledsList[index]
                                            .messageController,
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please enter ' +
                                                 Get.find<CreateLeadFieldsController>()
                                                    .createLeadFiledsList[index]
                                                    .field
                                                    .toString();
                                          }
                                  
                                          return null;
                                        },
                                        maxLines: 1,
                                        onChanged: (value) {
                                          map[ Get.find<CreateLeadFieldsController>()
                                              .createLeadFiledsList[index].field
                                              .toString()] = value.toString();
                                        },
                                        style: TextStyle(
                                            color: kTextFieldColor, fontSize: 14),
                                        cursorColor: Colors.grey,
                                        decoration: InputDecoration(
                                          hintText: "Enter " +
                                              Get.find<CreateLeadFieldsController>()
                                                  .createLeadFiledsList[index]
                                                  .field
                                                  .toString(),
                                          hintStyle: TextStyle(
                                              color: kTextFieldColor,
                                              fontSize: 14),
                                          focusColor: kTextFieldColor,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),






                           Visibility(
                              visible: Get.find<CreateLeadFieldsController>()
                                        .image
                                        .toString() !=
                                    "0"
                                ? true
                                : false,
                             child: Text(
                              //"Image",

                              Get.find<CreateLeadFieldsController>()
                                        .textImage
                                        .toString(),
                              style: GoogleFonts.cabin(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                                                     ),
                           ),

                          Visibility(
                             visible: Get.find<CreateLeadFieldsController>()
                                        .image
                                        .toString() !=
                                    "0"
                                ? true
                                : false,
                            
                            child: SizedBox(height: 15)),



                          Visibility(
                            visible: Get.find<CreateLeadFieldsController>()
                                        .image
                                        .toString() !=
                                    "0"
                                ? true
                                : false,
                            child: GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: file == null
                                  ? Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                            "Upload Screenshot",
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
                                        border: Border.all(
                                            color: kkycSecondaryColor),
                                        image: DecorationImage(
                                            image: FileImage(
                                          File(file!.path),
                                        )),
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),


                           Get.find<CreateLeadController>().isLoading.value
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: Platform.isAndroid
                                              ? CircularProgressIndicator()
                                              : CupertinoActivityIndicator())
                                      :




                          DefaultButton(
                              width: double.infinity,
                              height: 50,
                              text: "Create Lead",
                              press: () {
                                 FocusScope.of(context).unfocus();
                                if (validateForm(_formKey) == true) {

                                  if (file == null) {

                                       Get.find<CreateLeadController>()
                                      . createLeadApi(
                                          jobId,
                                          nameController.text.toString(),
                                          mobileController.text.toString(),
                                          map);

                                          nameController.text = "";
                                          mobileController.text = "";
                                          map.clear();
                                          


                                    
                                  } else {

                                       Get.find<CreateLeadController>()
                                      . createLeadImageApi(
                                          jobId,
                                          nameController.text.toString(),
                                          mobileController.text.toString(),
                                          map, file);
                                          nameController.text = "";
                                          mobileController.text = "";
                                          map.clear();
                                        
                                  }








                                  print('validated');
                                }
                              }),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ))
  
        
        
        
        );
        
        
        
        
       
  
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        file = File(pickedFile.path);
      });
      base64Image = base64Encode(file!.readAsBytesSync());
    } else {
      file = File(pickedFile!.path);
      print('No image selected.');
    }

    // fileName = file!.path.split("/").last;
    print("ImageName: " + fileName.toString() + "_");
    print("Image: " + base64Image.toString() + "_");
    setState(() {});
  }
}
