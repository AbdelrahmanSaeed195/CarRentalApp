import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  CustomPasswordField(
      {super.key,
      this.onChanged,
      this.controller,
      this.hintText,
      required this.labeltext, this.validator});
  Function(String)? onChanged;
  final TextEditingController? controller;
  String? hintText;
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Widget labeltext;
   final String? Function(String?)? validator;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  var obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: obscureText,
      obscuringCharacter: '*',
      validator: widget.validator,
       decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            setState(
              () {
                obscureText = !obscureText;
              },
            );
          },
          child: obscureText
              ? const Icon(
                  Icons.visibility_off,
                  color: Colors.grey,
                )
              : Icon(Icons.visibility, color: Colors.grey.shade600),
        ),
        label: widget.labeltext,
        hintText: widget.hintText,
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
