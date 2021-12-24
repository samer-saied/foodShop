import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/views/components/standard_products_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: [
      //////////////////////// List of Products ////////////////////////
      BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ProductCardListWidget(
                    currencyCode: 'EGP',
                    products: context.read<ProductCubit>().products,
                    addCartEnabled: true,
                    dissmissEnabled: false,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom + 10,
                )
              ],
            ),
          );
        },
      ),
      //////////////////////// App Bar ////////////////////////
      Positioned(
          top: MediaQuery.of(context).padding.top,
          left: 0,
          child: Container(
            // height: 70,
            //width: MediaQuery.of(context).size.width * .3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.cart_fill,
                    color: whiteColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Cart",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: whiteColor)),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
          )),
    ]));
  }
}
