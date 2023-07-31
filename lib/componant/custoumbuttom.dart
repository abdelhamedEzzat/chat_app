import 'package:chat_app_project/Screens/constant.dart';
import 'package:flutter/material.dart';

class CustomRigistorAndLoginButton extends StatelessWidget {
  const CustomRigistorAndLoginButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final VoidCallback? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height / 18,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
