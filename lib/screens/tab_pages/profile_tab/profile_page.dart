import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_internship_laundry/cubit/cart_cubit.dart';
import 'package:project_internship_laundry/screens/auth_page.dart';
import 'package:project_internship_laundry/utils/const.dart';
import 'package:project_internship_laundry/utils/route_generator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool switchOnOff = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: kBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        padding: EdgeInsetsDirectional.only(start: 12),
        backgroundColor: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.transparent)),
        middle: Text(
          AuthPage().emailController.text,
          style: kAppBarStyle,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              height: 59,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Уведомления',
                    style: TextStyle(fontSize: 16),
                  ),
                  CupertinoSwitch(
                      activeColor: Color(0xFF4376FB),
                      value: switchOnOff,
                      onChanged: (bool newValue) {
                        setState(() {
                          switchOnOff = newValue;
                        });
                      })
                ],
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
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                height: 59,
                color: Colors.white,
                child: Text(
                  'Выйти',
                  style: TextStyle(color: Color(0xFFFF5050), fontSize: 16),
                ),
              ),
              onTap: () {
                BlocProvider.of<CartCubit>(context).clearProducts();

                Navigator.of(context, rootNavigator: true)
                    .pushReplacementNamed(RouteGenerator.authPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
