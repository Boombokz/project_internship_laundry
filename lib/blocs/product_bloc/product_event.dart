part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class ProductLoadEvent extends ProductEvent {}

class ProductSearchEvent extends ProductEvent {
  final String title;
  ProductSearchEvent(this.title);
}
