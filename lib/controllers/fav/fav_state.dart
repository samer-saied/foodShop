part of 'fav_bloc.dart';

abstract class FavState extends Equatable {
  const FavState();

  @override
  List<Object> get props => [];
}

class FavInitialState extends FavState {
  @override
  List<Object> get props => [];
}

class FavInitialCompeleteState extends FavState {
  @override
  List<Object> get props => [];
}

class FavloadingState extends FavState {
  @override
  List<Object> get props => [];
}

class FavloadedState extends FavState {
  final List<ProductModel> favProducts;

  FavloadedState(this.favProducts);
  @override
  List<Object> get props => [];
}

class FavErrorState extends FavState {
  final String error;

  FavErrorState(this.error);
  @override
  List<Object> get props => [];
}

class FavcheckCompelteState extends FavState {
  final bool favState;

  FavcheckCompelteState(this.favState);
  @override
  List<Object> get props => [];
}

class FavcheckLoadingState extends FavState {
  @override
  List<Object> get props => [];
}

class FavtoggleCompelteState extends FavState {
  @override
  List<Object> get props => [];
}

class FavtoggleLoadingState extends FavState {
  @override
  List<Object> get props => [];
}

// class FavsetIDSState extends FavState {
//   @override
//   List<Object> get props => [];
// }

// class FavToggleState extends FavState {
//   FavToggleState();
//   @override
//   List<Object> get props => [];
// }
