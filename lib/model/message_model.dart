// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:chat_app_project/Screens/constant.dart';

class Messages {
  final String Message;
  final String id;
  Messages(
    this.Message,
    this.id,
  );
  factory Messages.fromJson(Jsondata) {
    return Messages(Jsondata[KMassage], Jsondata[KIdEmail]);
  }
}
