import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/category/category_cubit.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/views/components/standard_products_widget.dart';

class CategoryProductsWidget extends StatelessWidget {
  const CategoryProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductCubit productCubit = BlocProvider.of<ProductCubit>(context);

    return BlocListener<ProductCubit, ProductState>(
        listener: (context, state) {
          if (state is ProductloadedState) {
            print("--------------Products-done---------------");
            productCubit.getSelectedProduct(
                categoryId:
                    BlocProvider.of<CategoryCubit>(context).selectedItem);
          }
        },
        child: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (BlocProvider.of<ProductCubit>(context)
                .selectedProduct
                .isEmpty) {
              productCubit.getSelectedProduct(
                  categoryId:
                      BlocProvider.of<CategoryCubit>(context).selectedItem);
            }
          },
          builder: (context, state) {
            if ((state is CategorychangeLoadedSuccessState ||
                    state is CategoryLoadedSuccessState) &&
                productCubit.selectedProduct.isNotEmpty) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ProductCardListWidget(
                  currencyCode: "EGP",
                  products: productCubit.selectedProduct,
                  addCartEnabled: true,
                  dissmissEnabled: false,
                  favEnabled: true,
                ),
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

            return Center(child: CupertinoActivityIndicator());
          },
        ));
  }
}

//////////////////////////    Add to Cart Button   1   /////////////////////////////////
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
            vertical: 6,
            horizontal: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.cart_badge_plus,
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

//////////////////////////    Add to Cart Secand Button    2  /////////////////////////////////
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

//////////////////////////    Add to Cart Button  3   /////////////////////////////////
class AddCartThirdWidget extends StatelessWidget {
  const AddCartThirdWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 30,
      child: CupertinoButton(
          color: mainColor,
          child: Text(
            "Samer",
            style: TextStyle(color: whiteColor),
          ),
          onPressed: () {
            print("add to cart 2");
          }),
    );
  }
}
