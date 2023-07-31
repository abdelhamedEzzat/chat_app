import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormFieldForLogInAndRegister extends StatelessWidget {
  CustomTextFormFieldForLogInAndRegister(
      {super.key,
      this.onChanged,
      required this.hintText,
      this.messageController,
      this.suffixIcon,
      this.suffixIconColor,
      required this.validator});
  Function(String)? onChanged;
  final String? Function(String?)? validator;

  final String? hintText;
  TextEditingController? messageController = TextEditingController();
  Widget? suffixIcon;
  Color? suffixIconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TextFormField(
          validator: validator,
          controller: messageController,
          onChanged: onChanged,
          //
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              suffixIconColor: suffixIconColor,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              //
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white)),
              //
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
      ),
    );
  }
}
