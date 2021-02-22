import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:project_internship_laundry/data/data_source/categories_list_data_source.dart';
import 'package:project_internship_laundry/data/model/product_category_model.dart';

part 'categorieslist_event.dart';
part 'categorieslist_state.dart';

class CategoriesListBloc
    extends Bloc<CategoriesListEvent, CategoriesListState> {
  CategoriesListDataSource categoriesListDataSource =
      CategoriesListDataSource();

  CategoriesListBloc() : super(CategoriesListLoadingState());

  @override
  Stream<CategoriesListState> mapEventToState(
    CategoriesListEvent event,
  ) async* {
    if (event is CategoriesListLoadEvent) {
      yield CategoriesListLoadingState();
      try {
        List<ProductCategory> loadedCategories =
            await categoriesListDataSource.getCategories();

        yield CategoriesListLoadedState(loadedCategories);
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        yield CategoriesListErrorState();
      }
    }
  }
}
