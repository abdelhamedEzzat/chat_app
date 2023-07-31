import 'package:chat_app_project/Screens/register_screen.dart';
import 'package:chat_app_project/componant/costum_text_form.dart';
import 'package:chat_app_project/componant/custoumbuttom.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = "LoginScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

GlobalKey<ScaffoldMessengerState> scaffoledKey =
    GlobalKey<ScaffoldMessengerState>();

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: scaffoledKey,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xff27445f),
          body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Form(
              child: SafeArea(
                  child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/scholar.png',
                          alignment: Alignment.topCenter,
                        ),

                        Container(
                          alignment: Alignment.topCenter,
                          child: const Text(
                            "Scholar Chat ",
                            style: TextStyle(
                                fontFamily: "Pacifico",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 25),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                " LOGIN ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                        ),

                        CustomTextFormFieldForLogInAndRegister(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return " this Field [Email] is Required ";
                            }
                            return null;
                          },
                          onChanged: (loginData) {
                            email = loginData;
                          },
                          hintText: "Email",
                        ),
                        //

                        CustomTextFormFieldForLogInAndRegister(
                          validator: (data) {
                            if (data!.isEmpty) {
                              return " this Field [Password] is Required ";
                            }
                            return null;
                          },
                          onChanged: (loginData) {
                            password = loginData;
                          },
                          hintText: "Password",
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        CustomRigistorAndLoginButton(
                          onPressed: () async {
                            try {
                              await signInWithEmailAndPassword();
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                showSnackBar(massage: "user-not-found");
                              } else if (e.code == 'wrong-password') {
                                showSnackBar(massage: "wrong-password");
                              }
                            } catch (e) {
                              showSnackBar(massage: "$e");
                            }
                            showSnackBar(massage: "Success Login");
                          },
                          text: "LOGIN",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "doesnt have an account ?",
                              style: TextStyle(color: Colors.white),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RegisterScreen.id,
                                );
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            ),
          ),
        ));
  }

  void showSnackBar({required String massage}) {
    scaffoledKey.currentState?.showSnackBar(SnackBar(content: Text(massage)));
  }

  Future<void> signInWithEmailAndPassword() async {
    final credential = await FirebaseAuth.instance;
    credential.signInWithEmailAndPassword(email: email, password: password);
  }
}
  // Future<void> loginUser() async {
  //   // ignore: unused_local_variable
  //   UserCredential user = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email, password: password);
  // }

//  if (formKey.currentState!.validate()) {
//                               isLoading = true;
//                               setState(() {});
//                               try {
//                                 await loginUser();
//                                 Navigator.pushNamed(context, "ChatScreen",
//                                     arguments: email);
//                               } on FirebaseAuthException catch (ex) {
//                                 if (ex.code == 'user-not-found') {
//                                   showSnackBar(context, 'user not found');
//                                 } else if (ex.code == 'wrong-password') {
//                                   showSnackBar(context, 'wrong password');
//                                 }
//                               } catch (ex) {
//                                 print(ex);
//                                 showSnackBar(context, 'there was an error');
//                               }

//                               isLoading = false;
//                               setState(() {});
//                             } else {}