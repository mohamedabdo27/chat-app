import 'package:chat_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.color,
      this.isLoading = false,
      this.textColor,
      required this.text,
      this.onTap,
      this.width,
      this.height});
  final Color? color;
  final bool isLoading;
  final Color? textColor;
  final double? width;
  final double? height;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 48,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ?? Constants.kPrimaryColor,
          borderRadius: BorderRadius.circular(8),
          border: const Border.fromBorderSide(
            BorderSide(color: Constants.kPrimaryColor),
          ),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
