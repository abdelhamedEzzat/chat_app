import 'package:chat_app_project/constants.dart';
import 'package:chat_app_project/models/message.dart';
import 'package:chat_app_project/pages/cubit/cubit/cubit/chat_app_cubit.dart';
import 'package:chat_app_project/widgets/chat_buble.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final _controller = ScrollController();
  // List<Message> messageList = [];

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
//  var email  = ModalRoute.of(context)!.settings.arguments ;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            Text('chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatAppCubit, ChatAppState>(
              builder: (context, state) {
                var massageList =
                    BlocProvider.of<ChatAppCubit>(context).messageCubitList;
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: massageList.length,
                    itemBuilder: (context, index) {
                      return massageList[index].id ==
                              BlocProvider.of<ChatAppCubit>(context).emailCubit
                          ? ChatBuble(
                              message: massageList[index],
                            )
                          : ChatBubleForFriend(message: massageList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatAppCubit>(context).SendMassage(
                  massage: data,
                );
                // messages.add(
                //   {
                //     kMessage: data,
                //     kCreatedAt: DateTime.now(),
                //     'id':
                //         BlocProvider.of<ChatAppCubit>(context).emailCubit
                //   },
                // );
                controller.clear();
                _controller.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
