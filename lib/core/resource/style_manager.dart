import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/font_manager.dart';
import 'package:flutter/material.dart';


TextStyle _getTextStyle(double fontSize ,String fontFamily,FontWeight fontWeight,Color color){
  return TextStyle(fontSize:fontSize,fontFamily: fontFamily, fontWeight: fontWeight, color: color);
}
//regular style
TextStyle getRegularStyle({double fontSize=FontSize.s12,required Color color}){

  return _getTextStyle(fontSize, FontConstants.fontFamily,FontWeightManager.regural, color);
}
//light text style
TextStyle getLightStyle({double fontSize=FontSize.s12,required Color color}){

  return _getTextStyle(fontSize, FontConstants.fontFamily,FontWeightManager.light, color);
}

//mediun text style
TextStyle getMediunStyle({double fontSize=FontSize.s12,required Color color}){

  return _getTextStyle(fontSize, FontConstants.fontFamily,FontWeightManager.medium, color);
}
//light text style
TextStyle getSemiBoldStyle({double fontSize=FontSize.s12,required Color color}){

  return _getTextStyle(fontSize, FontConstants.fontFamily,FontWeightManager.medium, color);
}
//light text style
TextStyle getBoldStyle({double fontSize=FontSize.s18,required Color color}){

  return _getTextStyle(fontSize, FontConstants.fontFamily,FontWeightManager.bold, color);
}



// CHINI

TextStyle getSmallStyle({double fontSize=FontSize.s12, FontWeight fontWeight = FontWeightManager.regural, Color color = ColorsManager.secondaryTextColor}){

  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getMediumStyle({double fontSize=FontSize.s14, FontWeight fontWeight = FontWeightManager.regural, Color color = ColorsManager.primaryTextColor}){

  return _getTextStyle(fontSize, FontConstants.fontFamily,fontWeight, color);
}

TextStyle getExtraMediumStyle({double fontSize=FontSize.s16, FontWeight fontWeight = FontWeightManager.regural, Color color = ColorsManager.primaryTextColor}){

  return _getTextStyle(fontSize, FontConstants.fontFamily,fontWeight, color);
}

TextStyle getSemiLargeStyle({double fontSize=FontSize.s24, FontWeight fontWeight = FontWeightManager.semiBold, Color color = ColorsManager.primaryTextColor}){

  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

TextStyle getLargeStyle({double fontSize=FontSize.s28, FontWeight fontWeight = FontWeightManager.bold, Color color = ColorsManager.primaryTextColor}){

  return _getTextStyle(fontSize, FontConstants.fontFamily, fontWeight, color);
}

// CHINI
