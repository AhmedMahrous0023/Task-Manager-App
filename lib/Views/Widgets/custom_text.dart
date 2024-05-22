import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final int maxLines;

  const CustomText(
      {super.key,
      required this.text,
       this.color= Colors.black,
       this.fontWeight=FontWeight.normal,
       this.fontSize=15,  this.maxLines=1});

  @override
  Widget build(BuildContext context) {
     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : color; 
    return Text(
      text,
      style:
          TextStyle(color: textColor, fontSize: fontSize, fontWeight: fontWeight,),maxLines:maxLines ,
    );
  }
}
