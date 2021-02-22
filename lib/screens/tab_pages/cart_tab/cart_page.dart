import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:project_internship_laundry/cubit/cart_cubit.dart';
import 'package:project_internship_laundry/cubit/cart_state.dart';
import 'package:project_internship_laundry/utils/const.dart';
import 'package:project_internship_laundry/widgets/product_card.dart';
import 'package:basic_utils/basic_utils.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Box box = Hive.box('cart');
  int totalProductsCount;

  String checkTotalCount(int totalCount) {
    if (totalCount == 1 ||
        totalCount == 21 ||
        totalCount == 31 ||
        totalCount == 41 ||
        totalCount == 51 ||
        totalCount == 61) {
      return 'вещь';
    } else if (totalCount > 1 && totalCount < 5 ||
        totalCount > 21 && totalCount < 25 ||
        totalCount > 31 && totalCount < 35 ||
        totalCount > 41 && totalCount < 45 ||
        totalCount > 51 && totalCount < 55) {
      return 'вещи';
    } else {
      return 'вещей';
    }
  }

  String formatNumber(int number) {
    var s = StringUtils.reverse(number.toString());
    s = StringUtils.addCharAtPosition(s, " ", 3, repeat: true);
    return StringUtils.reverse(s);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: kBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: false,
        padding: EdgeInsetsDirectional.only(end: 16),
        backgroundColor: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.transparent)),
        middle: Text(
          'Корзина',
          style: kAppBarStyle,
        ),
        trailing: GestureDetector(
            onTap: () {
              setState(() {});
              BlocProvider.of<CartCubit>(context).clearProducts();
            },
            child: box.values.isNotEmpty
                ? Text(
                    'Очистить',
                    style: TextStyle(
                      color: Color(0xFFFF5050),
                      fontSize: 17,
                      height: 1.29,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : Offstage()),
      ),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartEmptyState) {
                return Center(child: Text('Корзина пуста...'));
              } else if (state is CartLoadedState) {
                return box.values.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.only(top: 24, bottom: 10),
                              itemCount: box.values.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 8);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return ProductCard(
                                    box.values.elementAt(index), true);
                              },
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(top: 24, bottom: 24),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Общая сумма ${formatNumber(state.totalSum)} тг'),
                                      Text(
                                          '${state.totalCount} ${checkTotalCount(state.totalCount)}'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  height: 43,
                                  width: MediaQuery.of(context).size.width - 32,
                                  child: CupertinoButton(
                                    color: Color(0xFF4376FB),
                                    padding:
                                        EdgeInsets.only(left: 18, right: 17),
                                    child: Text(
                                      'Оформить',
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.37,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(child: Text('Корзина пуста...'));
              } else {
                return Offstage();
              }
            },
          ),
        ),
      ),
    );
  }
}
