import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/shared/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavBloc() : super(FavloadingState()) {
    on<FavInitEvent>(getLocalFavIDs);
    on<LoadFavProductEvent>(getLocalFavProducts);
    on<ToggleFavProductEvent>(toggleLocalFav);
  }

  List<ProductModel> favProducts = [];
  List<String> userFavIDs = [];

  getLocalFavIDs(
    FavEvent event,
    Emitter<FavState> emit,
  ) async {
    emit(FavInitialState());
    userFavIDs = await CacheHelper.getCacheData(key: 'userFav') ?? [];
    print(userFavIDs);
    emit(FavInitialCompeleteState());
  }

  toggleLocalFav(
    FavEvent event,
    Emitter<FavState> emit,
  ) async {
    print('-----------------Start------------------------');

    emit(FavtoggleLoadingState());
    if (event is ToggleFavProductEvent) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!checkProductIsFav(event.productID)) {
        print('-----------------ADD------------------------');
        userFavIDs.add(event.productID);
        prefs.setStringList('userFav', userFavIDs);
        emit(FavtoggleCompelteState());
      } else {
        print('-----------------Remove------------------------');
        userFavIDs.remove(event.productID);
        prefs.setStringList('userFav', userFavIDs);
        emit(FavtoggleCompelteState());
      }
    }
  }

  bool checkProductIsFav(String productID) {
    if (userFavIDs.isNotEmpty) {
      for (String id in userFavIDs) {
        if (id == productID) {
          return true;
        }
      }
    }
    return false;
  }

  void getLocalFavProducts(
    FavEvent event,
    Emitter<FavState> emit,
  ) {
    emit(FavloadingState());
    //getLocalFavIDs(event, emit);
    if (event is LoadFavProductEvent) {
      List<ProductModel> products = event.favProducts;
      favProducts.clear();
      products.forEach((product) {
        if (userFavIDs.contains(product.productId)) {
          favProducts.add(product);
        }
      });
      emit(FavloadedState(favProducts));
    }
  }
}
