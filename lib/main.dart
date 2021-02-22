import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_internship_laundry/data/model/product_model.dart';
import 'package:project_internship_laundry/utils/route_generator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox('token');
  await Hive.openBox('cart');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'MuseoSansCyrl',
            color: Color(0xFF172853),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      initialRoute: RouteGenerator.authPage,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
