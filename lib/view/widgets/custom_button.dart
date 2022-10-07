import 'package:flutter/material.dart';

import '../../constants.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressedFn;

  const CustomButton(this.text, this.onPressedFn, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          shape: const StadiumBorder(),
        ),
        onPressed: onPressedFn,
        child: CustomText(
          text: text,
          fontSize: 14,
          color: Colors.white,
          alignment: Alignment.center,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class CustomButtonWhite extends StatelessWidget {
  final String text;
  final VoidCallback? onPressedFn;

  const CustomButtonWhite(this.text, this.onPressedFn, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressedFn,
        child: CustomText(
          text: text,
          fontSize: 14,
          color: darkGreenColor,
          alignment: Alignment.center,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
