import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tifuti_project/config/theme.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Alignment alignment;
  final int? maxLines;
  final double? height;

  const CustomText({
    Key? key,
    this.text = '',
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.alignment = Alignment.topLeft,
    this.maxLines,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          color: color,
          height: height,
        ),
        maxLines: maxLines,
      ),
    );
  }
}

class CustomTextProducts extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Alignment alignment;
  final int? maxLines;
  final double? height;

  const CustomTextProducts({
    Key? key,
    this.text = '',
    this.fontSize = 15,
    this.fontWeight = FontWeight.bold,
    this.color = primaryColor,
    this.alignment = Alignment.topLeft,
    this.maxLines,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          color: color,
          height: height,
        ),
        maxLines: maxLines,
      ),
    );
  }
}
