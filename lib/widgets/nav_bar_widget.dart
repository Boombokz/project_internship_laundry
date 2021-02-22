import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarWidget extends StatelessWidget {
  final bool active;
  final String label;
  final String iconAsset;

  NavBarWidget({this.active, this.label, this.iconAsset});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(23, 40, 83, 0.04),
          blurRadius: 12,
          spreadRadius: 0,
          offset: Offset(
            16.0,
            0.0,
          ),
        ),
      ]),
      padding: EdgeInsets.only(top: 3, left: 3, right: 3),
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: active ? Color(0xFFF6F8FC) : Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          children: [
            SvgPicture.asset(iconAsset,
                color: active ? Color(0xFF172853) : Color(0xFFB0B3BC)),
            SizedBox(
              height: 3,
            ),
            Text(
              label,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
