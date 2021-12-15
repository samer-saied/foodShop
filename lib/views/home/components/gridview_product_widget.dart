import 'package:flutter/material.dart';

import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/home/components/new_product_widget.dart';

import 'product_card_widget.dart';

ProductModel tempProduct = ProductModel(
    productId: "productId",
    categoryId: "categoryId",
    currentPrice: {"small": "99"},
    prePrice: {"small": "99"},
    status: "new",
    imageUrl:
        "https://storage.eu.content-cdn.io/cdn-cgi/image/width=300,height=300,quality=75,format=auto,fit=cover,g=top/am-resources/b43a9bb3-260a-4e1f-9be6-65a809fab6e1/Images/ProductImages/Source/Eg-Mnstr-cmbo.png",
    title: "title Sandwitch fdfd",
    available: "Out of Test",
    description: "description  alot of some word here");

class GridViewCardProductWidget extends StatelessWidget {
  const GridViewCardProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryize = MediaQuery.of(context);

    return Container(
      height: mediaQueryize.orientation == Orientation.portrait
          ? (mediaQueryize.size.height * 0.30) + 15.0
          : (mediaQueryize.size.height * 0.80) + 15.0,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: [
          NewProductsWidget(product: tempProduct),
          NewProductsWidget(product: tempProduct),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: GridView.builder(
                itemCount: 10,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .65,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return ProductCardWidget(product: tempProduct);
                }),
          ),
        ],
      ),
    );
  }
}
