
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


//reusable text
Widget reusableText(
    String text,
    Color color,
    double fontSize,
    FontWeight weight,
    double letterSpacing, {
      textAlign = TextAlign.start,
      maxLines = 2,
      FontStyle? fontStyle,
      TextOverflow? textOverflow,
      TextDecoration? decoration,
    }) {
  return Text(
    text,
    maxLines: maxLines,
    textAlign: textAlign,
    overflow: textOverflow,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: weight,
      letterSpacing: letterSpacing,
      decoration: decoration,
    ),
  );
}


//sized box
Widget sb({
  double? h = 0,
  double? w = 0,
  Widget? c,
}) {
  return SizedBox(
    height: h?.toDouble(), width: w?.toDouble(), child: c,);
}


//text color
const textColor = Color(0xFF101840);


//navigation
class NavigationHelper {

  static void navigateToPageRLW(BuildContext context, Widget page,
      Widget currentPage) {
    Navigator.push(
      context,
      PageTransition(
        isIos: Platform.isIOS,
        childCurrent: currentPage,
        child: page,
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}