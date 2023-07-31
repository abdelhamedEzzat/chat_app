import 'package:chat_app_project/Screens/constant.dart';
import 'package:chat_app_project/model/message_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatPubl extends StatelessWidget {
  ChatPubl({
    super.key,
    required this.massge,
  });
  Messages massge;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Text(
          massge.Message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatPublForFreind extends StatelessWidget {
  ChatPublForFreind({
    super.key,
    required this.massge,
  });
  Messages massge;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: chatPublForFriendColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Text(
          massge.Message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
