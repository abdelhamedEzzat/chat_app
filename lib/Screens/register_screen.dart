import 'package:chat_app_project/Screens/chat_screen.dart';
import 'package:chat_app_project/componant/costum_text_form.dart';
import 'package:chat_app_project/componant/custoumbuttom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String id = "RegisterScreen";
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

late String email;
late String password;
bool isLoading = false;

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> ValidationKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color(0xff27445f),
          body: ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Form(
              key: ValidationKey,
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
                                " REGISTER ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                        ),

                        CustomTextFormFieldForLogInAndRegister(
                          onChanged: (registerData) {
                            email = registerData;
                          },
                          validator: (data) {
                            if (data!.isEmpty) {
                              return " this Field [Email] is Required ";
                            }
                            return null;
                          },
                          hintText: "Email",
                        ),
                        //

                        CustomTextFormFieldForLogInAndRegister(
                          onChanged: (registerData) {
                            password = registerData;
                          },
                          validator: (data) {
                            if (data!.isEmpty) {
                              return " this Field [Password] is Required ";
                            }
                            return null;
                          },
                          hintText: "Password",
                        ),

                        //

                        const SizedBox(
                          height: 20,
                        ),

                        //
                        CustomRigistorAndLoginButton(
                          onPressed: () async {
                            if (ValidationKey.currentState!.validate()) {
                              ValidationKey.currentState!.save();
                              try {
                                await createUserWithEmailAndPassword();
                                Navigator.pushNamed(context, ChatScreen.id);
                                showSnackBar(massage: "Register Success");
                                // ignore: use_build_context_synchronously
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showSnackBar(massage: 'weak-password');
                                } else if (e.code == 'email-already-in-use') {
                                  showSnackBar(massage: 'email-already-in-use');
                                }
                              } catch (e) {
                                showSnackBar(massage: "$e");
                                print(e);
                              }
                            }

                            //
                          },
                          text: "REGISTER",
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "do You Aready have an account ?",
                              style: TextStyle(color: Colors.white),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "LogIn",
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
          )),
    );
  }

  void showSnackBar({required String massage}) {
    scaffoldMessengerKey.currentState
        ?.showSnackBar(SnackBar(content: Text(massage)));
  }

  Future<void> createUserWithEmailAndPassword() async {
    // ignore: unused_local_variable
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
// Future<void> createEmailAndPassword() async {
//   // ignore: unused_local_variable
//   final credential =
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//     email: email,
//     password: password,
//   );
// }

// if (formKey.currentState!.validate()) {
//                               isLoading = true;
//                               setState(() {});
//                               try {
//                                 await createEmailAndPassword();
//                                 Navigator.pushNamed(context, "ChatScreen",
//                                     arguments: email);
//                               } on FirebaseAuthException catch (ex) {
//                                 if (ex.code == 'weak-password') {
//                                   showSnackBar(context,
//                                       'The password provided is too weak.');
//                                 } else if (ex.code == 'email-already-in-use') {
//                                   showSnackBar(context,
//                                       'The account already exists for that email.');
//                                 }
//                               } catch (ex) {
//                                 print(ex);
//                                 showSnackBar(context, 'there was an error');
//                               }

//                               isLoading = false;
//                               setState(() {});
//                             } else {}

// try {
//                             final credential = await FirebaseAuth.instance
//                                 .createUserWithEmailAndPassword(
//                               email: email,
//                               password: password,
//                             );
//                           } on FirebaseAuthException catch (e) {
//                             if (e.code == 'weak-password') {
//                               scaffoldMessengerKey.currentState?.showSnackBar(
//                                   SnackBar(content: Text("weak-password")));
//                             } else if (e.code == 'email-already-in-use') {
//                               scaffoldMessengerKey.currentState?.showSnackBar(
//                                   SnackBar(
//                                       content: Text("email-already-in-use")));
//                             }
//                           } catch (e) {
//                             print(e);
//                           }
