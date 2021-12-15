import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';

import 'components/details_widgets.dart';

class DetailsProductScreen extends StatelessWidget {
  final ProductModel product;
  const DetailsProductScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation == Orientation.portrait
        ? Scaffold(
            body: Stack(
              children: [
                ImageBGWidget(
                    imageHeight: mediaQuery.size.height * .60,
                    imagewidth: mediaQuery.size.width,
                    product: product),
                ///////////////////////////  Product Details  Section //////////////////////////
                DetailsPortraitWidget(product: product, mediaQuery: mediaQuery),
                Positioned(
                    bottom: 10,
                    right: 5,
                    left: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [AddCartDetailsWidget(), AddFavDetailsWidget()],
                    ))
              ],
            ),
          )
        : Scaffold(
            backgroundColor: backgroundColor,
            body: Stack(
              children: [
                Row(
                  children: [
                    Container(
                        child: ImageBGWidget(
                            imagewidth: mediaQuery.size.width / 2,
                            imageHeight: mediaQuery.size.height,
                            product: product)),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            DetailsProductWidget(
                              product: product,
                              portrait: false,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  AddCartDetailsWidget(),
                                  AddFavDetailsWidget()
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: IconThemeData(color: mainColor),
                ),
              ],
            ),
          );
  }
}

class DetailsPortraitWidget extends StatelessWidget {
  const DetailsPortraitWidget({
    Key? key,
    required this.product,
    required this.mediaQuery,
  }) : super(key: key);

  final ProductModel product;
  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///////////////////////////  Product AppBar - Title -   //////////////////////////
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          product.title.toUpperCase(),
          style:
              Theme.of(context).textTheme.subtitle1!.copyWith(color: mainColor),
        ),
        iconTheme: IconThemeData(color: mainColor),
      ),
      backgroundColor: Colors.transparent,
      ///////////////////////////  Product Bottom Banner   //////////////////////////
      body: Container(
        height: mediaQuery.size.height,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: mediaQuery.size.height * .40,
              ),
              DetailsProductWidget(
                product: product,
                portrait: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class DetailsProductWidget extends StatefulWidget {
  final ProductModel product;
  final bool portrait;

  const DetailsProductWidget(
      {Key? key, required this.product, required this.portrait})
      : super(key: key);

  @override
  State<DetailsProductWidget> createState() => _DetailsProductWidgetState();
}

class _DetailsProductWidgetState extends State<DetailsProductWidget> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.portrait
          ? MediaQuery.of(context).size.height * .60
          : MediaQuery.of(context).size.height - 70,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15, top: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.product.title,
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            widget.product.available.isNotEmpty
                ? widget.product.available
                : " ",
            style: widget.product.available == "Out of stock"
                ? Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: mainColor)
                : Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Price : ",
                style: Theme.of(context).textTheme.headline3,
              ),
              widget.product.prePrice.containsKey(
                      widget.product.currentPrice.keys.elementAt(selected))
                  ? Row(
                      children: [
                        Text(
                          " EGP ${widget.product.prePrice.values.toString()} ",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: mainColor,
                                  decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          "  " +
                              offRate(
                                      currentNumber: double.parse(widget
                                          .product.currentPrice.values
                                          .elementAt(selected)),
                                      preNumber: double.parse(widget
                                          .product.prePrice.values
                                          .elementAt(selected)))
                                  .toString() +
                              "% off",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    )
                  : Container(),
              Spacer(),
              Text(
                "EGP " + widget.product.currentPrice.values.elementAt(selected),
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Size",
            style: Theme.of(context).textTheme.headline3,
          ),
          /////////////////  "Size" List ///////////////////////////
          Container(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.currentPrice.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = index;
                        });
                      },
                      child: Container(
                        width: 75,
                        decoration: BoxDecoration(
                          border: Border.all(color: mainColor),
                          borderRadius: BorderRadius.circular(25),
                          color: selected == index ? mainColor : whiteColor,
                        ),
                        child: Center(
                          child: Text(
                            widget.product.currentPrice.keys.elementAt(index),
                            style: selected == index
                                ? Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: whiteColor)
                                : Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: mainColor),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          ////////////////////////////////   Description   ///////////////////////////////////
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Description ",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Text(
            widget.product.description.toString(),
            style: Theme.of(context).textTheme.headline5,
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
