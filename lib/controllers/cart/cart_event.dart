part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitEvent extends CartEvent {
  @override
  List<Object> get props => [];
}

class CartADDEvent extends CartEvent {
  final CartItemModel cartitem;

  CartADDEvent(this.cartitem);
  @override
  List<Object> get props => [];
}

class CartRemoveEvent extends CartEvent {
  final CartItemModel cartitem;

  CartRemoveEvent(this.cartitem);
  @override
  List<Object> get props => [];
}


//CartRemoveEvent