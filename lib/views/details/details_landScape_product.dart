import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/app/components/single_product_card_widget.dart';

import 'components/details_components.dart';

class DetailsLandscapeProductView extends StatelessWidget {
  final ProductModel product;

  const DetailsLandscapeProductView({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          ////////////////////////////////  BACKGROUND IMAGE   /////////////////////////////////////////////
          Positioned(
            left: 0,
            bottom: 0,
            top: 0,
            child: Container(
                child: ImageBGWidget(
                    imagewidth: mediaQuery.size.width / 2,
                    imageHeight: mediaQuery.size.height,
                    product: product)),
          ),
          ///////////////////////////  Product AppBar - Without Title - //////////////////////////
          AppBar(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),
              ),
            ),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: mainColor,
            ),
          ),
          ///////////////////////////  Product Details  Section //////////////////////////
          Positioned(
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            top: 0,
            child: Stack(
              children: [
                Container(
                  width: mediaQuery.size.width * .52,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(color: mainColor.withOpacity(0.20)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 0.20,
                          spreadRadius: 5.0,
                          offset: Offset(5, 1))
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: DataProductLandscapeWidget(
                      product: product,
                    ),
                  ),
                ),
                ///////////////////////////  buttons  Section //////////////////////////
                Positioned(
                    bottom: 8, //MediaQuery.of(context).padding.bottom + 5,
                    right: 5,
                    left: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: AddCartButtonWidget(
                              product: product,
                            ),
                            flex: 4,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: mainColor,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: HeartFavButtonWidget(
                                productID: product.productId,
                                heartSize: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DataProductLandscapeWidget extends StatefulWidget {
  final ProductModel product;

  DataProductLandscapeWidget({Key? key, required this.product})
      : super(key: key);

  @override
  _DataProductLandscapeWidgetState createState() =>
      _DataProductLandscapeWidgetState();
}

class _DataProductLandscapeWidgetState
    extends State<DataProductLandscapeWidget> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    ///////////////////////////  Product Active Sheet   //////////////////////////
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15, top: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ///////////////////////       Product Title    ///////////////////////////////////
          Text(
            widget.product.title.toUpperCase(),
            style: Theme.of(context).textTheme.headline3,
          ),
          ///////////////////////       Product Avaiable    ///////////////////////////////////
          SizedBox(
            height: 5,
          ),
          Text(
            widget.product.available.isNotEmpty
                ? " ${widget.product.available}"
                : "",
            style: widget.product.available == "Out of stock"
                ? Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: mainColor)
                : Theme.of(context).textTheme.headline5,
          ),
          ///////////////////////       Product Price    ///////////////////////////////////
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
                          " EGP ${widget.product.prePrice[widget.product.currentPrice.keys.elementAt(selected)]} ",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: mainColor,
                                  decoration: TextDecoration.lineThrough),
                        ),
                        Text(
                          "  " +
                              offRate(
                                      currentNumber: double.tryParse(widget
                                              .product.currentPrice.values
                                              .elementAt(selected)) ??
                                          0,
                                      preNumber: double.tryParse(
                                              widget.product.prePrice[widget
                                                  .product.currentPrice.keys
                                                  .elementAt(selected)]) ??
                                          0)
                                  .toString() +
                              "% off",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: greyColor),
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
          ////////////////////////////////    "Size" List     ///////////////////////////////////
          SizedBox(
            height: 15,
          ),
          Text(
            "Size",
            style: Theme.of(context).textTheme.headline3,
          ),
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
                          print(index);
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
            padding: const EdgeInsets.only(bottom: 5.0),
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
