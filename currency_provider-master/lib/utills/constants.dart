import 'package:flutter/material.dart';

const String currencyBox = 'currency_box';
const String dateKey = 'date_key';
const String dateBox = 'date_box';
const String currencyListKey = 'currency_list_key';



TextStyle kTextStyle(
    {Color? color,
    double size = 14,
    FontWeight fontWeight = FontWeight.w500,
    double? letterSpacing,
    double? height}) {
  return TextStyle(
      color: color ?? Colors.white,
      fontSize: size,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height);
}