import 'package:project_internship_laundry/data/model/product_model.dart';

abstract class CartState {}

class CartEmptyState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  List<Product> addedProducts;
  int totalSum;
  int totalCount;
  CartLoadedState(this.addedProducts, this.totalSum, this.totalCount);
}

class CartErrorState extends CartState {}
