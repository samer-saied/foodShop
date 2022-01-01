import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';

import 'new_product_widget.dart';
import 'product_card_widget.dart';

class GridViewCardProductWidget extends StatelessWidget {
  const GridViewCardProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryize = MediaQuery.of(context);
    ProductCubit productCubit = BlocProvider.of<ProductCubit>(context)
      ..getNewProducts()
      ..getTopProducts();

    return Container(
      height: mediaQueryize.orientation == Orientation.portrait
          ? (mediaQueryize.size.height * 0.30) + 15.0
          : (mediaQueryize.size.height * 0.70) + 15.0,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProductloadedState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  ////////////////////////     NEW PRODUCTS       /////////////////////////////////
                  Row(
                      children: productCubit.newProducts
                          .map((product) => NewProductsWidget(product: product))
                          .toList()),
                  ////////////////////////     TOP PRODUCTS       /////////////////////////////////
                  MultiCardTopProductsWidget()
                ],
              );
            }
            if (state is ProductloadingState) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: CupertinoActivityIndicator()));
            }
            return Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.exclamationmark_circle),
                    Text("No Products ,Please Select Now or Top Product"),
                  ],
                )));
          },
        ),
      ),
    );
  }
}

class MultiCardTopProductsWidget extends StatelessWidget {
  const MultiCardTopProductsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
          //width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
            ),
            itemCount: BlocProvider.of<ProductCubit>(context)
                .topProducts
                .length, //  topProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductCardWidget(
                product:
                    BlocProvider.of<ProductCubit>(context).topProducts[index],
              );
            },
          ),
        );
      },
    );
  }
}
