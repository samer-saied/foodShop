import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/app/components/single_product_card_widget.dart';

import 'components/details_components.dart';

class DetailsPortraitViewWidget extends StatelessWidget {
  final ProductModel product;
  const DetailsPortraitViewWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          /////////////////////  BACKGROUND IMAGE   /////////////////////
          ImageBGWidget(
              imageHeight: mediaQuery.size.height * .60,
              imagewidth: mediaQuery.size.width,
              product: product),
          ///////////////////////////  Product Details  Section //////////////////////////
          DetailsPortraitWidget(
            product: product,
          ),
          /////////////////////  Buttons  "ADD to cart  &&  LIKE " /////////////////////
          Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 5,
              right: 5,
              left: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: AddCartButtonWidget(
                      product: product,
                    )),
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
    );
  }
}

class DetailsPortraitWidget extends StatelessWidget {
  const DetailsPortraitWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///////////////////////////  Product AppBar - Title -   //////////////////////////
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Chip(
          backgroundColor: whiteColor,
          label: Text(
            product.title.toUpperCase(),
            //////////EDit ////////////////////////
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: mainColor),
          ),
        ),
        //////////EDit ////////////////////////
        iconTheme: IconThemeData(
          color: mainColor,
        ),
      ),
      backgroundColor: Colors.transparent,
      ///////////////////////////  Product Active Sheet   //////////////////////////
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .40,
                ),
                DataProductPortraitWidget(
                  product: product,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataProductPortraitWidget extends StatefulWidget {
  final ProductModel product;

  const DataProductPortraitWidget({Key? key, required this.product})
      : super(key: key);

  @override
  State<DataProductPortraitWidget> createState() =>
      _DataProductPortraitWidgetState();
}

class _DataProductPortraitWidgetState extends State<DataProductPortraitWidget> {
  @override
  Widget build(BuildContext context) {
    int selected = BlocProvider.of<ProductCubit>(context).selectedSize;

    return Container(
      height: MediaQuery.of(context).size.height * .60,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: mainColor.withOpacity(0.20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15, top: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ///////////////////////       Product Title    //////////////////////////////////
          Text(
            widget.product.title,
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(
            height: 5,
          ),
          ///////////////////////       Product Avaiable    //////////////////////////////////
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
          SizedBox(
            height: 15,
          ),
          ///////////////////////       Product Price    //////////////////////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Price : ",
                style: Theme.of(context).textTheme.headline3,
              ),
              widget.product.prePrice.containsKey(widget
                      .product.currentPrice.keys
                      .elementAt(selected)
                      .isNotEmpty)
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
          ////////////////////////////////    "Size" List     ///////////////////////////
          SizedBox(
            height: 15,
          ),
          Text(
            "Size :",
            style: Theme.of(context).textTheme.headline3,
          ),
          Container(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.currentPrice.length,
                itemBuilder: (context, index) {
                  // BlocProvider.of<ProductCubit>(context).selectedSize =
                  //     selected;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = index;
                          BlocProvider.of<ProductCubit>(context).selectedSize =
                              index;
                          print(selected);
                          print(BlocProvider.of<ProductCubit>(context)
                              .selectedSize);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: mainColor),
                          borderRadius: BorderRadius.circular(25),
                          color: selected == index ? mainColor : whiteColor,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            child: Text(
                              widget.product.currentPrice.keys.elementAt(index),
                              style: selected == index
                                  ? Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: whiteColor)
                                  : Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: mainColor,
                                          fontWeight: FontWeight.normal),
                            ),
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
              "Description :",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Text(
            " ${widget.product.description}",
            style: Theme.of(context).textTheme.headline5,
          ),
        ]),
      ),
    );
  }
}

///////////////////////      ScrollBehavior     ////////////////////////////////
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
