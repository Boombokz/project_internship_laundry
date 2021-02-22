import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_internship_laundry/blocs/categories_list_bloc/categorieslist_bloc.dart';
import 'package:project_internship_laundry/blocs/product_bloc/product_bloc.dart';
import 'package:project_internship_laundry/utils/const.dart';
import 'package:project_internship_laundry/utils/route_generator.dart';
import 'package:project_internship_laundry/widgets/category_card.dart';
import 'package:project_internship_laundry/widgets/product_card.dart';

class CategoriesListPage extends StatefulWidget {
  @override
  _CategoriesListPageState createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage>
    with SingleTickerProviderStateMixin {
  bool productsSearchNotActive = true;
  bool animateContainer = false;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: kBackgroundColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 23),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  heightFactor: 2.3,
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        textController.clear();
                        animateContainer = false;
                        productsSearchNotActive = true;
                        FocusScope.of(context).unfocus();
                        context.read<ProductBloc>().add(ProductLoadEvent());
                      });
                    },
                    child: Text(
                      'Отменить',
                      style: TextStyle(
                        color: Color(0xFF4376FB),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: animateContainer ? 270 : double.maxFinite,
                  child: AnimatedSize(
                    alignment: Alignment.centerLeft,
                    curve: Curves.ease,
                    duration: Duration(milliseconds: 300),
                    vsync: this,
                    child: CupertinoTextField(
                      onTap: () {
                        setState(() {
                          animateContainer = true;
                        });
                      },
                      suffix: !animateContainer
                          ? Offstage()
                          : GestureDetector(
                              onTap: () {
                                textController.clear();
                                animateContainer = false;
                                productsSearchNotActive = true;
                                context
                                    .read<ProductBloc>()
                                    .add(ProductLoadEvent());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.5),
                                child: SvgPicture.asset(
                                  kCrossSearchIcon,
                                  height: 16,
                                  color: Color(0xFFB0B3BC),
                                ),
                              ),
                            ),
                      controller: textController,
                      padding: EdgeInsets.all(10),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SvgPicture.asset(kSearchIcon),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF172853),
                      ),
                      onChanged: (newValue) {
                        context
                            .read<ProductBloc>()
                            .add(ProductSearchEvent(newValue));
                        setState(() {
                          if (newValue == '') {
                            productsSearchNotActive = true;
                            context.read<ProductBloc>().add(ProductLoadEvent());
                          } else {
                            productsSearchNotActive = false;
                          }
                          animateContainer = true;
                        });
                      },
                      placeholder: 'Найти вещь',
                      placeholderStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFB0B3BC),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Container(
                child: productsSearchNotActive
                    ? BlocBuilder<CategoriesListBloc, CategoriesListState>(
                        builder: (context, state) {
                        if (state is CategoriesListLoadingState) {
                          return CupertinoActivityIndicator();
                        } else if (state is CategoriesListLoadedState) {
                          return Expanded(
                            child: ListView.separated(
                              itemCount: state.categoriesList.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 16,
                                );
                              },
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (index == 0) {
                                      Navigator.pushNamed(context,
                                          RouteGenerator.productsListPage);
                                    } else if (index == 1) {
                                      Navigator.pushNamed(context,
                                          RouteGenerator.laundressCategoryPage);
                                    } else if (index == 2) {
                                      Navigator.pushNamed(context,
                                          RouteGenerator.repairCategoryPage);
                                    }
                                  },
                                  child: CategoryCard(
                                    category: state.categoriesList[index],
                                    index: index,
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is CategoriesListErrorState) {
                          return Text('Error');
                        } else {
                          return Offstage();
                        }
                      })
                    : BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                        if (state is ProductSearchingState) {
                          return CupertinoActivityIndicator();
                        } else if (state is ProductSearchedState) {
                          return Expanded(
                            child: ListView.separated(
                              itemCount: state.searchedProducts.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 16,
                                );
                              },
                              itemBuilder: (context, index) {
                                return ProductCard(
                                    state.searchedProducts[index], false);
                              },
                            ),
                          );
                        } else if (state is ProductErrorState) {
                          return Text('Error');
                        } else {
                          return Offstage();
                        }
                      }))
          ],
        ),
      ),
    );
  }
}
