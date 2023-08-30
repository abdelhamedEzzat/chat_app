import 'dart:ffi';
import 'dart:math';

import 'package:chat_app_project/constants.dart';
import 'package:chat_app_project/helper/show_snack_bar.dart';
import 'package:chat_app_project/pages/cubit/cubit/cubit/chat_app_cubit.dart';
import 'package:chat_app_project/pages/resgister_page.dart';
import 'package:chat_app_project/widgets/custom_button.dart';
import 'package:chat_app_project/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static String id = 'login page';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  // String? email, password;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSucsses) {
          Navigator.of(context).pushNamed(ChatPage.id);

          print("===================================================");

          print(
            BlocProvider.of<ChatAppCubit>(context).emailCubit,
          );
          print("===================================================");
          //
          //
        } else if (state is LoginFaild) {
          isLoading = false;
          showSnackBar(context, state.errmassage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 75,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Scholar Chat',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'pacifico',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Row(
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormTextField(
                      onChanged: (data) {
                        BlocProvider.of<ChatAppCubit>(context).emailCubit =
                            data;
                      },
                      hintText: 'Email',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomFormTextField(
                      obscureText: true,
                      onChanged: (data) {
                        BlocProvider.of<ChatAppCubit>(context).PasswordCubit =
                            data;
                      },
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButon(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {});
                          try {
                            await BlocProvider.of<ChatAppCubit>(context)
                                .signInWithEmailAndPassword(
                                    email:
                                        BlocProvider.of<ChatAppCubit>(context)
                                            .emailCubit,
                                    password:
                                        BlocProvider.of<ChatAppCubit>(context)
                                            .PasswordCubit);
                            BlocProvider.of<ChatAppCubit>(context).getMassage();
                            Navigator.pushNamed(
                              context,
                              ChatPage.id,
                            );
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'user-not-found') {
                              showSnackBar(context, 'user not found');
                            } else if (ex.code == 'wrong-password') {
                              showSnackBar(context, 'wrong password');
                            }
                          } catch (ex) {
                            print(ex);
                            showSnackBar(context, 'there was an error');
                          }

                          isLoading = false;
                          setState(() {});
                        } else {}
                      },
                      text: 'LOGIN',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'dont\'t have an account?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text(
                            '  Register',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
