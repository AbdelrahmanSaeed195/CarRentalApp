import 'package:flutter/material.dart';

class Customformfeild extends StatelessWidget {
  Customformfeild(
      {super.key,
      this.icon,
      this.onChanged,
      this.hintText,
      required this.labeltext,
      this.controller,
      this.keyboardtype,
      this.maxLength,
      this.validator});
  Function(String)? onChanged;
  String? hintText;
  final IconData? icon;
  Widget labeltext;
  final TextEditingController? controller;
  final keyboardtype;
  final maxLength;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      keyboardType: keyboardtype,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'field is required';
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        suffixIcon: Icon(
          icon,
        ),
        label: labeltext,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black26,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
