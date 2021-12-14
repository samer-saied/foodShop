import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/home/components/products_standard_widget.dart';

class NewProductsWidget extends StatelessWidget {
  final ProductModel product;
  const NewProductsWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryize = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        top: 10,
        bottom: 10,
      ),
      ////////////  transparent Container ///////////
      child: Container(
        height: mediaQueryize.orientation == Orientation.portrait
            ? (mediaQueryize.size.height * 0.30) + 15.0
            : (mediaQueryize.size.height * 0.80) + 15.0,
        width: mediaQueryize.size.width * 0.40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            /////////// BackGround ////////////
            Positioned(
              top: 5,
              right: 0,
              left: 0,
              child: Container(
                height: mediaQueryize.orientation == Orientation.portrait
                    ? (mediaQueryize.size.height * 0.30)
                    : (mediaQueryize.size.height * 0.80),
                width: mediaQueryize.size.width * 0.40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: backgroundColor,
                ),
              ),
            ),
            /////////// Red Bannner -  Image ////////////
            const Positioned(
                top: 0,
                right: 5,
                left: 5,
                child: Padding(
                  padding: EdgeInsets.only(right: 5, left: 5, top: 0),
                  child: Image(
                    fit: BoxFit.fitWidth,
                    image: AssetImage("assets/images/banner.png"),
                  ),
                )),
            /////////// Red Bannner -  "NEW" Word ////////////
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
                              : Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: whiteColor,
                                    fontSize: 25,
                                  ))),
                )),
            /////////// Product ////////////
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /////////// Product Image ////////////
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                /////////// Product Name ////////////
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, right: 5, left: 5, bottom: 5),
                  child: Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                AddCartSecandWidget(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
