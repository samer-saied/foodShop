import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:onlinefooddeliverysystem/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitEvent>(getCurrentCart);
  }

  late CartModel cart;

  getCurrentCart(CartEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      await FirebaseFirestore.instance
          .collection('carts')
          .doc('yKts2Ero3yCU7u6BuzLu')
          .get()
          .then((DocumentSnapshot docSnapshot) {
        cart = CartModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      });
      emit(CartLoaded());
    } catch (error) {
      emit(CartError(error.toString()));
    }
  }
}
