import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:project_internship_laundry/data/data_source/login_data_source.dart';
import 'package:hive/hive.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  LoginDataSource loginDataSource = LoginDataSource();
  var box = Hive.box('token');

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginStartEvent) {
      yield LoginCheckingState();
      try {
        Response response =
            await loginDataSource.logIn(event.email, event.password);
        if (response != null) {
          box.put('refresh', response.data['refresh']);
          box.put('access', response.data['access']);

          yield LoginSuccessState();
        } else {
          yield LoginFailureState();
        }
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        yield LoginInitialState();
      }
    } else if (event is CheckLoginEvent) {
      yield LoginCheckingState();
      try {
        String token = box.get('access');

        await loginDataSource.check(token);

        yield (LoginSuccessState());
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        LoginFailureState();
      }
    }
  }
}
