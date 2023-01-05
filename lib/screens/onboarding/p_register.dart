// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/components/p_default_button.dart';
import 'package:marketies/screens/onboarding/p_bank_details.dart';
import 'package:marketies/screens/onboarding/p_login.dart';
import 'package:marketies/utils/constant.dart';
import 'package:marketies/utils/widget.dart';

class PRegister extends StatelessWidget {
  const PRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              space(h * 0.1),
              Text(
                "We can't wait for you to join us!",
                style: GoogleFonts.cabin(
                    foreground: Paint()..shader = linearGradient,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              space(h * 0.1),
              space(h * 0.02),
              nameFormField(),
              space(h * 0.02),
              mobileFormField(),
              space(h * 0.02),
              emailFormField(),
              space(h * 0.02),
              passwordFormField(),
              space(h * 0.02),
              refferalFormField(),
              space(h * 0.02),
              PDefaultButton(
                  width: double.infinity,
                  height: h * 0.08,
                  text: "Register",
                  press: () {
                    Get.to(() => PBankDetails());
                  }),
              space(h * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.cabin(
                        color: pWhiteColor,
                        fontSize: w * 0.04,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.cabin(
                          foreground: Paint()..shader = linearGradient,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              space(h * 0.1),
              Text(
                "Terms of use & Privacy Policy",
                style: GoogleFonts.cabin(
                    color: pWhiteColor,
                    fontSize: w * 0.04,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
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

// mobile number textfield

  TextFormField mobileFormField() {
    return TextFormField(
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Phone number is required';
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
        hintText: "Mobile Number ",
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
            Icons.phone,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }

// email textfield
  TextFormField emailFormField() {
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
      decoration: const InputDecoration(
        fillColor: pPrimaryColor,
        // fillColor: Colors.black,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        counterText: '',
        hintText: "Email ",
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
            Icons.mail_outline,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }

// password textfield
  TextFormField passwordFormField() {
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
        hintText: "Password ",
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
            Icons.lock,
            color: pWhiteColor,
          ),
        ),
      ),
    );
  }

// refferal code textfield

  TextFormField refferalFormField() {
    return TextFormField(
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
        hintText: "Refferal Code ",
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
            child: SvgPicture.asset(
              "assets/picons/percentage.svg",
              width: w * 0.07,
              color: pWhiteColor,
            )),
      ),
    );
  }
}
