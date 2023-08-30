import 'package:bloc/bloc.dart';
import 'package:chat_app_project/constants.dart';
import 'package:chat_app_project/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chat_app_state.dart';

class ChatAppCubit extends Cubit<ChatAppState> {
  ChatAppCubit() : super(ChatAppInitial());

//     LOGIN CUBIT
//
//
//
  late String emailCubit;
  late String PasswordCubit;
  List<Message> messageCubitList = [];

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      // ignore: unused_local_variable
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSucsses());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFaild(errmassage: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFaild(errmassage: 'wrong-password'));
      }
    } catch (e) {
      emit(LoginFaild(errmassage: "SomeThing Went Wrong"));
    }
  }

  //     REGISTER CUBIT
//
//

  Future<void> createUserWithEmailAndPassword(
      {required email, required password}) async {
    // ignore : unused_local_variable
    emit(RegisterLoading());
    try {
      // ignore: unused_local_variable
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFaild(errormassage: "The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFaild(
            errormassage: "'The account already exists for that email.'"));
      }
    } catch (e) {
      emit(RegisterFaild(errormassage: "Something Went Wrong Please Try Agin"));
      print(e);
    }
  }

  //     chatPage CUBIT
//
//
  CollectionReference Messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  void SendMassage({
    required String massage,
  }) {
    //  try {
    Messages.add(
        {kMessage: massage, kCreatedAt: DateTime.now(), "id": emailCubit});
  }

  void getMassage() {
    Messages.orderBy(kMessage, descending: true).snapshots().listen((event) {
      messageCubitList.clear();
      for (var doc in event.docs) {
        messageCubitList.add(
          Message.fromJson(doc),
        );
      }
      emit(ChatSuccess(
        stateMassges: messageCubitList,
      ));
    });
  }
}
