import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_internship_laundry/screens/auth_page.dart';
import 'package:project_internship_laundry/screens/laundry_page.dart';
import 'package:project_internship_laundry/screens/tab_pages/laundry_tab/categories_list_page.dart';
import 'package:project_internship_laundry/screens/tab_pages/laundry_tab/laundress_category.dart';
import 'package:project_internship_laundry/screens/tab_pages/laundry_tab/products_list_page.dart';
import 'package:project_internship_laundry/screens/tab_pages/laundry_tab/repair_category.dart';

class RouteGenerator {
  static const String authPage = '/';
  static const String laundryPage = 'LaundryPage';
  static const String categoriesListPage = 'CategoriesListPage';
  static const String productsListPage = 'ProductsListPage';
  static const String laundressCategoryPage = 'LaundressCategoryPage';
  static const String repairCategoryPage = 'RepairCategoryPage';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authPage:
        return CupertinoPageRoute(builder: (_) => AuthPage());
      case laundryPage:
        return CupertinoPageRoute(builder: (_) => LaundryPage());
      case categoriesListPage:
        return CupertinoPageRoute(builder: (_) => CategoriesListPage());
      case productsListPage:
        return CupertinoPageRoute(builder: (_) => ProductsListPage());
      case laundressCategoryPage:
        return CupertinoPageRoute(builder: (_) => LaundressCategoryPage());
      case repairCategoryPage:
        return CupertinoPageRoute(builder: (_) => RepairCategoryPage());
      default:
        return CupertinoPageRoute(
          builder: (_) => CupertinoApp(
            home: Center(
              child: Text('Страница не существует'),
            ),
          ),
        );
    }
  }
}
