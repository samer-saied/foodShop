import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/views/home/components/category_products_Widget.dart';

class AllProductsWidget extends StatelessWidget {
  const AllProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "All Products",
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: whiteColor),
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ProductCardListWidget(
                currencyCode: 'EGP',
                products: context.read<ProductCubit>().products,
              ),
            ),
          );
        },
      ),
    );
  }
}
