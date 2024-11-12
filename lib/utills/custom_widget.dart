import 'package:flutter/material.dart';

class CustomWidget
{
  static InputDecoration textfileDecor({
    required String hintext,required String mLabel,
    Color borderColor = Colors.black,IconData? micon,
    double bRadius=11})
  {
    return InputDecoration(
        hintText: hintext,
        label: Text(mLabel),
        enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(bRadius),
            borderSide:BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(bRadius)),
        border: OutlineInputBorder(borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(bRadius)),
        suffixIcon: Icon(micon)
    );
  }
}


TextStyle myTextstyle25({Color mColor=Colors.black,FontWeight mFontWeight=FontWeight.normal})
{
  return TextStyle(color: mColor,fontSize: 25,fontWeight: mFontWeight);
}

TextStyle myTextstyle20({Color mColor=Colors.black,FontWeight mFontWeight=FontWeight.normal})
{
  return TextStyle(color: mColor,fontSize: 20,fontWeight: mFontWeight);
}

TextStyle myTextstyle15({Color mColor=Colors.black,FontWeight mFontWeight=FontWeight.normal})
{
  return TextStyle(color: mColor,fontSize: 15,fontWeight: mFontWeight);
}

TextStyle myTextstyle12({Color mColor=Colors.black,FontWeight mFontWeight=FontWeight.normal})
{
  return TextStyle(color: mColor,fontSize: 12,fontWeight: mFontWeight);
}

TextStyle myTextstyle10({Color mColor=Colors.black,FontWeight mFontWeight=FontWeight.normal})
{
  return TextStyle(color: mColor,fontSize: 10,fontWeight: mFontWeight);
}