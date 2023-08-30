part of 'chat_app_cubit.dart';

@immutable
abstract class ChatAppState {}

class ChatAppInitial extends ChatAppState {}

//
//     login page
//

class LoginSucsses extends ChatAppState {}

class LoginLoading extends ChatAppState {}

// ignore: must_be_immutable
class LoginFaild extends ChatAppState {
  String errmassage;
  LoginFaild({required this.errmassage});
}

//
//     register page
//

class RegisterSuccess extends ChatAppState {}

class RegisterLoading extends ChatAppState {}

// ignore: must_be_immutable
class RegisterFaild extends ChatAppState {
  String errormassage;
  RegisterFaild({
    required this.errormassage,
  });
}

//
//     chat  page
//

class ChatSuccess extends ChatAppState {
  List<Message> stateMassges;

  ChatSuccess({
    required this.stateMassges,
  });
}
