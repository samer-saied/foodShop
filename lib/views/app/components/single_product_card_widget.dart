import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/cart/cart_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/fav/fav_bloc.dart';
import 'package:onlinefooddeliverysystem/models/cart_item_model.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/details/details_product_main_screen.dart';

///////////////////////////////// Single Product Card Widget ///////////////////////////////////////

class SingleProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final String currencyCode;
  final bool favEnabled;

  const SingleProductCardWidget({
    Key? key,
    required this.product,
    required this.currencyCode,
    required this.favEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailsProductScreen(product: product)));
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
                  imageUrl: product.imageUrl,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ////////// Title && Like Button //////////////////
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(product.title.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.subtitle1),
                            favEnabled
                                ? Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: HeartFavButtonWidget(
                                      productID: product.productId,
                                    ))
                                : SizedBox(),
                          ]),
                    ),
                    ////////// subTitle  //////////////////
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 2, right: 20, top: 5),
                        child: Text(product.description.toString(),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: greyColor)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    /////////   Price && add to cart ////////////////
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  (product.prePrice.values.isNotEmpty)
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            "$currencyCode " +
                                                product.prePrice.values.first +
                                                " ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: mainColor,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                          ),
                                        )
                                      : Container(),
                                  Text(
                                    currencyCode,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    product.currentPrice.values.first
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //const Spacer(),
                          ///////////   ADD to Cart Button ///////////////
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: AddCartWidget(
                              product: product,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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

///
///
///
//////////////                     Components                  /////////////////
///
///
///

//////////////////////////    Heart (Fav Button) Widget  /////////////////////////////////
// ignore: must_be_immutable
class HeartFavButtonWidget extends StatefulWidget {
  HeartFavButtonWidget({
    Key? key,
    required this.productID,
    this.heartSize = 26,
  }) : super(key: key);

  final String productID;
  double heartSize;
  @override
  State<HeartFavButtonWidget> createState() => _HeartFavButtonWidgetState();
}

class _HeartFavButtonWidgetState extends State<HeartFavButtonWidget> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    FavBloc favBloc = BlocProvider.of<FavBloc>(context);
    isFav = favBloc.checkProductIsFav(widget.productID);
    // favBloc.add(CheckFavProductEvent(widget.productID));
    return InkWell(onTap: () {
      print("I clicked it");
      ////
      ///
      ///
      ///
      // favBloc.add(ToggleFavProductEvent(widget.productID));
      setState(() {
        // isFav = !isFav;
      });
      favBloc.add(ToggleFavProductEvent(widget.productID));
    }, child: BlocBuilder<FavBloc, FavState>(
      builder: (context, state) {
        if (state is FavtoggleCompelteState ||
            state is FavcheckCompelteState ||
            state is FavloadedState ||
            state is FavInitialCompeleteState) {
          return Icon(
            //   state.favState
            isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            color: mainColor,
            size: widget.heartSize,
          );
        }
        return CircularProgressIndicator();
      },
    ));
  }
}

//////////////////////////    Add to Cart Button   1   /////////////////////////////////
class AddCartWidget extends StatelessWidget {
  final ProductModel product;
  const AddCartWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("add to cart");
        BlocProvider.of<CartBloc>(context).add(CartADDEvent(CartItemModel(
            productId: product.productId,
            productTitle: product.title,
            productPrice: product.currentPrice.values.first,
            productUrl: product.imageUrl,
            productSize: product.currentPrice.keys.first,
            quantity: '1')));
      },
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.cart_badge_plus,
                color: whiteColor,
                size: 14,
              ),
              const SizedBox(
                width: 5,
              ),
              Text("add",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: whiteColor)),
            ],
          ),
        ),
      ),
    );
  }
}
