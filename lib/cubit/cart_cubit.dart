import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:project_internship_laundry/cubit/cart_state.dart';
import 'package:project_internship_laundry/data/model/product_model.dart';

class CartCubit extends Cubit<CartState> {
  Box box = Hive.box('cart');

  CartCubit() : super(CartEmptyState());

  void addProducts(var key, var value) {
    try {
      box.put(key, value);

      List<Product> addedProducts = box.values.cast<Product>().toList();

      int totalSum = addedProducts
          .map((e) => e.count * e.price)
          .reduce((value, element) => value + element)
          .toInt();

      int totalCount = addedProducts
          .map((e) => e.count)
          .reduce((value, element) => value + element)
          .toInt();
      emit(CartLoadedState(addedProducts, totalSum, totalCount));
    } catch (e, s) {
      debugPrintStack(label: e.toString(), stackTrace: s);
      emit(CartErrorState());
    }
  }

  void clearProducts() {
    box.clear();
    emit(CartEmptyState());
  }
}
