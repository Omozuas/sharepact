import 'package:flutter/material.dart';

double responsiveHeight(BuildContext context, double factor) {
  return MediaQuery.of(context).size.height * factor;
}

double responsiveWidth(BuildContext context, double factor) {
  return MediaQuery.of(context).size.width * factor;
}
