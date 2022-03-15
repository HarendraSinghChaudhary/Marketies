// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/utils/constant.dart';






class DefaultButton extends StatelessWidget {
  const DefaultButton({
    required this.width,
    required this.height,
     Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final Function() press;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: kPrimaryColor,
        onPressed: press,
        child: Text(
          text,
         
        style: GoogleFonts.cabin(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}