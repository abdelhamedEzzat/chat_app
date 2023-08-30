import 'package:chat_app_project/pages/chat_page.dart';
import 'package:chat_app_project/pages/cubit/cubit/cubit/chat_app_cubit.dart';
import 'package:chat_app_project/pages/login_page.dart';
import 'package:chat_app_project/pages/resgister_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ChatAppCubit(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            LoginPage.id: (context) => LoginPage(),
            RegisterPage.id: (context) => RegisterPage(),
            ChatPage.id: (context) => ChatPage()
          },
          initialRoute: LoginPage.id,
        ));
  }
}
