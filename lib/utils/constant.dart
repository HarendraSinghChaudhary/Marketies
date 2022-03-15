import 'package:flutter/material.dart';




const kPrimaryColor = Color(0xFF24A8FF);
const kPinkColor = Color(0xFFFF6895);
const kCyanColor = Color(0xFF33CCCC);
const kPurpleColor = Color(0xFFCC66FF);
const kSubtitleColor = Color(0xFF333333);
const kApprovedColor = Color(0xFF30B801);
const kTextFieldColor = Color(0xFF9D9D9D);
const kSliderColor = Color(0xFFF2F2F2);
const kmenuColor = Color(0xFF707070);
const kRedColor = Color(0xFFFA1100);
const kkycPrimeColor = Color(0xFFF6F6F6);
const kkycSecondaryColor = Color(0xFFCBCBCB);
const kLoginBackgroundColor = Color(0xFFEFF1F3);

const kPrimaryLightColor = Color(0xFFEFF1F3);
const kIconColor = Color(0xFF8E8E8E);
const kBackgroundColor = Color(0xFF262626);
const kIconBackgroundColor = Color(0XFFAAAAAA);

const kAnimationDuration = Duration(milliseconds: 200);


validateForm(GlobalKey<FormState> _formKey) {
  print('inside validation');
  FormState? form = _formKey.currentState;
  if (form!.validate()) {
    print('validated');
    return true;
  } else {
    return false;
  }
}