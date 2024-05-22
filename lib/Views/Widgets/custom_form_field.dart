import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final Color fillColor, hintcolor;
  final String hintText;
  final TextEditingController controller ;
  const CustomFormField(
      {super.key,
      required this.fillColor,
      required this.hintText,
      required this.hintcolor, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .06,
      width: MediaQuery.of(context).size.width * .83,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            fillColor: fillColor,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintcolor,
            )),
      ),
    );
  }
}
