part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductloadingState extends ProductState {}

class ProductloadedState extends ProductState {
  final List<ProductModel> products;

  ProductloadedState(this.products);
}

class ProductErrorState extends ProductState {
  final String error;

  ProductErrorState(this.error);
}
