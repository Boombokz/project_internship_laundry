part of 'categorieslist_bloc.dart';

@immutable
abstract class CategoriesListState {}

class CategoriesListLoadingState extends CategoriesListState {}

class CategoriesListLoadedState extends CategoriesListState {
  CategoriesListLoadedState(this.categoriesList);

  final List<ProductCategory> categoriesList;
}

class CategoriesListErrorState extends CategoriesListState {}
