import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/constant/colors.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/views/app/components/app_components.dart';
import 'package:onlinefooddeliverysystem/views/components/standard_products_widget.dart';

class AllProductsWidget extends StatelessWidget {
  const AllProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top + 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ProductCardListWidget(
                        currencyCode: 'EGP',
                        products: context.read<ProductCubit>().products,
                        addCartEnabled: true,
                        dissmissEnabled: false,
                        favEnabled: true,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 10,
                    )
                  ],
                ),
              );
            },
          ),
          TitleSliderWidget(
            titleTxt: 'All Products',
            prefixIcon: SizedBox(),
            backAvaiable: true,
          ),
        ],
      ),
    );
  }
}
