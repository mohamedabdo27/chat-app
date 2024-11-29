import 'package:chat_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.maxLines,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.fillColor,
    this.hintTextColor,
    this.keyboardType,
  });
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final Color? fillColor;
  final Color? hintTextColor;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "the field must not be empty";
        }
        return null;
      },
      cursorColor: Constants.kPrimaryColor,
      maxLines: maxLines,
      decoration: InputDecoration(
        fillColor: fillColor ?? Colors.white,
        filled: true,
        border: borderBuild(context: context),
        enabledBorder: borderBuild(context: context),
        focusedBorder: borderBuild(
          color: Constants.kPrimaryColor,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintTextColor ?? const Color(0xffD9D9D9),
        ),
      ),
    );
  }

  OutlineInputBorder borderBuild({Color? color, context}) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? const Color(0xffC5C5C5),
        ),
        borderRadius: BorderRadius.circular(8),
      );
}
