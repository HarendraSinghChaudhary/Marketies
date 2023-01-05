// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:marketies/components/p_default_button.dart';
import 'package:marketies/controller/login_controller.dart';
import 'package:marketies/screens/onboarding/p_register.dart';
import 'package:marketies/utils/constant.dart';
import 'package:marketies/utils/widget.dart';

class Plogin extends StatelessWidget {
  RxBool obsecure = false.obs;

  LoginController loginController =
      Get.put(LoginController(), permanent: false);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      child: SingleChildScrollView(
        child: Obx((() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                space(h * 0.03),
                Lottie.asset(
                  'assets/picons/llogin.json',
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      color: pWhiteColor,
                      fontSize: w * 0.05,
                      fontWeight: FontWeight.w700),
                ),
                space(h * 0.01),
                Text(
                  "Please login to continue",
                  style: TextStyle(
                      color: pWhiteColor,
                      fontSize: w * 0.03,
                      fontWeight: FontWeight.w400),
                ),
                space(h * 0.02),
                emailFormField(),
                space(h * 0.02),
                passwordFormField(),
                space(h * 0.02),
                PDefaultButton(
                    width: double.infinity,
                    height: h * 0.08,
                    text: "Login",
                    press: () {
                      print(
                          "email: ${emailController.text}, pass: ${passwordController.text}");
                      loginController.loginApi(
                          emailController.text, passwordController.text);
                    }),
                space(h * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 0.5,
                      width: w * 0.4,
                      color: pWhiteColor,
                    ),
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Text(
                      "OR",
                      style: TextStyle(
                          color: pWhiteColor,
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Container(
                      height: 0.5,
                      width: w * 0.4,
                      color: pWhiteColor,
                    )
                  ],
                ),
                space(h * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: h * 0.08,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(width: 0.7, color: pWhiteColor),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Login With OTP",
                        style: TextStyle(
                            color: pWhiteColor,
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w400),
                      )),
                ),
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
                        Get.to(() => PRegister());
                      },
                      child: Text(
                        "Register Now",
                        style: GoogleFonts.cabin(
                            foreground: Paint()..shader = linearGradient,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ))),
      ),
    ));
  }

  TextFormField emailFormField() {
    return TextFormField(
      controller: emailController,
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

  TextFormField passwordFormField() {
    return TextFormField(
      controller: passwordController,
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
      obscureText: obsecure.value,
      style: TextStyle(
          color: pWhiteColor, fontSize: 16, fontWeight: FontWeight.w400),
      keyboardType: TextInputType.emailAddress,
      cursorColor: pWhiteColor,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: obsecure.value
              ? const Icon(
                  Icons.visibility_off_outlined,
                  color: pWhiteColor,
                )
              : const Icon(
                  Icons.visibility_outlined,
                  color: pWhiteColor,
                ),
          onPressed: () {
            obsecure.value = !obsecure.value;
          },
        ),

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
}

// TextEditingController myController, TextInputType keyboardType, String hint, Icon newIcon

final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.yellow, Color(0xffB3713C)],
).createShader(Rect.fromLTRB(0, 20, 200, 200));
