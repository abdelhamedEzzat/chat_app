import 'package:chat_app_project/Screens/constant.dart';
import 'package:chat_app_project/componant/chat_publ.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/message_model.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});
  static String id = "ChatScreen";
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

CollectionReference Message =
    FirebaseFirestore.instance.collection(KMessageCollection);
TextEditingController messageController = TextEditingController();
final Controller = ScrollController();

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: Message.orderBy(KCreatedAt, descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Messages> messageList = [];
          for (int i = 0; i > snapshot.data.docs.length; i++) {
            messageList.add(snapshot.data.docs[i]);
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xff314e6a),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                        width: MediaQuery.of(context).size.width / 10,
                        child: Image.asset(
                          "assets/images/scholar.png",
                        )),
                    const Text("Chat")
                  ],
                ),
              ),
              body: Column(children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: Controller,
                    itemCount: messageList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return messageList[index].id == email
                          ? ChatPubl(
                              massge: messageList[index],
                            )
                          : ChatPublForFreind(
                              massge: messageList[index],
                            );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: messageController,
                    onFieldSubmitted: (data) {
                      Message.add({
                        KMassage: data,
                        KCreatedAt: DateTime.now(),
                        KIdEmail: email
                      });

                      messageController.clear();

                      Controller.animateTo(0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                        hintText: "Send Massage",
                        suffixIconColor: Colors.blue,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.blue)),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send),
                        )),
                  ),
                )
              ]),
            ),
          );
        } else {
          const Text("dsadasa");
        }
        return const Text("Loading");
      },
    );
  }
}
