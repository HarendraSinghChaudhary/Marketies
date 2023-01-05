import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketies/utils/constant.dart';

// loading indicator
const loader = Center(
    child: CircularProgressIndicator.adaptive(
  strokeWidth: 1,
  backgroundColor: pWhiteColor,
));

// height and width
var h = Get.height;
var w = Get.width;

// space

Widget space(double? height, [double? width]) {
  return SizedBox(
    height: height,
    width: width,
  );
}

// scroll controller
final ScrollController scrollController = ScrollController();
