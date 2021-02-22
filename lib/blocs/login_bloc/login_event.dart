part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginStartEvent extends LoginEvent {
  final String email;
  final String password;

  LoginStartEvent(this.email, this.password);
}

class CheckLoginEvent extends LoginEvent {}

class LogOutEvent extends LoginEvent {}
