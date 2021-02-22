import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_internship_laundry/utils/const.dart';

class RepairCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.only(start: 12),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: SvgPicture.asset(
              kBackButtonIcon,
              color: Color(0xFF172853),
              height: 18,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.transparent)),
        middle: Text(
          'Ремонт',
          style: kAppBarStyle,
        ),
      ),
      child: Center(
        child: Text('Repair'),
      ),
    );
  }
}
