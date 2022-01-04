import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/cart/cart_bloc.dart';
import 'package:onlinefooddeliverysystem/models/cart_item_model.dart';
import 'package:onlinefooddeliverysystem/views/app/components/app_components.dart';

import 'cart_components.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
      //////////////////////// List of Cart Items ////////////////////////
      BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is CartLoading) {
          return Center(child: CupertinoActivityIndicator());
        } else if (state is CartLoaded) {
          if (cartBloc.cart.cartItems.isNotEmpty) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 50,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartBloc.cart.cartItems.length,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (dismissDirection) {
                                cartBloc.add(CartRemoveEvent(
                                    cartBloc.cart.cartItems[index]));
                                //////////
                                ///
                                ///
                                ///
                              },
                              background: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Remove",
                                        textAlign: TextAlign.end,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5!
                                            .copyWith(color: whiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  //  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: SingleCartCardWidget(
                                cartItem: context
                                    .read<CartBloc>()
                                    .cart
                                    .cartItems[index],
                                currencyCode: 'EGP',
                              ),
                            ),
                          );
                        },
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 10,
                  )
                ],
              ),
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.exclamationmark_circle),
                  SizedBox(
                    height: 5,
                  ),
                  Text('No items on your cart'),
                ],
              ),
            );
          }
        }
        return Center(
          child: Text("Loading"),
        );
      }),
      //////////////////////// App Bar ////////////////////////
      TitleSliderWidget(
        titleTxt: 'Cart',
        prefixIcon: Icon(
          CupertinoIcons.cart_fill,
          color: whiteColor,
        ),
        backAvaiable: false,
      ),
    ]));
  }
}
