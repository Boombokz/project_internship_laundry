import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:project_internship_laundry/data/data_source/products_data_source.dart';
import 'package:project_internship_laundry/data/model/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoadingState());

  ProductsDataSource productsDataSource = ProductsDataSource();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is ProductLoadEvent) {
      yield ProductLoadingState();
      try {
        List<Product> loadedProducts = await productsDataSource.getProducts('');
        yield ProductLoadedState(loadedProducts);
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        yield ProductErrorState();
      }
    } else if (event is ProductSearchEvent) {
      yield ProductSearchingState();
      try {
        List<Product> searchedProducts =
            await productsDataSource.getProducts(event.title);
        yield ProductSearchedState(searchedProducts);
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        yield ProductErrorState();
      }
    }
  }
}
