import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'userfav_state.dart';

class UserfavCubit extends Cubit<UserfavState> {
  UserfavCubit() : super(UserfavInitial());

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<ProductModel> favProducts = [];
  List<String> userFavIDs = [];

  toggleLocalFav(String productId) async {
    emit(FavloadingState());
    final SharedPreferences prefs = await _prefs;
    if (!checkProductIsFav(productId)) {
      userFavIDs.add(productId);
      prefs.setStringList('userFav', userFavIDs);
      getLocalFavIDs();
      print('-------------------Add---------------------------');
      print(userFavIDs);
      emit(FavloadedState());
    } else {
      userFavIDs.remove(productId);
      print('-------------------Removed---------------------------');
      prefs.setStringList('userFav', userFavIDs);
      getLocalFavIDs();
      emit(FavloadedState());
    }
  }

  getLocalFavIDs() async {
    emit(FavloadingState());
    final SharedPreferences prefs = await _prefs;
    List<String>? newUserFavID = prefs.getStringList('userFav');
    if (newUserFavID!.isNotEmpty || newUserFavID.length != 0) {
      print('------------Fav List ID--------------' + userFavIDs.toString());
      userFavIDs = newUserFavID;
      emit(FavloadedState());
    } else {
      userFavIDs = [];
      emit(FavloadedState());
    }
  }

  bool checkProductIsFav(String productID) {
    emit(FavloadingState());
    if (userFavIDs.isNotEmpty) {
      for (String id in userFavIDs) {
        if (id == productID) {
          emit(FavloadedState());
          return true;
        }
      }
    }
    emit(FavloadedState());
    return false;
  }

  getLocalFavProducts(BuildContext context) async {
    emit(FavloadingState());
    // await getLocalFavIDs();
    List<ProductModel> products =
        BlocProvider.of<ProductCubit>(context).products;
    favProducts.clear();
    products.forEach((product) {
      if (userFavIDs.contains(product.productId)) {
        favProducts.add(product);
      }
    });
    emit(FavloadedState());
  }
}
