import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/fav/fav_bloc.dart';

import 'package:onlinefooddeliverysystem/models/product_model.dart';

///////////////////////         ADD TO CART Button    ///////////////////////////////
class FavListViewWidget extends StatelessWidget {
  const FavListViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        color: mainColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.cart_fill_badge_plus,
              color: whiteColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text("add to Cart",
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    // fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: whiteColor)),
          ],
        ),
        onPressed: () {
          print("add to cart");
        });
  }
}

///////////////////////         ADD FAV Button    //////////////////////////////////
class AddFavButtonWidget extends StatefulWidget {
  final ProductModel product;
  AddFavButtonWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<AddFavButtonWidget> createState() => _AddFavButtonWidgetState();
}

class _AddFavButtonWidgetState extends State<AddFavButtonWidget> {
  late bool isfav;
  @override
  Widget build(BuildContext context) {
    // isfav = BlocProvider.of<FavBloc>(context)
    //     .checkProductIsFav(widget.product.productId);
    print(isfav.toString() + '----------------------------------------');
    return BlocBuilder<FavBloc, FavState>(
      builder: (context, state) {
        if (state is FavloadedState) {
          return InkWell(
            onTap: () {
              print("Like");
              // BlocProvider.of<FavBloc>(context)
              //     .toggleLocalFav(widget.product.productId);
              setState(() {
                isfav = !isfav;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: mainColor)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isfav
                        ? Icon(
                            CupertinoIcons.heart_fill,
                            color: mainColor,
                          )
                        : Icon(
                            CupertinoIcons.heart,
                            color: mainColor,
                          ),
                  ],
                ),
              ),
            ),
          );
        }
        return CupertinoActivityIndicator();
      },
    );
  }
}

///////////////////////        BackGroung Image    //////////////////////////////////
class ImageBGWidget extends StatelessWidget {
  const ImageBGWidget({
    Key? key,
    required this.product,
    required this.imageHeight,
    required this.imagewidth,
  }) : super(key: key);

  final double imageHeight;
  final double imagewidth;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: imageHeight,
          width: imagewidth,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )),
          child: CachedNetworkImage(
            imageUrl: product.imageUrl,
            fit: BoxFit.cover,
            //width: mediaQuery.size.width,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - imagewidth,
          height: MediaQuery.of(context).size.height - imageHeight,
          color: backgroundColor,
        ),
      ],
    );
  }
}

///////////////////////        FUncation to Calculte Sale Rate     //////////////////////////////////
offRate({required double preNumber, required double currentNumber}) {
  return (((preNumber - currentNumber) / preNumber) * 100).ceil().toString();
}
