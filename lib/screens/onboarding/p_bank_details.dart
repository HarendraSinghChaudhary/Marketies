// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/components/p_default_button.dart';
import 'package:marketies/screens/onboarding/p_kyc.dart';
import 'package:marketies/screens/onboarding/p_login.dart';
import 'package:marketies/utils/constant.dart';
import 'package:marketies/utils/widget.dart';

class PBankDetails extends StatefulWidget {
  const PBankDetails({Key? key}) : super(key: key);

  @override
  State<PBankDetails> createState() => _PBankDetailsState();
}

class _PBankDetailsState extends State<PBankDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            space(h * 0.1),
            Text(
              "Submit Your Bank Details!",
              style: GoogleFonts.cabin(
                  color: pWhiteColor,
                  fontSize: w * 0.055,
                  fontWeight: FontWeight.w700),
            ),
            space(h * 0.015),
            Center(
              child: Text(
                "You will recieve your payout only on this account.",
                style: GoogleFonts.cabin(
                    foreground: Paint()..shader = linearGradient,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w600),
              ),
            ),
            space(h * 0.04),
            nameFormField(),
            space(h * 0.02),
            accountNumberFormField(),
            space(h * 0.02),
            confirmAccountNumberFormField(),
            space(h * 0.02),
            ifscCodeFormField(),
            space(h * 0.02),
            bankNameFormField(),
            space(h * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: h * 0.07,
                  width: w * 0.64,
                  decoration: BoxDecoration(
                    color: pPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Bank Proof(Optional)",
                      style: GoogleFonts.cabin(
                          color: pWhiteColor,
                          fontSize: w * 0.043,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Container(
                  height: h * 0.07,
                  width: w * 0.25,
                  decoration: BoxDecoration(
                    color: pWhiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.photo_camera,
                    size: 33,
                  )),
                ),
              ],
            ),
            space(h * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: h * 0.07,
                  width: w * 0.64,
                  decoration: BoxDecoration(
                    color: pPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Upload Pan Card Image",
                      style: GoogleFonts.cabin(
                          color: pWhiteColor,
                          fontSize: w * 0.043,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Container(
                  height: h * 0.07,
                  width: w * 0.25,
                  decoration: BoxDecoration(
                    color: pWhiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.photo_camera,
                    size: 33,
                  )),
                ),
              ],
            ),
            space(h * 0.04),
            PDefaultButton(
                width: double.infinity,
                height: h * 0.08,
                text: "Verify",
                press: () {
                  Get.to(() => Pkyc());
                }),
          ],
        ),
      ),
    );
  }

  // full name textfield

  TextFormField nameFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Email address or UniqueId is required';
        }
        // if (!GetUtils.isEmail(val)) {
        //   return 'Email address ';
        // }
        return null;
      },
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
      // controller: emailController,

      style: TextStyle(
          color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.emailAddress,
      cursorColor: pWhiteColor,
      decoration: InputDecoration(
        fillColor: pPrimaryColor,
        // fillColor: Colors.black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        counterText: '',
        hintText: "Full Name ",
        hintStyle: TextStyle(
            color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: pPrimaryColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: pPrimaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor, width: 1.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),

        prefixIconConstraints: BoxConstraints(minWidth: 4),

        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.person_rounded,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }

  // account number textfiled

  TextFormField accountNumberFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Email address or UniqueId is required';
        }
        // if (!GetUtils.isEmail(val)) {
        //   return 'Email address ';
        // }
        return null;
      },
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
      // controller: emailController,

      style: TextStyle(
          color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.emailAddress,
      cursorColor: pWhiteColor,
      decoration: InputDecoration(
        fillColor: pPrimaryColor,
        // fillColor: Colors.black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        counterText: '',
        hintText: "Account Number",
        hintStyle: TextStyle(
            color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: pPrimaryColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: pPrimaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor, width: 1.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),

        prefixIconConstraints: BoxConstraints(minWidth: 4),

        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.account_balance,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }

// confirm account number textfield

  TextFormField confirmAccountNumberFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Email address or UniqueId is required';
        }
        // if (!GetUtils.isEmail(val)) {
        //   return 'Email address ';
        // }
        return null;
      },
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
      // controller: emailController,

      style: TextStyle(
          color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.emailAddress,
      cursorColor: pWhiteColor,
      decoration: InputDecoration(
        fillColor: pPrimaryColor,
        // fillColor: Colors.black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        counterText: '',
        hintText: "Confirm Account Number",
        hintStyle: TextStyle(
            color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: pPrimaryColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: pPrimaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor, width: 1.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),

        prefixIconConstraints: BoxConstraints(minWidth: 4),

        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.account_balance,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }

// ifsc textfield

  TextFormField ifscCodeFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Email address or UniqueId is required';
        }
        // if (!GetUtils.isEmail(val)) {
        //   return 'Email address ';
        // }
        return null;
      },
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
      // controller: emailController,

      style: TextStyle(
          color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.emailAddress,
      cursorColor: pWhiteColor,
      decoration: InputDecoration(
        fillColor: pPrimaryColor,
        // fillColor: Colors.black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        counterText: '',
        hintText: "IFSC Code",
        hintStyle: TextStyle(
            color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: pPrimaryColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: pPrimaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor, width: 1.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),

        prefixIconConstraints: BoxConstraints(minWidth: 4),

        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.account_balance,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }

// bank name

  TextFormField bankNameFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Email address or UniqueId is required';
        }
        // if (!GetUtils.isEmail(val)) {
        //   return 'Email address ';
        // }
        return null;
      },
      // autovalidateMode:
      //     AutovalidateMode.onUserInteraction,
      // controller: emailController,

      style: TextStyle(
          color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.emailAddress,
      cursorColor: pWhiteColor,
      decoration: InputDecoration(
        fillColor: pPrimaryColor,
        // fillColor: Colors.black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        counterText: '',
        hintText: "Bank Name",
        hintStyle: TextStyle(
            color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: pPrimaryColor,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: pPrimaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: pWhiteColor, width: 1.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),

        prefixIconConstraints: BoxConstraints(minWidth: 4),

        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(
            Icons.account_balance,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }
}
