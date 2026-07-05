import 'package:flutter/material.dart';
import 'package:glowy/presentation/resources/font_manager.dart';

// ignore: unused_element
TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    fontFamily: FontConstants.fontFamily,
  );
}

//regular style
TextStyle getRegularStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.regular,
  required Color color,
}) {
  return _getTextStyle(fontSize, fontWeight, color);
}

// getBoldStyle
TextStyle getBoldStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.bold,
  required Color color,
}) {
  return _getTextStyle(fontSize, fontWeight, color);
}

//getMediumStyl
TextStyle getMediumStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.medium,
  required Color color,
}) {
  return _getTextStyle(fontSize, fontWeight, color);
}

// getLightStyle
TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.light,
  required Color color,
}) {
  return _getTextStyle(fontSize, fontWeight, color);
}

// getSemiboldStyle
TextStyle getSemiboldStyle({
  double fontSize = FontSize.s12,
  FontWeight fontWeight = FontWeightManager.semiBold,
  required Color color,
}) {
  return _getTextStyle(fontSize, fontWeight, color);
}
