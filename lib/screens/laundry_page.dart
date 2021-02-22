import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_internship_laundry/blocs/categories_list_bloc/categorieslist_bloc.dart';
import 'package:project_internship_laundry/blocs/product_bloc/product_bloc.dart';
import 'package:project_internship_laundry/cubit/cart_cubit.dart';
import 'package:project_internship_laundry/screens/tab_pages/cart_tab/cart_page.dart';
import 'package:project_internship_laundry/screens/tab_pages/laundry_tab/categories_list_page.dart';
import 'package:project_internship_laundry/screens/tab_pages/profile_tab/profile_page.dart';
import 'package:project_internship_laundry/utils/const.dart';
import 'package:project_internship_laundry/utils/route_generator.dart';
import 'package:project_internship_laundry/widgets/nav_bar_widget.dart';

class LaundryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesListBloc>(
          create: (context) =>
              CategoriesListBloc()..add(CategoriesListLoadEvent()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc()..add(ProductLoadEvent()),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
      ],
      child: CupertinoTabScaffold(
        backgroundColor: Colors.white,
        tabBar: CupertinoTabBar(
          backgroundColor: Colors.white,
          border: Border(top: BorderSide.none),
          activeColor: Color(0xFF172853),
          items: [
            BottomNavigationBarItem(
              icon: NavBarWidget(
                active: false,
                label: 'Прачечная',
                iconAsset: kLaundryIcon,
              ),
              activeIcon: NavBarWidget(
                active: true,
                label: 'Прачечная',
                iconAsset: kLaundryIcon,
              ),
            ),
            BottomNavigationBarItem(
              icon: NavBarWidget(
                active: false,
                label: 'Профиль',
                iconAsset: kProfileIcon,
              ),
              activeIcon: NavBarWidget(
                active: true,
                label: 'Профиль',
                iconAsset: kProfileIcon,
              ),
            ),
            BottomNavigationBarItem(
              icon: NavBarWidget(
                active: false,
                label: 'Корзина',
                iconAsset: kCartIcon,
              ),
              activeIcon: NavBarWidget(
                active: true,
                label: 'Корзина',
                iconAsset: kCartIcon,
              ),
            ),
          ],
        ),
        tabBuilder: (context, index) => CupertinoTabView(
            onGenerateRoute: RouteGenerator.generateRoute,
            builder: (context) {
              switch (index) {
                case 0:
                  return SafeArea(
                    child: CategoriesListPage(),
                  );
                  break;
                case 1:
                  return ProfilePage();
                  break;
                case 2:
                  return CartPage();
                  break;
                default:
                  return Container();
                  break;
              }
            }),
      ),
    );
  }
}
