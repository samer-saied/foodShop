import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/models/cart_item_model.dart';

class SingleCartCardWidget extends StatelessWidget {
  final CartItemModel cartItem;
  final String currencyCode;

  const SingleCartCardWidget({
    Key? key,
    required this.cartItem,
    required this.currencyCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             DetailsProductScreen(product: cartItem.)));
        },
        //////// Card Size & shap //////////////////
        child: Container(
          height: 120,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //////// ListTile Image //////////////////
              Container(
                child: CachedNetworkImage(
                  height: 120,
                  width: MediaQuery.of(context).size.width * .25,
                  imageUrl: cartItem.productUrl,
                  fit: BoxFit.cover,
                ),
              ),
              //////// ListTile sperated //////////////////
              const SizedBox(
                width: 10,
              ),
              //////// ListTile title and Details //////////////////
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ////////// Title  //////////////////
                    Text('${cartItem.productTitle.toUpperCase()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1),
                    Text('Size : ${cartItem.productSize.toUpperCase()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1),
                    /////////   Price && add to cart ////////////////
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Text(
                                  currencyCode,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  cartItem.productPrice.toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ///////////   add & minus Cart Button ///////////////
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              CartButtonWidget(
                                icon: CupertinoIcons.add,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  cartItem.quantity.toString(),
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                              CartButtonWidget(
                                icon: CupertinoIcons.minus,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total : ',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            cartItem.total.toString() + ' $currencyCode',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartButtonWidget extends StatelessWidget {
  final IconData icon;

  const CartButtonWidget({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("add to cart");
      },
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 7,
            ),
            child: Icon(
              icon,
              color: whiteColor,
              size: 16,
            )),
      ),
    );
  }
}
