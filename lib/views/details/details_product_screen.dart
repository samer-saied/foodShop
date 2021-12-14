import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/home/components/label_title_widget.dart';

class DetailsProductScreen extends StatelessWidget {
  final ProductModel product;
  const DetailsProductScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: whiteColor,
      width: mediaQuery.size.width,
      child: Stack(
        children: [
          ///////////////////////////  Product Image  //////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: mediaQuery.padding.top, right: 0, left: 0),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.cover,
                  width: mediaQuery.size.width,
                ),
              )
            ],
          ),
          ///////////////////////////  Product Details  Section //////////////////////////
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                ///////////////////////////  Product AppBar - Title -   //////////////////////////
                AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    product.title.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: mainColor),
                  ),
                  iconTheme: IconThemeData(color: mainColor),
                ),
                ///////////////////////////  White Space  //////////////////////////

                Spacer(),
                ///////////////////////////  Details  //////////////////////////
                DetailsProductWidget(
                  product: product,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DetailsProductWidget extends StatelessWidget {
  final ProductModel product;
  const DetailsProductWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: mediaQuery.size.height * .55,
      // width: mediaQuery.size.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15, top: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            product.available.isNotEmpty ? product.available : " ",
            style: product.available == "Out of stock"
                ? Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: mainColor)
                : Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                " EGP " + product.prePrice.toString() + " ",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: mainColor, decoration: TextDecoration.lineThrough),
              ),
              Text(
                "  " +
                    offRate(
                            currentNumber: double.parse(product.currentPrice),
                            preNumber: double.parse(product.prePrice))
                        .toString() +
                    "% off",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Spacer(),
              Text(
                "EGP " + product.currentPrice.toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Description ",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Text(
            "EGP " + product.description.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 75,
          ),
        ]),
      ),
    );
  }
}

offRate({required double preNumber, required double currentNumber}) {
  return (((preNumber - currentNumber) / currentNumber) * 100)
      .ceil()
      .toString();
}
