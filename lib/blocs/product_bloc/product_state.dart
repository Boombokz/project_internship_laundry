part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductSearchingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> loadedProducts;

  ProductLoadedState(this.loadedProducts);
}

class ProductSearchedState extends ProductState {
  final List<Product> searchedProducts;

  ProductSearchedState(this.searchedProducts);
}

class ProductErrorState extends ProductState {}
