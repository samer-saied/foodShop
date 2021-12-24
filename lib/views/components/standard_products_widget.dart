import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/details/details_product_main_screen.dart';
import 'package:onlinefooddeliverysystem/views/home/components/category_products_Widget.dart';

//////////////////////////    Product Cards List     /////////////////////////////////
class ProductCardListWidget extends StatelessWidget {
  final List<ProductModel> products;
  final String currencyCode;
  final bool addCartEnabled;
  final bool dissmissEnabled;
  Function? dissmissFunc;

  ProductCardListWidget(
      {Key? key,
      required this.products,
      required this.currencyCode,
      required this.addCartEnabled,
      required this.dissmissEnabled,
      this.dissmissFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, int separator) => const Divider(),
      itemCount: products.length,
      itemBuilder: (context, int index) {
        return SingleProductCardWidget(
          product: products[index],
          currencyCode: currencyCode,
          addCartEnabled: false,
        );
      },
    );
  }
}

///////////////////////////////// Single Product Card Widget ///////////////////////////////////////

class SingleProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final String currencyCode;
  final bool addCartEnabled;
  const SingleProductCardWidget(
      {Key? key,
      required this.product,
      required this.currencyCode,
      required this.addCartEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          print("object  ${product.title}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      DetailsProductScreen(product: product)));
        },
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ////////// Title && Like Button //////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle1),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            //color: mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            ///////////////////////////////////////////////////////////////////////////////////
                            ///
                            ///
                            ///     to do
                            ///
                            ///
                            ///
                            onTap: () => print("object"),
                            child: Icon(
                              CupertinoIcons.heart,
                              color: mainColor,
                              // size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    ////////// subTitle  //////////////////
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 20),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
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
                                                fontWeight: FontWeight.normal,
                                                color: mainColor,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                      ),
                                    )
                                  : Container(),
                              Text(
                                currencyCode,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                product.currentPrice.values.first.toString(),
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                          const Spacer(),
                          ///////////   ADD to Cart Button ///////////////
                          addCartEnabled
                              ? const Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: AddCartWidget(),
                                )
                              : SizedBox(),
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
