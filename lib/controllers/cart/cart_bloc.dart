import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:onlinefooddeliverysystem/models/cart_item_model.dart';
import 'package:onlinefooddeliverysystem/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitEvent>(getOrCreateCart);
    on<CartADDEvent>(addToCart);
  }

  late CartModel cart;
  late String cartId;

  getOrCreateCart(CartEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      await FirebaseFirestore.instance
          .collection('users')
          .doc('2tAQSfvgNwQqSFiZSYF7XbQCX3r2')
          .collection('carts')
          .where('cartSteps', isEqualTo: 'CartSteps.initialization')
          .get()
          .then((items) async {
        print(items.docs.length.toString() +
            '------I found Number of Carts-----------');
        if (items.docs.length == 0) {
          var cartCollection = FirebaseFirestore.instance
              .collection('users')
              .doc('2tAQSfvgNwQqSFiZSYF7XbQCX3r2')
              .collection('carts');
          cartId = cartCollection.doc().id;
          await cartCollection.doc(cartId).set({
            'cartSteps': 'CartSteps.initialization',
            'cartID': cartId,
            'cartItems': []
          });
          cart = CartModel(cartID: cartId, cartItems: []);
        } else {
          cartId = items.docs.first.id;
          print(cartId + '-------------- Found Cart Id on Database');
          cart = CartModel.fromJson(items.docs.first.data());
        }
      });
      emit(CartLoaded());
    } catch (error) {
      print(error);
      emit(CartError(error.toString()));
    }
  }

  addToCart(CartEvent event, Emitter<CartState> emit) async {
    if (event is CartADDEvent) {
      try {
        emit(CartLoading());
        List<CartItemModel> tempItems = [];
        if (cart.cartItems.isEmpty) {
          tempItems.add(event.cartitem);
        }
        for (var item in cart.cartItems) {
          print(item.productId != event.cartitem.productId);
          if (item.productId != event.cartitem.productId) {
            print('----------1------------');
            tempItems.add(item);
          } else {
            print('----------2------------');
            if (item.productPrice != event.cartitem.productPrice) {
              int newquantity = 1;
              item.quantity = newquantity.toString();
              tempItems.add(item);
            } else {
              print('----------3------------');

              tempItems.add(event.cartitem);
            }
          }
        }
        cart.cartItems = tempItems;
        await FirebaseFirestore.instance
            .collection('users')
            .doc('2tAQSfvgNwQqSFiZSYF7XbQCX3r2')
            .collection('carts')
            .doc(cartId)
            .update(cart.toJson());
        emit(CartLoaded());
      } catch (error) {
        print('error ' + error.toString());
        emit(CartError(error.toString()));
      }
    }
  }
}
