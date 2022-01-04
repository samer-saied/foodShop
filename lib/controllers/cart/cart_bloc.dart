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
    on<CartRemoveEvent>(removeFromCart);
  }

  late CartModel cart;
  late String cartId;
  List<String> addedOnCart = [];

  getOrCreateCart(CartEvent event, Emitter<CartState> emit) async {
    try {
      emit(CartLoading());
      await FirebaseFirestore.instance
          .collection('users')
          .doc('2tAQSfvgNwQqSFiZSYF7XbQCX3r2')
          .collection('carts')
          .where('stateCart', isEqualTo: 'CartSteps.initialization')
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
            'stateCart': 'CartSteps.initialization',
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
        bool isFound = checkProductOnCart(
            productId: event.cartitem.productId,
            productSize: event.cartitem.productSize);

        if (isFound) {
          /////
          ///
          ///
        } else {
          event.cartitem.quantity = '1';
          cart.cartItems.add(event.cartitem);
          cart.cartSteps = CartSteps.initialization;

          addedOnCart.add(event.cartitem.productId);
        }
        CollectionReference ref = FirebaseFirestore.instance
            .collection('users')
            .doc('2tAQSfvgNwQqSFiZSYF7XbQCX3r2')
            .collection('carts');

        await ref.doc(cartId).set(cart.toJson());
        addedOnCart.add(event.cartitem.productId);
        emit(CartLoaded());
      } catch (error) {
        print('error ' + error.toString());
        emit(CartError(error.toString()));
      }
    }
  }

  removeFromCart(CartEvent event, Emitter<CartState> emit) async {
    if (event is CartRemoveEvent) {
      try {
        emit(CartLoading());
        cart.cartItems.remove(event.cartitem);
        addedOnCart.remove(event.cartitem.productId);

        CollectionReference ref = FirebaseFirestore.instance
            .collection('users')
            .doc('2tAQSfvgNwQqSFiZSYF7XbQCX3r2')
            .collection('carts');

        await ref.doc(cartId).set(cart.toJson());

        emit(CartLoaded());
      } catch (error) {
        print('error ' + error.toString());
        emit(CartError(error.toString()));
      }
    }
  }

  bool checkProductOnCart(
      {required String productId, required String productSize}) {
    if (cart.cartItems.isEmpty) {
      print('---------1-----------');

      return false;
    } else if (cart.cartItems.isNotEmpty) {
      for (var i = 0; i < cart.cartItems.length; i++) {
        print(cart.cartItems[i].productSize +
            '-----------------error-------------');
        print(cart.cartItems.length);
        print(cart.cartItems[i].productId);
        if ((cart.cartItems[i].productId == productId) &&
            (cart.cartItems[i].productSize == productSize)) {
          print('---------2-----------');

          return true;
        }
      }
    }
    return false;
  }

  bool checkProductOnLocal({required String productId}) {
    for (var item in addedOnCart) {
      if (item == productId) {
        return true;
      }
    }
    return false;
  }
}
