import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';

class TextFormInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isPass;
  final String hintText;

  final IconData? IconSuffix;
  final IconData? preFixICon;
  final TextInputType textInputType;
  VoidCallback? onTap;
  final int? maxlines;
  final int? maxLenght;

  TextFormInputField(
      {Key? key,
      required this.controller,
      this.isPass = false,
      this.IconSuffix,
      this.preFixICon,
      required this.hintText,
      this.maxlines,
      this.maxLenght,
      this.onTap,
      required this.textInputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 60,
      child: TextField(
        maxLength: maxLenght,
        maxLines: maxlines,
        onTap: onTap,
        decoration: InputDecoration(
          suffixIcon: Icon(
            IconSuffix,
            color: textformColor,
          ),
          fillColor: Color(0xffF6F7F9),
          hintText: hintText,
          hintStyle: GoogleFonts.nunitoSans(fontSize: 16),
          border: InputBorder.none,
          filled: true,
          contentPadding: EdgeInsets.all(8),
        ),
        keyboardType: textInputType,
        inputFormatters: textInputType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly]
            : null, // Apply input formatter only for number input type
        controller: controller,
        obscureText: isPass,
      ),
    );
  }
}
