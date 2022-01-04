import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/cart/cart_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/models/cart_item_model.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/details/details_product_main_screen.dart';

//////////////////////////    New  Products  Widget  /////////////////////////////////
class NewProductsWidget extends StatelessWidget {
  final ProductModel product;
  const NewProductsWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryize = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      ////////////////////////  transparent Container ////////////////////////////
      child: Container(
          clipBehavior: Clip.antiAlias,
          width: (mediaQueryize.size.width * .35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.transparent,
          ),
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailsProductScreen(product: product))),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                /////////////////////////////   BackGround   ////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: backgroundColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /////////// Product Image ////////////
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: product.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /////////// Product Name ////////////
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, right: 5, left: 5, bottom: 5),
                              child: Text(
                                product.title.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            AddCartSecandWidget(
                              product: product,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                ////////////////////////////   Red Bannner -  Image  ////////////////////////////
                Positioned(
                    top: 0,
                    right: 7,
                    left: 7,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 5,
                        left: 5,
                        top: 0,
                      ),
                      child: Image(
                        fit: BoxFit.fitHeight,
                        image: AssetImage("assets/images/banner.png"),
                      ),
                    )),
                ////////////////////////////   Red Bannner -  "NEW" Word ////////////////////////////
                Positioned(
                    top: 0,
                    right: 5,
                    left: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, left: 5, top: 0),
                      child: Center(
                          child: Text("New",
                              style: mediaQueryize.orientation ==
                                      Orientation.portrait
                                  ? Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: whiteColor)
                                  : Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        color: whiteColor,
                                        fontSize: 25,
                                      ))),
                    )),
              ],
            ),
          )),
    );
  }
}

//////////////////////////    Add to Cart Secand Button    2  /////////////////////////////////
// ignore: must_be_immutable
class AddCartSecandWidget extends StatefulWidget {
  final ProductModel product;
  bool clicked = false;

  AddCartSecandWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<AddCartSecandWidget> createState() => _AddCartSecandWidgetState();
}

class _AddCartSecandWidgetState extends State<AddCartSecandWidget> {
  @override
  Widget build(BuildContext context) {
    widget.clicked = BlocProvider.of<CartBloc>(context)
        .checkProductOnLocal(productId: widget.product.productId);
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
            color: mainColor.withOpacity(.50), style: BorderStyle.solid),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
      ),
      child: InkWell(
        onTap: () {
          print("add to cart 2");

          BlocProvider.of<CartBloc>(context).add(CartADDEvent(CartItemModel(
              productId: widget.product.productId,
              productPrice: widget.product.currentPrice.values.elementAt(
                  BlocProvider.of<ProductCubit>(context).selectedSize),
              productSize: widget.product.currentPrice.keys.elementAt(
                  BlocProvider.of<ProductCubit>(context).selectedSize),
              productTitle: widget.product.title,
              productUrl: widget.product.imageUrl,
              quantity: '1')));

          setState(() {
            widget.clicked = !widget.clicked;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart,
                color: mainColor,
                size: 14,
              ),
              const SizedBox(
                width: 5,
              ),
              widget.clicked
                  ? Text("added",
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: mainColor))
                  : Text("add to cart",
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: mainColor)),
            ],
          ),
        ),
      ),
    );
  }
}
