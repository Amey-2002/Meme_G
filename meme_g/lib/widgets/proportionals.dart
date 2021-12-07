import 'package:flutter/material.dart';

double getScreenProportionHeight(double actualHeight, Size size) {
  return (actualHeight / 896.0) - size.height;
}

double getScreenProportionWidth(double actualWidth, Size size) {
  return (actualWidth / 414.0) - size.width;
}
