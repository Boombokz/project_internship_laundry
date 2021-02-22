import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_internship_laundry/blocs/product_bloc/product_bloc.dart';
import 'package:project_internship_laundry/utils/const.dart';
import 'package:project_internship_laundry/widgets/product_card.dart';

class ProductsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: kBackgroundColor,
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
          'Офисная одежда',
          style: kAppBarStyle,
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return Center(child: CupertinoActivityIndicator());
            } else if (state is ProductLoadedState) {
              return Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: ListView.separated(
                  padding: EdgeInsets.only(top: 24, bottom: 8),
                  itemCount: state.loadedProducts.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 8);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(state.loadedProducts[index], false);
                  },
                ),
              );
            } else if (state is ProductErrorState) {
              return Center(
                child: Text('Error'),
              );
            } else {
              return Offstage();
            }
          },
        ),
      ),
    );
  }
}
