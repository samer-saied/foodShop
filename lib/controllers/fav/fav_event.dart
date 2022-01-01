part of 'fav_bloc.dart';

abstract class FavEvent extends Equatable {
  const FavEvent();
  @override
  List<Object?> get props => [];
}

class FavInitEvent extends FavEvent {
  @override
  List<Object?> get props => [];
}

class LoadFavProductEvent extends FavEvent {
  final List<ProductModel> favProducts;

  LoadFavProductEvent(this.favProducts);
  @override
  List<Object?> get props => [];
}

class ToggleFavProductEvent extends FavEvent {
  final String productID;

  ToggleFavProductEvent(this.productID);
  @override
  List<Object?> get props => [];
}

class CheckFavProductEvent extends FavEvent {
  final String productID;
  CheckFavProductEvent(this.productID);
  @override
  List<Object?> get props => [];
}
