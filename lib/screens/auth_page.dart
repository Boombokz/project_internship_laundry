import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_internship_laundry/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_internship_laundry/utils/const.dart';
import 'package:project_internship_laundry/utils/route_generator.dart';

class AuthPage extends StatelessWidget {
  final emailController = TextEditingController(text: "admin@inzgiba.me");
  final passwordController = TextEditingController(text: "test123123");

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.of(context)
                ?.pushReplacementNamed(RouteGenerator.laundryPage);
          }
        },
        child: CupertinoPageScaffold(
          backgroundColor: kBackgroundColor,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.transparent)),
            middle: Text(
              'Войти',
              style: kAppBarStyle,
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 24),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 59,
                        child: CupertinoTextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: kAuthTextStyle,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 18),
                          placeholder: 'Логин',
                          textAlignVertical: TextAlignVertical.center,
                          placeholderStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFB0B3BC),
                          ),
                          decoration: BoxDecoration(
                            border: null,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Divider(
                          height: 1,
                          color: Color(0xFFEDF2FF),
                          indent: 16,
                          endIndent: 16,
                        ),
                      ),
                      SizedBox(
                        height: 59,
                        child: CupertinoTextField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          style: kAuthTextStyle,
                          obscureText: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 18),
                          placeholder: 'Пароль',
                          placeholderStyle: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFB0B3BC),
                          ),
                          decoration: BoxDecoration(
                            border: null,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                SizedBox(
                  height: 43,
                  width: MediaQuery.of(context).size.width - 32,
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginInitialState) {
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (emailController.text.isNotEmpty &
                                passwordController.text.isNotEmpty) {
                              context.read<LoginBloc>()
                                ..add(
                                  LoginStartEvent(emailController.text,
                                      passwordController.text),
                                );
                            }
                          },
                          color: Color(0xFF4376FB),
                          child: Padding(
                            padding: EdgeInsets.only(left: 18, right: 17),
                            child: Text(
                              'Войти',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.37,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      } else if (state is LoginCheckingState) {
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (emailController.text.isNotEmpty &
                                passwordController.text.isNotEmpty) {
                              context.read<LoginBloc>()
                                ..add(
                                  LoginStartEvent(emailController.text,
                                      passwordController.text),
                                );
                            }
                          },
                          color: Color(0xFF4376FB),
                          child: Padding(
                            padding: EdgeInsets.only(left: 18, right: 17),
                            child: Theme(
                                data: ThemeData(
                                    cupertinoOverrideTheme: CupertinoThemeData(
                                        brightness: Brightness.dark)),
                                child: CupertinoActivityIndicator()),
                          ),
                        );
                      } else if (state is LoginFailureState) {
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (emailController.text.isNotEmpty &
                                passwordController.text.isNotEmpty) {
                              context.read<LoginBloc>()
                                ..add(
                                  LoginStartEvent(emailController.text,
                                      passwordController.text),
                                );
                            }
                          },
                          color: Color(0xFF4376FB),
                          child: Padding(
                            padding: EdgeInsets.only(left: 18, right: 17),
                            child: Text('Login is failed, please retry'),
                          ),
                        );
                      } else {
                        return Offstage();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
