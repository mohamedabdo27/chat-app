import 'package:chat_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class FormItem extends StatelessWidget {
  const FormItem({
    super.key,
    required this.nameController,
    required this.hintText,
    required this.name,
    this.keyboardType,
  });

  final TextEditingController nameController;
  final String hintText;
  final String name;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        CustomTextField(
          keyboardType: keyboardType,
          controller: nameController,
          hintText: hintText,
        ),
      ],
    );
  }
}
