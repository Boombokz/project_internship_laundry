part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {}

class LoginCheckingState extends LoginState {}

class LoginErrorState extends LoginState {}
