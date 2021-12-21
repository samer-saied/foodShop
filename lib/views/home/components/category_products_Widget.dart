import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/category/category_cubit.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/models/product_model.dart';
import 'package:onlinefooddeliverysystem/views/details/details_product_main_screen.dart';

class CategoryProductsWidget extends StatelessWidget {
  const CategoryProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductCubit productCubit = BlocProvider.of<ProductCubit>(context);

    return BlocListener<ProductCubit, ProductState>(listener: (context, state) {
      if (state is ProductloadedState) {
        print("--------------Products-done---------------");
        productCubit.getSelectedProduct(
            categoryId: BlocProvider.of<CategoryCubit>(context).selectedItem);
      }
    }, child: BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if ((state is CategorychangeLoadedSuccessState ||
                state is CategoryLoadedSuccessState) &&
            productCubit.selectedProduct.isNotEmpty) {
          return ProductCardListWidget(
            currencyCode: "EGP",
            products: productCubit.selectedProduct,
          );
        }
        if (productCubit.selectedProduct.isEmpty) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.exclamationmark_circle),
                  Text("No Products for selected Category.."),
                ],
              ),
            ),
          );
        }

        return CupertinoActivityIndicator();
      },
    ));
  }
}

//////////////////////////    Add to Cart Button      /////////////////////////////////
class AddCartWidget extends StatelessWidget {
  const AddCartWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("add to cart");
      },
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_cart,
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

//////////////////////////    Add to Cart Secand Button      /////////////////////////////////
class AddCartSecandWidget extends StatelessWidget {
  const AddCartSecandWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Text("add to cart",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: mainColor)),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////    Product Card List     /////////////////////////////////
class ProductCardListWidget extends StatelessWidget {
  final List<ProductModel> products;
  final String currencyCode;
  const ProductCardListWidget(
      {Key? key, required this.products, required this.currencyCode})
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            onTap: () {
              print("object  $index");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailsProductScreen(product: products[index])));
            },
            child: Container(
              height: 100,
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
                      height: 100,
                      width: MediaQuery.of(context).size.width * .25,
                      imageUrl: products[index].imageUrl,
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
                            Text(products[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.subtitle1),
                            InkWell(
                              onTap: () {
                                print("like");
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  //color: mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: mainColor,
                                  size: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                        ////////// subTitle  //////////////////
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 20),
                            child: Text(products[index].description.toString(),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: greyColor)),
                          ),
                        ),
                        /////////   Price && add to cart ////////////////
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                (products[index].prePrice.values.isNotEmpty)
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Text(
                                          "$currencyCode " +
                                              products[index]
                                                  .prePrice
                                                  .values
                                                  .first +
                                              " ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  color: mainColor,
                                                  decoration: TextDecoration
                                                      .lineThrough),
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
                                  products[index]
                                      .currentPrice
                                      .values
                                      .first
                                      .toString(),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ],
                            ),
                            const Spacer(),
                            ///////////   ADD to Cart Button ///////////////
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: AddCartWidget(),
                            ),
                          ],
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
      },
    );
  }
}
