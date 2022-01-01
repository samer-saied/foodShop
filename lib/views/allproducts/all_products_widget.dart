import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinefooddeliverysystem/controllers/product/product_cubit.dart';
import 'package:onlinefooddeliverysystem/views/app/components/app_components.dart';
import 'package:onlinefooddeliverysystem/views/app/components/single_product_card_widget.dart';

class AllProductsWidget extends StatelessWidget {
  const AllProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).padding.top + 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SingleProductCardWidget(
                                currencyCode: 'EGP',
                                favEnabled: true,
                                product: context
                                    .read<ProductCubit>()
                                    .products[index],
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount:
                                context.read<ProductCubit>().products.length),
                      ),
                    ],
                  ),
                );
              },
            ),
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
